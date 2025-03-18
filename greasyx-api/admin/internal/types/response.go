package types

type ApiListResp struct {
	Total int64 `json:"total"`
	Items any   `json:"items"`
}

type ApiInfoResp struct {
	Id          int64          `json:"id"`
	ParentId    int64          `json:"parentId"`
	Description string         `json:"description"`
	Method      string         `json:"method"`
	Path        string         `json:"path"`
	CreatedAt   int64          `json:"createdAt"`
	Children    []*ApiInfoResp `json:"children"`
}

type LoginResp struct {
	Id          int64    `json:"id"`
	Password    string   `json:"password"`
	RealName    string   `json:"realName"`
	Roles       []string `json:"roles"`
	Username    string   `json:"username"`
	AccessToken string   `json:"accessToken"`
}

type DictListResp struct {
	Total int64 `json:"total"`
	Items any   `json:"items"`
}

type DictInfoResp struct {
	Id        int64  `json:"id"`
	DictName  string `json:"dictName"`
	DictType  string `json:"dictType"`
	ItemKey   string `json:"itemKey"`
	ItemValue string `json:"itemValue"`
	Sort      int64  `json:"sort"`
	Remark    string `json:"remark"`
	Status    int64  `json:"status"`
	CreatedAt int64  `json:"createdAt"`
}

type MenuResp struct {
	Total int64 `json:"total"`
	Items any   `json:"items"`
}

type RouterMetaResp struct {
	Icon     string `json:"icon"`
	Sort     int64  `json:"sort,omitempty"`
	Title    string `json:"title"`
	AffixTab bool   `json:"affixTab,omitempty"`
}

type RouterResp struct {
	Meta      RouterMetaResp `json:"meta"`
	Name      string         `json:"name"`
	Path      string         `json:"path"`
	Component string         `json:"component,omitempty"`
	Children  []RouterResp   `json:"children,omitempty"`
}

type RecordListResp struct {
	Total int64 `json:"total"`
	Items any   `json:"items"`
}

type RecordInfoResp struct {
	Id          int64  `json:"id"`
	Username    string `json:"username"`
	UserId      int64  `json:"userId"`
	Description string `json:"description"`
	Method      string `json:"method"`
	Path        string `json:"path"`
	StatusCode  int64  `json:"statusCode"`
	Elapsed     string `json:"elapsed"`
	Msg         string `json:"msg"`
	Request     string `json:"request"`
	Response    string `json:"response"`
	Platform    string `json:"platform"`
	Ip          string `json:"ip"`
	Address     string `json:"address"`
	CreatedAt   int64  `json:"createdAt"`
}

type RoleListResp struct {
	Total int64 `json:"total"`
	Items any   `json:"items"`
}

type RoleInfoResp struct {
	Id        int64   `json:"id"`
	Name      string  `json:"name"`
	Code      string  `json:"code"`
	Sort      int64   `json:"sort"`
	Remark    string  `json:"remark"`
	Status    int64   `json:"status"`
	CreatedAt int64   `json:"createdAt"`
	AuthId    []int64 `json:"authId"`
	ApiId     []int64 `json:"apiId"`
}

type UserListResp struct {
	Total int64 `json:"total"`
	Items any   `json:"items"`
}

type UserInfoResp struct {
	Id            int64    `json:"id"`
	RealName      string   `json:"realName"`
	Roles         []string `json:"roles"`
	Username      string   `json:"username" label:"用户名"`
	Nickname      string   `json:"nickname" label:"用户昵称"`
	Mobile        string   `json:"mobile" label:"手机号"`
	Gender        int64    `json:"gender" label:"性别(1-男 2-女 0-保密)"`
	Email         string   `json:"email" label:"邮箱"`
	Avatar        string   `json:"avatar" label:"头像"`
	Status        int64    `json:"status" label:"状态 1:禁用,2正常"`
	Remark        string   `json:"remark" label:"备注"`
	LastLoginTime int64    `json:"lastLoginTime" label:"最后一次登录的时间"`
	LastLoginIp   string   `json:"lastLoginIp" label:"最后一次登录的IP"`
	RoleId        int64    `json:"roleId" label:"角色ID"`
	RoleName      string   `json:"roleName" label:"角色名称"`
	Permissions   []string `json:"permissions"`
	CreatedAt     int64    `json:"createdAt"`
}
