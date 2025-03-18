package types

type MenuInfo struct {
	Id        int64      `json:"id"`
	Status    int64      `json:"status"`
	Type      string     `json:"type"`
	Path      string     `json:"path"`
	Name      string     `json:"name"`
	RouteName string     `json:"routeName"`
	Component string     `json:"component"`
	Meta      MenuMeta   `json:"meta"`
	ParentId  int64      `json:"parentId"`
	Children  []MenuInfo `json:"children"`
	Perm      string     `json:"perm"`
	CreatedAt int64      `json:"createdAt"`
}

type MenuMeta struct {
	Authority          []string `json:"authority"`
	AffixTab           int64    `json:"affixTab"`
	HideChildrenInMenu int64    `json:"hideChildrenInMenu"`
	HideInBreadcrumb   int64    `json:"hideInBreadcrumb"`
	HideInMenu         int64    `json:"hideInMenu"`
	HideInTab          int64    `json:"hideInTab"`
	Icon               string   `json:"icon"`
	KeepAlive          int64    `json:"keepAlive"`
	Sort               int64    `json:"sort"`
	Name               string   `json:"name"`
}
