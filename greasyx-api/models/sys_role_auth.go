package models

// SysRoleAuths 角色菜单权限
type SysRoleAuths struct {
	GnModel
	RoleId int64 `json:"roleId" gorm:"role_id"` // sys_roles表Id
	AuthId int64 `json:"authId" gorm:"auth_id"` // sys_menus表Id
}

// TableName 表名称
func (*SysRoleAuths) TableName() string {
	return "sys_role_auths"
}
