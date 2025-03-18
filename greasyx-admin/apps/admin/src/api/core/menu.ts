import { requestClient } from '#/api/request';
import { $t } from '@vben/locales';
import type { MenuType, Timestamp } from '#/store';

export namespace MenuApi {
  /** 菜单查询参数 */
  export interface MenuQuery {
    /** 搜索关键字 */
    keywords?: string;
    /** 是否只获取父级 */
    onlyParent: boolean;
  }

  /** 菜单状态 */
  export enum MenuStatus {
    OFF = 'OFF',
    ON = 'ON',
  }

  /** 菜单表单对象 */
  export interface MenuForm {
    /** 菜单ID */
    id?: number | null | undefined;
    /** 菜单状态 */
    status?: MenuStatus | null | undefined;
    /** 菜单类型 */
    type?: MenuType | null | undefined;
    /** 路由路径 */
    path?: string | null | undefined;
    /** 重定向地址 */
    redirect?: string | null | undefined;
    /** 路由别名 */
    alias?: string | null | undefined;
    /** 路由命名，然后我们可以使用 name 而不是 path 来传递 to 属性给 <router-link>。 */
    name?: string | null | undefined;
    /** 指向的组件 */
    component?: string | null | undefined;
    /** 路由元信息 */
    meta?: RouteMeta | null | undefined;
    /** 父节点ID */
    parentId?: number | null | undefined;
    /** 子节点树 */
    children: MenuForm[];
    /** 创建时间 */
    createTime?: Timestamp | null | undefined;
    /** 更新时间 */
    updateTime?: Timestamp | null | undefined;
    /** 删除时间 */
    deleteTime?: Timestamp | null | undefined;
  }

  /** 路由元数据 */
  export interface RouteMeta {
    /** 激活图标，用于：菜单、tab */
    activeIcon?: string | null | undefined;
    /** 当前激活的菜单，有时候不想激活现有菜单，需要激活父级菜单时使用 */
    activePath?: string | null | undefined;
    /** 是否固定标签页 */
    affixTab?: number | null | undefined;
    /** 固定标签页的顺序 */
    affixTabOrder?: number | null | undefined;
    /** 权限列表，需要特定的角色标识才可以访问 */
    authority: string[];
    /** 徽标 */
    badge?: string | null | undefined;
    /** 徽标类型 */
    badgeType?: string | null | undefined;
    /** 徽标颜色 */
    badgeVariants?: string | null | undefined;
    /** 当前路由的子级在菜单中不展现 */
    hideChildrenInMenu?: number | null | undefined;
    /** 当前路由在面包屑中不展现 */
    hideInBreadcrumb?: number | null | undefined;
    /** 当前路由在菜单中不展现 */
    hideInMenu?: number | null | undefined;
    /** 当前路由在标签页不展现 */
    hideInTab?: number | null | undefined;
    /** 图标，用于：菜单、标签页 */
    icon?: string | null | undefined;
    /** iframe 地址 */
    iframeSrc?: string | null | undefined;
    /** 忽略权限，直接可以访问 */
    ignoreAccess?: boolean | null | undefined;
    /** 开启KeepAlive缓存 */
    keepAlive?: number | null | undefined;
    /** 外链-跳转路径 */
    link?: string | null | undefined;
    /** 路由是否已经加载过 */
    loaded?: boolean | null | undefined;
    /** 标签页最大打开数量 */
    maxNumOfOpenTab?: number | null | undefined;
    /** 菜单可以看到，但是访问会被重定向到403 */
    menuVisibleWithForbidden?: boolean | null | undefined;
    /** 在新窗口打开 */
    openInNewWindow?: boolean | null | undefined;
    /** 排序编号，用于路由->菜单排序 */
    sort?: number | null | undefined;
    /** 标题名称，路由上显示的标题 */
    name?: string | null | undefined;
  }

  /** 查询菜单列表 - 响应 */
  export interface ListMenuResp {
    items: MenuForm[];
    total: number;
  }
}

/**
 * 获取用户所有菜单
 */
export const getMenusRouterApi = async (param: any) => {
  return await requestClient.get<MenuApi.ListMenuResp>('/menu/router', {
    params: param,
  });
};

/**
 * 获取菜单树形列表
 *
 * @param param 查询参数
 * @returns
 */
export const getMenuTreeApi = async (param: any) => {
  return await requestClient.getWithParams<MenuApi.ListMenuResp>(
    '/menu/tree',
    param,
  );
};

/**
 * 获取表单内的指定数据
 *
 * @param id ID
 * @returns
 */
export const getFormMenuInfoApi = async (id: number) => {
  return await requestClient.get(`/system/menu/${id}`);
};

/**
 * 修改菜单信息
 *
 * @param id ID
 * @param param 数据
 * @returns
 */
export const updateMenuApi = async (id: number, param: any) => {
  return await requestClient.put(`/menu/update/${id}`, param);
};

