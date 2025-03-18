import { $t } from '@vben/locales';
import { computed } from 'vue';

/** 用户权限 */
export enum UserAuthority {
  /** SYS_ADMIN - 系统超级用户 */
  SYS_ADMIN = 'SYS_ADMIN',
  /** SYS_MANAGER - 系统管理员 */
  SYS_MANAGER = 'SYS_MANAGER',
  /** CUSTOMER_USER - 普通用户 */
  CUSTOMER_USER = 'CUSTOMER_USER',
  /** GUEST_USER - 游客 */
  GUEST_USER = 'GUEST_USER',
  /** REFRESH_TOKEN - 刷新令牌 */
  REFRESH_TOKEN = 'REFRESH_TOKEN',
}

export const authorityList = computed(() => [
  {
    value: 1,
    label: $t('enum.authority.GUEST_USER'),
  },
  {
    value: UserAuthority.CUSTOMER_USER,
    label: $t('enum.authority.CUSTOMER_USER'),
  },
  {
    value: UserAuthority.SYS_MANAGER,
    label: $t('enum.authority.SYS_MANAGER'),
  },
  { value: UserAuthority.SYS_ADMIN, label: $t('enum.authority.SYS_ADMIN') },
]);

/**
 * 权限转名称
 * @param authority
 */
export function authorityToName(authority: any) {
  switch (authority) {
    case UserAuthority.CUSTOMER_USER: {
      return $t('enum.authority.CUSTOMER_USER');
    }
    case UserAuthority.GUEST_USER: {
      return $t('enum.authority.GUEST_USER');
    }
    case UserAuthority.SYS_ADMIN: {
      return $t('enum.authority.SYS_ADMIN');
    }
    case UserAuthority.SYS_MANAGER: {
      return $t('enum.authority.SYS_MANAGER');
    }
    default: {
      return '';
    }
  }
}

/**
 * 权限转颜色值
 * @param authority
 */
export function authorityToColor(authority: any) {
  switch (authority) {
    case UserAuthority.CUSTOMER_USER: {
      return 'green';
    }
    case UserAuthority.GUEST_USER: {
      return 'green';
    }
    case UserAuthority.SYS_ADMIN: {
      return 'orange';
    }
    case UserAuthority.SYS_MANAGER: {
      return 'red';
    }
    default: {
      return 'black';
    }
  }
}
