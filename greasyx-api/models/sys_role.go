package models

// SysRoles 角色管理
type SysRoles struct {
	GnModel
	Name   string `json:"name" gorm:"name"`     // 角色名称
	Code   string `json:"code" gorm:"code"`     // 角色编码
	Sort   int64  `json:"sort" gorm:"sort"`     // 排序
	Status int64  `json:"status" gorm:"status"` // 状态（1-显示 2-隐藏）
	Remark string `json:"remark" gorm:"remark"` // 备注

	RoleAuths []SysRoleAuths `gorm:"foreignKey:RoleId;references:Id"`
	RoleApis  []SysRoleApis  `gorm:"foreignKey:RoleId;references:Id"`
}

// TableName 表名称
func (*SysRoles) TableName() string {
	return "sys_roles"
}
