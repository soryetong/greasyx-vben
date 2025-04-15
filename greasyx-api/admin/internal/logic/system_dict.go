package logic

import (
	"context"
	"greasyx-api/admin/internal/types"
	"greasyx-api/models"

	"github.com/jinzhu/copier"
	"github.com/soryetong/greasyx/gina"
	"github.com/soryetong/greasyx/modules/dbmodule"
)

type SystemDictLogic struct {
}

func NewSystemDictLogic() *SystemDictLogic {
	return &SystemDictLogic{}
}

func (self *SystemDictLogic) Add(ctx context.Context, params *types.UpsertDictReq) (err error) {
	data := new(models.SysDicts)
	_ = copier.Copy(data, params)
	err = gina.GMySQL().Model(&models.SysDicts{}).Create(data).Error

	return
}

func (self *SystemDictLogic) List(ctx context.Context, params *types.DictListReq) (resp *types.DictListResp, err error) {
	resp = &types.DictListResp{}

	query := gina.GMySQL().Model(&models.SysDicts{}).Order("id desc")
	if params.DictName != "" {
		query.Where("dict_name like ?", params.DictName+"%")
	}
	if params.DictType != "" {
		query.Where("dict_type like ?", params.DictType+"%")
	}
	if params.Status > 0 {
		query.Where("status = ?", params.Status)
	}
	if err = query.Count(&resp.Total).Error; err != nil {
		return
	}

	var list []*models.SysDicts
	if err = query.Scopes(dbmodule.GormPaginate(params.Page, params.PageSize)).Find(&list).Error; err != nil {
		return
	}

	items := make([]*types.DictInfoResp, 0)
	for _, info := range list {
		item := new(types.DictInfoResp)
		_ = copier.Copy(item, info)
		item.CreatedAt = info.CreatedAt.UnixMilli()
		items = append(items, item)
	}
	resp.Items = items

	return
}

func (self *SystemDictLogic) Update(ctx context.Context, id int64, params *types.UpsertDictReq) (err error) {
	err = gina.GMySQL().Model(&models.SysDicts{}).Where("id = ?", id).
		Updates(map[string]interface{}{
			"dict_name":  params.DictName,
			"dict_type":  params.DictType,
			"status":     params.Status,
			"item_key":   params.ItemKey,
			"item_value": params.ItemValue,
			"sort":       params.Sort,
			"remark":     params.Remark,
		}).Error

	return
}

func (self *SystemDictLogic) Delete(ctx context.Context, id int64) (err error) {
	err = gina.GMySQL().Delete(&models.SysDicts{}, "id = ?", id).Error

	return
}
