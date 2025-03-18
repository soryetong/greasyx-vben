package types

type SysMenuTreeReq struct {
	Keywords   string `json:"keywords" form:"keywords"`
	Status     int64  `json:"status" form:"status"`
	OnlyParent bool   `json:"onlyParent" form:"onlyParent"`
}

type AddUserReq struct {
	Username string `json:"username" binding:"required,max=16,min=2" label:"用户名"`
	Password string `json:"password" binding:"required,max=16,min=6" label:"密码"`
	Nickname string `json:"nickname" binding:"required,max=16,min=2" label:"昵称"`
	Status   int64  `json:"status" binding:"required" label:"状态"`
	RoleId   int64  `json:"roleId" binding:"required" label:"角色ID"`
	Mobile   string `json:"mobile"`
	Email    string `json:"email"`
	Remark   string `json:"remark"`
}

type UpsertApiReq struct {
	ParentId    int64  `json:"parentId"`
	Description string `json:"description"`
	Method      string `json:"method"`
	Path        string `json:"path"`
}

type ApiListReq struct {
	Page        int64  `json:"page" form:"page"`
	PageSize    int64  `json:"pageSize" form:"pageSize"`
	Description string `json:"description" form:"description"`
	Path        string `json:"path"  form:"path"`
	OnlyParent  bool   `json:"onlyParent" form:"onlyParent"`
}

type LoginReq struct {
	Username string `json:"username" binding:"required"`
	Password string `json:"password" binding:"required"`
}

type LogoutReq struct {
	WithCredentials bool `json:"withCredentials"`
}

type DictListReq struct {
	Page     int64  `json:"page" form:"page"`
	PageSize int64  `json:"pageSize" form:"pageSize"`
	DictName string `json:"dictName" form:"dictName"`
	DictType string `json:"dictType" form:"dictType"`
	Status   int64  `json:"status" form:"status"`
}

type UpsertDictReq struct {
	DictName  string `json:"dictName"`
	DictType  string `json:"dictType"`
	ItemKey   string `json:"itemKey"`
	ItemValue string `json:"itemValue"`
	Sort      int64  `json:"sort"`
	Remark    string `json:"remark"`
	Status    int64  `json:"status"`
}

type MenuTreeReq struct {
	Page     int64  `json:"page" form:"page"`
	PageSize int64  `json:"pageSize" form:"pageSize"`
	Name     string `json:"name" form:"name"`
	Status   int64  `json:"status" form:"status"`
}

type RecordListReq struct {
	Page       int64    `json:"page" form:"page"`
	PageSize   int64    `json:"pageSize" form:"pageSize"`
	Username   string   `json:"username" form:"username"`
	CreateTime []string `form:"createTime[]" json:"createTime[]"`
}

type RoleListReq struct {
	Page     int64  `json:"page" form:"page"`
	PageSize int64  `json:"pageSize" form:"pageSize"`
	Name     string `json:"name" form:"name"`
	Status   int64  `json:"status" form:"status"`
}

type UpsertRoleReq struct {
	Name   string `json:"name"`
	Code   string `json:"code"`
	Sort   int64  `json:"sort"`
	Remark string `json:"remark"`
	Status int64  `json:"status"`
}

type AssignRoleReq struct {
	AuthId []int64 `json:"authId" binding:"required"`
	ApiId  []int64 `json:"apiId" binding:"required"`
}

type UpsertUserReq struct {
	Username string `json:"username" binding:"required,max=16,min=2" label:"用户名"`
	Password string `json:"password" label:"密码"`
	Nickname string `json:"nickname" binding:"required,max=16,min=2" label:"昵称"`
	Status   int64  `json:"status" label:"状态"`
	RoleId   int64  `json:"roleId" binding:"required" label:"角色ID"`
	Mobile   string `json:"mobile"`
	Email    string `json:"email"`
	Remark   string `json:"remark"`
}

type UserListReq struct {
	Page     int64  `json:"page" form:"page"`
	PageSize int64  `json:"pageSize" form:"pageSize"`
	Username string `json:"username" form:"username"`
	Status   int64  `json:"status" form:"status"`
}
