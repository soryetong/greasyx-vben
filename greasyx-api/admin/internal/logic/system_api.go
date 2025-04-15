package logic

import (
	"context"
	"fmt"
	"greasyx-api/admin/internal/types"
	"greasyx-api/models"

	"github.com/jinzhu/copier"
	"github.com/soryetong/greasyx/gina"
	"go.uber.org/zap"
)

var apiInfoMap = make(map[string]*models.SysApis)
var recordUseApiInfoMap = make(map[string]*models.SysApis)

type SystemApiLogic struct {
}

func NewSystemApiLogic() *SystemApiLogic {
	return &SystemApiLogic{}
}

func (self *SystemApiLogic) Add(ctx context.Context, params *types.UpsertApiReq) (err error) {
	var has int64
	gina.GMySQL().Model(&models.SysApis{}).Where("parent_id != ?", 0).Where("path = ?", params.Path).Count(&has)
	if has > 0 {
		return fmt.Errorf("API已存在！")
	}

	err = gina.GMySQL().Create(&models.SysApis{
		ParentId:    params.ParentId,
		Description: params.Description,
		Method:      params.Method,
		Path:        params.Path,
	}).Error

	return
}

func (self *SystemApiLogic) List(ctx context.Context, params *types.ApiListReq) (resp *types.ApiListResp, err error) {
	resp = &types.ApiListResp{}
	query := gina.GMySQL().Model(&models.SysApis{})
	if params.Description != "" {
		query.Where("description like ?", params.Description+"%")
	}
	if params.Path != "" {
		query.Where("path = ?", params.Path)
	}
	if params.OnlyParent {
		query.Where("parent_id = ?", 0)
	}

	var list []*models.SysApis
	if err = query.Find(&list).Error; err != nil {
		return
	}

	items := make([]*types.ApiInfoResp, 0)
	for _, info := range list {
		item := new(types.ApiInfoResp)
		_ = copier.Copy(item, info)
		item.CreatedAt = info.CreatedAt.UnixMilli()
		items = append(items, item)
	}
	if params.OnlyParent {
		items = append(items, &types.ApiInfoResp{
			Id:          0,
			CreatedAt:   0,
			ParentId:    0,
			Description: "根API",
			Method:      "",
			Path:        "",
		})
	}
	resp.Items = items
	resp.Total = int64(len(items))

	return
}

func (self *SystemApiLogic) Update(ctx context.Context, id int64, params *types.UpsertApiReq) (err error) {
	var has int64
	gina.GMySQL().Model(&models.SysApis{}).Where("parent_id != ?", 0).Where("path = ?", params.Path).Count(&has)
	if has > 0 {
		return fmt.Errorf("API已存在！")
	}

	err = gina.GMySQL().Model(&models.SysApis{}).Where("id = ?", id).
		Updates(map[string]interface{}{
			"parent_id":   params.ParentId,
			"description": params.Description,
			"method":      params.Method,
			"path":        params.Path,
		}).Error

	return
}

func (self *SystemApiLogic) Delete(ctx context.Context, id int64) (err error) {
	var count int64
	gina.GMySQL().Where("api_id", id).Model(&models.SysRoleApis{}).Count(&count)
	if count > 0 {
		return fmt.Errorf("请先删除角色API权限后再操作")
	}

	err = gina.GMySQL().Delete(&models.SysApis{}, "id = ?", id).Error

	return
}

func (self *SystemApiLogic) CacheApiInfo() {
	var list []*models.SysApis
	if err := gina.GMySQL().Model(&models.SysApis{}).Find(&list).Error; err != nil {
		gina.Log.Error("[CacheApiInfo]获取API信息失败！", zap.Error(err))
		return
	}

	for _, item := range list {
		apiInfoMap[item.Path] = item
		recordUseApiInfoMap[fmt.Sprintf("%s_%s", item.Path, item.Method)] = item
	}
}

func (self *SystemApiLogic) GetRecordDescription(path, method string) string {
	info, ok := recordUseApiInfoMap[fmt.Sprintf("%s_%s", path, method)]
	if !ok {
		return ""
	}

	return info.Description
}
