package logic

import (
	"context"
	"fmt"
	"greasyx-api/admin/internal/types"
	"greasyx-api/models"

	gormadapter "github.com/casbin/gorm-adapter/v3"
	"github.com/jinzhu/copier"
	"github.com/soryetong/greasyx/gina"
	"github.com/soryetong/greasyx/modules/casbinmodule"
	"github.com/soryetong/greasyx/modules/dbmodule"
	"gorm.io/gorm"
)

type SystemRoleLogic struct {
}

func NewSystemRoleLogic() *SystemRoleLogic {
	return &SystemRoleLogic{}
}

func (self *SystemRoleLogic) Add(ctx context.Context, params *types.UpsertRoleReq) (err error) {
	var has int64
	gina.GMySQL().Model(&models.SysRoles{}).Where("code = ?", params.Code).Count(&has)
	if has > 0 {
		return fmt.Errorf("角色已存在！")
	}

	err = gina.GMySQL().Create(&models.SysRoles{
		Name:   params.Name,
		Code:   params.Code,
		Status: params.Status,
		Remark: params.Remark,
		Sort:   params.Sort,
	}).Error

	return
}

func (self *SystemRoleLogic) List(ctx context.Context, params *types.RoleListReq) (resp *types.RoleListResp, err error) {
	resp = &types.RoleListResp{}

	query := gina.GMySQL().Model(&models.SysRoles{}).Order("id asc")
	if params.Name != "" {
		query.Where("name like ?", params.Name+"%")
	}
	if params.Status > 0 {
		query.Where("status = ?", params.Status)
	}
	if err = query.Count(&resp.Total).Error; err != nil {
		return
	}

	var list []*models.SysRoles
	if err = query.Scopes(dbmodule.GormPaginate(params.Page, params.PageSize)).Find(&list).Error; err != nil {
		return
	}

	items := make([]*types.RoleInfoResp, 0)
	for _, info := range list {
		item := new(types.RoleInfoResp)
		_ = copier.Copy(item, info)
		item.CreatedAt = info.CreatedAt.UnixMilli()
		items = append(items, item)
	}
	resp.Items = items

	return
}

func (self *SystemRoleLogic) Update(ctx context.Context, id int64, params *types.UpsertRoleReq) (err error) {
	err = gina.GMySQL().Model(&models.SysRoles{}).Where("id = ?", id).
		Updates(map[string]interface{}{
			"name":   params.Name,
			"code":   params.Code,
			"sort":   params.Sort,
			"status": params.Status,
			"remark": params.Remark,
		}).Error

	return
}

func (self *SystemRoleLogic) deleteRoleAuth(ctx context.Context, tx *gorm.DB, id int64) (err error) {
	if err = tx.Where("role_id = ?", id).Unscoped().Delete(&models.SysRoleAuths{}).Error; err != nil {
		return
	}

	err = tx.Where("role_id = ?", id).Unscoped().Delete(&models.SysRoleApis{}).Error

	return
}

func (self *SystemRoleLogic) Delete(ctx context.Context, id int64) (err error) {
	err = gina.GMySQL().Transaction(func(tx *gorm.DB) error {
		if err = tx.Delete(&models.SysRoles{}, "id = ?", id).Error; err != nil {
			return err
		}

		return self.deleteRoleAuth(ctx, tx, id)
	})

	return
}

func (self *SystemRoleLogic) Assign(ctx context.Context, id int64, params *types.AssignRoleReq) (err error) {
	var casbinInfos []casbinmodule.CasbinInfo
	err = gina.GMySQL().Transaction(func(tx *gorm.DB) error {
		if err = self.deleteRoleAuth(ctx, tx, id); err != nil {
			return err
		}

		if err = tx.Where("v0 = ?", id).Unscoped().Delete(&gormadapter.CasbinRule{}).Error; err != nil {
			return err
		}

		var roleAuths []models.SysRoleAuths
		for _, authId := range params.AuthId {
			roleAuths = append(roleAuths, models.SysRoleAuths{
				RoleId: id,
				AuthId: authId,
			})
		}
		if err = tx.Model(&models.SysRoleAuths{}).Create(&roleAuths).Error; err != nil {
			return err
		}

		var apis []models.SysApis
		if err = tx.Model(&models.SysApis{}).Where("id in ?", params.ApiId).Find(&apis).Error; err != nil {
			return err
		}

		var roleApis []models.SysRoleApis
		for _, api := range apis {
			roleApis = append(roleApis, models.SysRoleApis{
				RoleId: id,
				ApiId:  api.Id,
			})

			if api.Path != "" {
				casbinInfos = append(casbinInfos, casbinmodule.CasbinInfo{
					Path:   api.Path,
					Method: api.Method,
				})
			}
		}

		return tx.Create(&roleApis).Error
	})

	if err == nil {
		err = casbinmodule.UpsertCasbin(ctx, id, casbinInfos)
	}

	return
}

func (self *SystemRoleLogic) Info(ctx context.Context, id int64) (resp *types.RoleInfoResp, err error) {
	role := &models.SysRoles{}
	if err = gina.GMySQL().Preload("RoleAuths").Preload("RoleApis").First(&role, id).Error; err != nil {
		return
	}

	resp = &types.RoleInfoResp{}
	_ = copier.Copy(resp, role)
	for _, auth := range role.RoleAuths {
		resp.AuthId = append(resp.AuthId, auth.AuthId)
	}
	for _, api := range role.RoleApis {
		resp.ApiId = append(resp.ApiId, api.ApiId)
	}

	return resp, nil
}
