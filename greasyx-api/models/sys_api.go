package models

// SysApis 接口管理
type SysApis struct {
	GnModel
	ParentId    int64  `json:"parentId" gorm:"parent_id"`      // 父ID
	Description string `json:"description" gorm:"description"` // 描述
	Method      string `json:"method" gorm:"method"`           // 请求方法
	Path        string `json:"path" gorm:"path"`               // 请求路径
}

// TableName 表名称
func (*SysApis) TableName() string {
	return "sys_apis"
}
