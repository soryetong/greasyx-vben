package logic

import (
	"context"
	"greasyx-api/admin/internal/types"
	"greasyx-api/models"

	"github.com/jinzhu/copier"
	"github.com/soryetong/greasyx/gina"
	"github.com/soryetong/greasyx/modules/dbmodule"
)

type SystemRecordLogic struct {
}

func NewSystemRecordLogic() *SystemRecordLogic {
	return &SystemRecordLogic{}
}

func (self *SystemRecordLogic) List(ctx context.Context, params *types.RecordListReq) (resp *types.RecordListResp, err error) {
	resp = &types.RecordListResp{}

	query := gina.GMySQL().Model(&models.SysRecords{}).Order("id desc")
	if params.Username != "" {
		query.Where("username like ?", params.Username+"%")
	}
	if len(params.CreateTime) > 0 {
		query.Where("created_at between ? and ?", params.CreateTime[0], params.CreateTime[1])
	}
	if err = query.Count(&resp.Total).Error; err != nil {
		return
	}

	var list []*models.SysRecords
	if err = query.Scopes(dbmodule.GormPaginate(params.Page, params.PageSize)).Find(&list).Error; err != nil {
		return
	}

	items := make([]*types.RecordInfoResp, 0)
	for _, info := range list {
		item := new(types.RecordInfoResp)
		_ = copier.Copy(item, info)
		item.CreatedAt = info.CreatedAt.UnixMilli()
		items = append(items, item)
	}
	resp.Items = items

	return
}

func (self *SystemRecordLogic) Delete(ctx context.Context, id int64) (err error) {
	err = gina.GMySQL().Delete(&models.SysRecords{}, "id = ?", id).Error

	return
}
