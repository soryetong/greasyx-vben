import { useUserStore } from '@vben/stores';
import type { Directive } from 'vue';

export const permission: Directive = {
  mounted(el, binding) {
    const store = useUserStore();
    const { value } = binding;
    const permissions = store.getPermissions;

    if (value && value instanceof Array && value.length > 0) {
      const permissionRoles = value;
      const hasPermission = permissions.some((role: any) => {
        return permissionRoles.includes(role);
      });

      if (!hasPermission) {
        el.style.display = 'none';
      }
    } else {
      throw new Error(
        'need permissions! Like v-permission="[\'system:user:create\']"',
      );
    }
  },
};

export function hasPermission(permissions: string[]): boolean {
  const store = useUserStore();
  const userPermissions = store.getPermissions || [];

  return permissions.some((permission) =>
    Array.isArray(userPermissions)
      ? userPermissions.includes(permission)
      : false,
  );
}
