package models

// SysRoleApis 角色接口权限
type SysRoleApis struct {
	GnModel
	RoleId int64 `json:"roleId" gorm:"role_id"` // sys_roles表Id
	ApiId  int64 `json:"apiId" gorm:"api_id"`   // sys_apis表Id
}

// TableName 表名称
func (*SysRoleApis) TableName() string {
	return "sys_role_apis"
}
