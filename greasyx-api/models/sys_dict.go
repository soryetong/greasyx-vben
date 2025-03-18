package models

// SysDicts 数据字典
type SysDicts struct {
	GnModel
	DictName  string `json:"dictName" gorm:"dict_name"`   // 字典名称
	DictType  string `json:"dictType" gorm:"dict_type"`   // 字典类型
	ItemKey   string `json:"itemKey" gorm:"item_key"`     // 字典编码
	ItemValue string `json:"itemValue" gorm:"item_value"` // 字典值
	Sort      int64  `json:"sort" gorm:"sort"`            // 排序
	Status    int64  `json:"status" gorm:"status"`        // 状态（1-显示 2-隐藏）
	Remark    string `json:"remark" gorm:"remark"`        // 备注
}

// TableName 表名称
func (*SysDicts) TableName() string {
	return "sys_dicts"
}