/**
 * 新增菜单信息
 *
 * @param param 数据
 * @returns
 */
export const createMenuApi = async (param: any) => {
  return await requestClient.post('/menu/add', param);
};

/**
 * 删除菜单
 *
 * @param id ID
 * @returns
 */
export const deleteMenuApi = async (id: number) => {
  return await requestClient.delete(`/menu/delete/${id}`);
};

export namespace ApiTreeApi {
  /** API 树节点 */
  export interface ApiTreeNode {
    /** API ID */
    id: number;
    /** 父节点 ID */
    parentId: number;
    /** API 描述 */
    description: string;
    /** 请求方法 */
    method: string;
    /** 请求路径 */
    path: string;
    /** 创建时间 */
    createdAt: number;
    /** 子节点 */
    children: ApiTreeNode[] | null;
  }

  /** 查询 API 树 - 响应 */
  export interface ListApiTreeResp {
    items: ApiTreeNode[];
    total: number;
  }
}

/**
 * 获取 API 树形列表
 */
export const getApiTreeApi = async () => {
  return await requestClient.get<ApiTreeApi.ListApiTreeResp>('/api/tree');
};

/**
 * 构建 API 树形结构
 * 
 * @param apis API 列表
 * @returns 树形结构的 API 列表
 */
export function buildApiTree(apis: ApiTreeApi.ApiTreeNode[]): ApiTreeApi.ApiTreeNode[] {
  const tree: ApiTreeApi.ApiTreeNode[] = [];

  // 首先添加所有根节点（parentId 为 0 的节点）
  for (const api of apis) {
    if (!api) {
      continue;
    }

    if (api.parentId !== 0) {
      continue;
    }

    // 确保 children 是数组
    api.children = api.children || [];
    tree.push(api);
  }

  // 然后处理所有非根节点
  for (const api of apis) {
    if (!api) {
      continue;
    }

    if (api.parentId === 0) {
      continue;
    }

    // 尝试将节点添加到其父节点的 children 中
    if (travelApiChild(tree, api)) {
      continue;
    }

    // 如果找不到父节点，则作为根节点添加
    api.children = api.children || [];
    tree.push(api);
  }

  return tree;
}

/**
 * 递归遍历 API 树，将子节点添加到对应的父节点
 * 
 * @param nodes 当前遍历的节点列表
 * @param child 要添加的子节点
 * @returns 是否成功添加
 */
export function travelApiChild(
  nodes: ApiTreeApi.ApiTreeNode[],
  child: ApiTreeApi.ApiTreeNode
): boolean {
  if (!Array.isArray(nodes)) {
    return false;
  }

  // 如果是根节点，直接添加到 nodes 中
  if (child.parentId === 0) {
    child.children = child.children || [];
    nodes.push(child);
    return true;
  }

  // 遍历当前层级的节点
  for (const node of nodes) {
    // 如果找到父节点，将子节点添加到父节点的 children 中
    if (node.id === child.parentId) {
      node.children = node.children || [];
      child.children = child.children || [];
      node.children.push(child);
      return true;
    }

    // 递归遍历子节点
    if (node.children && travelApiChild(node.children, child)) {
      return true;
    }
  }

  return false;
}

export function buildMenuTree(menus: MenuApi.MenuForm[]): MenuApi.MenuForm[] {
  const tree: MenuApi.MenuForm[] = [];

  for (const menu of menus) {
    if (!menu) {
      continue;
    }

    if (menu.parentId !== 0 && menu.parentId !== undefined) {
      continue;
    }

    if (menu?.meta?.name) {
      menu.meta.name = $t(menu?.meta?.name ?? '');
    }
    tree.push(menu);
  }

  for (const menu of menus) {
    if (!menu) {
      continue;
    }

    if (menu.parentId === 0 || menu.parentId === undefined) {
      continue;
    }

    if (travelMenuChild(tree, menu)) {
      continue;
    }

    if (menu?.meta?.name) {
      menu.meta.name = $t(menu?.meta?.name ?? '');
    }
    tree.push(menu);
  }

  return tree;
}

export function travelMenuChild(
  nodes: MenuApi.MenuForm[],
  parent: MenuApi.MenuForm,
): boolean {
  if (!Array.isArray(nodes)) {
    return false;
  }

  if (parent.parentId === 0 || parent.parentId === undefined) {
    if (parent?.meta?.name) {
      parent.meta.name = $t(parent?.meta?.name ?? '');
    }
    nodes.push(parent);
    return true;
  }

  for (const node of nodes) {
    if (node.id === parent.parentId) {
      if (parent?.meta?.name) {
        parent.meta.name = $t(parent?.meta?.name ?? '');
      }

      node.children = node.children || [];
      node.children.push(parent);
      return true;
    }

    if (travelMenuChild(node.children, parent)) {
      return true;
    }
  }

  return false;
}
