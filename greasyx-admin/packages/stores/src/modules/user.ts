import { acceptHMRUpdate, defineStore } from 'pinia';

interface BasicUserInfo {
  [key: string]: any;
  /**
   * 头像
   */
  avatar: string;
  /**
   * 用户昵称
   */
  realName: string;
  /**
   * 用户角色
   */
  roles?: string[];
  /**
   * 用户id
   */
  userId: string;
  /**
   * 用户名
   */
  username: string;

  /**
   * 用户按钮权限
   */
  userPermissions: string[];
}

interface AccessState {
  /**
   * 用户信息
   */
  userInfo: BasicUserInfo | null;
  /**
   * 用户角色
   */
  userRoles: string[];
  /**
   * 用户按钮权限
   */
  userPermissions: string[];
}

/**
 * @zh_CN 用户信息相关
 */
export const useUserStore = defineStore('core-user', {
  actions: {
    setUserInfo(userInfo: BasicUserInfo | null) {
      // 设置用户信息
      this.userInfo = userInfo;
      // 设置角色信息
      const roles = userInfo?.roles ?? [];
      this.setUserRoles(roles);
      // 设置角色信息
      const permissions = userInfo?.permissions ?? [];
      this.setPermissions(permissions);
    },
    setUserRoles(roles: string[]) {
      this.userRoles = roles;
    },
    setPermissions(permissions: string[]) {
      this.userPermissions = permissions;
    },
  },
  state: (): AccessState => ({
    userInfo: null,
    userRoles: [],
    userPermissions: [],
  }),
  getters: {
    getPermissions(state) {
      return state.userPermissions;
    },
  },
});

// 解决热更新问题
const hot = import.meta.hot;
if (hot) {
  hot.accept(acceptHMRUpdate(useUserStore, hot));
}
