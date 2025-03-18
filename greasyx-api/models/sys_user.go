package models

const (
	SysUserStatusNormal  = 1
	SysUserStatusDisable = 2
)

// SysUsers 系统用户表
type SysUsers struct {
	GnModel
	Username      string `json:"username" gorm:"username"`             // 用户名
	Nickname      string `json:"nickname" gorm:"nickname"`             // 用户昵称
	Password      string `json:"password" gorm:"password"`             // 密码
	Salt          string `json:"salt" gorm:"salt"`                     // 加密盐
	Mobile        string `json:"mobile" gorm:"mobile"`                 // 手机号
	Gender        int64  `json:"gender" gorm:"gender"`                 // 性别(1-男 2-女 0-保密)
	Email         string `json:"email" gorm:"email"`                   // 邮箱
	Avatar        string `json:"avatar" gorm:"avatar"`                 // 头像
	Status        int64  `json:"status" gorm:"status"`                 // 状态 1:正常,2:禁用
	DeptId        int64  `json:"deptId" gorm:"dept_id"`                // 部门ID
	RoleId        int64  `json:"roleId" gorm:"role_id"`                // 角色ID
	Remark        string `json:"remark" gorm:"remark"`                 // 备注
	CreateBy      int64  `json:"createBy" gorm:"create_by"`            // 创建者ID
	UpdateBy      int64  `json:"updateBy" gorm:"update_by"`            // 更新者ID
	LastLoginTime int64  `json:"lastLoginTime" gorm:"last_login_time"` // 最后一次登录的时间
	LastLoginIp   string `json:"lastLoginIp" gorm:"last_login_ip"`     // 最后一次登录的IP

	SysRole SysRoles `json:"sysRole" gorm:"foreignKey:RoleId;references:Id"`
}

// TableName 表名称
func (*SysUsers) TableName() string {
	return "sys_users"
}
