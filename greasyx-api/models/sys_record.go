package models

// SysRecords 操作日志
type SysRecords struct {
	GnModel
	Username    string `json:"username" gorm:"username"`       // 用户名
	UserId      int64  `json:"userId" gorm:"user_id"`          // 用户ID
	Description string `json:"description" gorm:"description"` // 描述
	Method      string `json:"method" gorm:"method"`           // 请求方法
	Path        string `json:"path" gorm:"path"`               // 请求路径
	StatusCode  int64  `json:"statusCode" gorm:"status_code"`  // 状态码
	Elapsed     string `json:"elapsed" gorm:"elapsed"`         // 耗时
	Msg         string `json:"msg" gorm:"msg"`                 // 返回的msg
	Request     string `json:"request" gorm:"request"`         // 请求参数
	Response    string `json:"response" gorm:"response"`       // 返回参数
	Platform    string `json:"platform" gorm:"platform"`       // 平台
	Ip          string `json:"ip" gorm:"ip"`                   // IP
	Address     string `json:"address" gorm:"address"`         // 地址
}

// TableName 表名称
func (*SysRecords) TableName() string {
	return "sys_records"
}
