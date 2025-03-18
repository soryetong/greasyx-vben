package models

// SysMenus 菜单管理
type SysMenus struct {
	GnModel
	ParentId           int64  `json:"parentId" gorm:"parent_id"`                       // 父菜单ID
	TreePath           string `json:"TreePath" gorm:"tree_path"`                       // 父节点ID路径
	Name               string `json:"name" gorm:"name"`                                // 菜单名称
	Type               string `json:"type" gorm:"type"`                                // 菜单类型
	RouteName          string `json:"routeName" gorm:"route_name"`                     // 路由名称（Vue Router 中用于命名路由）
	Path               string `json:"path" gorm:"path"`                                // 路由路径（Vue Router 中定义的 URL 路径）
	Component          string `json:"component" gorm:"component"`                      // 组件路径（组件页面完整路径，相对于 src/views/，缺省后缀 .vue）
	Perm               string `json:"perm" gorm:"perm"`                                // 【按钮】权限标识
	Status             int64  `json:"status" gorm:"status"`                            // 显示状态（1-显示 2-隐藏）
	AffixTab           int64  `json:"affixTab" gorm:"affix_tab"`                       // 固定标签页（1-是 2-否）
	HideChildrenInMenu int64  `json:"hideChildrenInMenu" gorm:"hide_children_in_menu"` // 子级不展现（1-是 2-否）
	HideInBreadcrumb   int64  `json:"hideInBreadcrumb" gorm:"hide_in_breadcrumb"`      // 面包屑中不展现（1-是 2-否）
	HideInMenu         int64  `json:"hideInMenu" gorm:"hide_in_menu"`                  // 菜单中不展现（1-是 2-否）
	HideInTab          int64  `json:"hideInTab" gorm:"hide_in_tab"`                    // 标签页中不展现（1-是 2-否）
	KeepAlive          int64  `json:"keepAlive" gorm:"keep_alive"`                     // 是否缓存（1-是 2-否）
	Sort               int64  `json:"sort" gorm:"sort"`                                // 排序
	Icon               string `json:"icon" gorm:"icon"`                                // 菜单图标
	Redirect           string `json:"redirect" gorm:"redirect"`                        // 跳转路径
}

// TableName 表名称
func (*SysMenus) TableName() string {
	return "sys_menus"
}
