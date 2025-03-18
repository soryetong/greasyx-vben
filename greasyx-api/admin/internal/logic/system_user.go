package logic

import (
	"context"
	"errors"
	"fmt"
	"greasyx-api/admin/internal/types"
	"greasyx-api/models"

	"github.com/jinzhu/copier"
	"github.com/soryetong/greasyx/gina"
	"github.com/soryetong/greasyx/helper"
	"github.com/soryetong/greasyx/libs/auth"
	"github.com/soryetong/greasyx/modules/mysqlmodule"
)

type SystemUserLogic struct {
}

func NewSystemUserLogic() *SystemUserLogic {
	return &SystemUserLogic{}
}

func (self *SystemUserLogic) Info(ctx context.Context) (resp *types.UserInfoResp, err error) {
	user := models.SysUsers{}
	if err = gina.Db.Where("id = ?", auth.GetTokenData[int64](ctx, "id")).First(&user).Error; err != nil {
		return
	}
	resp = new(types.UserInfoResp)
	_ = copier.Copy(resp, user)
	resp.RoleName = user.SysRole.Name
	resp.RealName = user.Username

	// 获取角色信息
	info, err := new(SystemRoleLogic).Info(ctx, user.RoleId)
	if err != nil {
		return
	}

	// 获取权限
	var results []models.SysMenus
	if err = gina.Db.Model(&models.SysMenus{}).
		Select("perm").
		Where("type = ?", "BUTTON").
		Where("id IN ?", info.AuthId).
		Find(&results).Error; err != nil {
		return
	}
	for _, item := range results {
		resp.Permissions = append(resp.Permissions, item.Perm)
	}

	return
}

func (self *SystemUserLogic) UserByName(username string) (user models.SysUsers, err error) {
	user = models.SysUsers{}
	err = gina.Db.Where("username = ?", username).First(&user).Error
	// todo 头像
	// user.Avatar = utils.TransformImageUrl(user.Avatar)

	return
}

func (self *SystemUserLogic) Add(ctx context.Context, params *types.UpsertUserReq) (err error) {
	if params.Password == "" {
		params.Password = "123456"
	}

	username := params.Username
	if u, _ := self.UserByName(username); u.Id != 0 {
		return fmt.Errorf("用户已存在！")
	}

	salt := helper.RandString(6)
	err = gina.Db.Create(&models.SysUsers{
		Username: username,
		Salt:     salt,
		Password: helper.MakePasswd(params.Password, salt),
		Nickname: params.Nickname,
		Avatar:   "/uploads/default/logo.png",
		Status:   params.Status,
		Mobile:   params.Mobile,
		Email:    params.Email,
		Remark:   params.Remark,
		RoleId:   params.RoleId,
		CreateBy: auth.GetTokenData[int64](ctx, "id"),
	}).Error

	return
}

func (self *SystemUserLogic) List(ctx context.Context, params *types.UserListReq) (resp *types.UserListResp, err error) {
	resp = &types.UserListResp{}

	query := gina.Db.Model(&models.SysUsers{}).Order("id desc").Preload("SysRole")
	if params.Username != "" {
		query.Where("username like ?", params.Username+"%")
	}
	if params.Status > 0 {
		query.Where("status = ?", params.Status)
	}
	if err = query.Count(&resp.Total).Error; err != nil {
		return
	}

	var list []*models.SysUsers
	if err = query.Scopes(mysqlmodule.Paginate(params.Page, params.PageSize)).Find(&list).Error; err != nil {
		return
	}

	items := make([]*types.UserInfoResp, 0)
	for _, info := range list {
		item := new(types.UserInfoResp)
		_ = copier.Copy(item, info)
		item.RoleName = info.SysRole.Name
		item.CreatedAt = info.CreatedAt.UnixMilli()
		items = append(items, item)
	}
	resp.Items = items

	return
}

func (self *SystemUserLogic) Update(ctx context.Context, id int64, params *types.UpsertUserReq) (err error) {
	user := models.SysUsers{}
	if err = gina.Db.First(&user, id).Error; err != nil {
		return err
	}

	if user.Username != params.Username {
		var count int64
		gina.Db.Model(&models.SysUsers{}).Where("username = ?", params.Username).Count(&count)
		if count >= 1 {
			return errors.New("用户已存在")
		}
	}

	uMap := map[string]interface{}{
		"username":  params.Username,
		"nickname":  params.Nickname,
		"role_id":   params.RoleId,
		"status":    params.Status,
		"mobile":    params.Mobile,
		"email":     params.Email,
		"remark":    params.Remark,
		"update_by": auth.GetTokenData[int64](ctx, "id"),
	}
	if len(params.Password) > 0 {
		newSalt := helper.RandString(6)
		uMap["salt"] = newSalt
		uMap["password"] = helper.MakePasswd(params.Password, newSalt)
	}

	err = gina.Db.Model(&models.SysUsers{}).Where("id = ?", id).Updates(uMap).Error

	return
}

func (self *SystemUserLogic) Delete(ctx context.Context, id int64) (err error) {
	err = gina.Db.Delete(&models.SysUsers{}, "id = ?", id).Error

	return
}
