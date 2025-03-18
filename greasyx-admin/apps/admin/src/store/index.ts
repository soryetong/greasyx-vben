import { $t } from '@vben/locales';
import { computed } from 'vue';

export * from './auth';
export * from './user';

export const statusList = computed(() => [
  { value: 1, label: $t('enum.status.ON') },
  { value: 2, label: $t('enum.status.OFF') },
]);

export const methodList = computed(() => [
  { value: 'GET', label: 'GET' },
  { value: 'POST', label: 'POST' },
  { value: 'PUT', label: 'PUT' },
  { value: 'DELETE', label: 'DELETE' },
]);

export interface Timestamp {
  /**
   * Represents seconds of UTC time since Unix epoch
   * 1970-01-01T00:00:00Z. Must be from 0001-01-01T00:00:00Z to
   * 9999-12-31T23:59:59Z inclusive.
   */
  seconds: string;
  /**
   * Non-negative fractions of a second at nanosecond resolution. Negative
   * second values with fractions must still have non-negative nanos values
   * that count forward in time. Must be from 0 to 999,999,999
   * inclusive.
   */
  nanos: number;
}

/** 菜单类型 */
export enum MenuType {
  /** FOLDER - 菜单夹 */
  FOLDER = 'FOLDER',
  /** MENU - 菜单项 */
  MENU = 'MENU',
  /** BUTTON - 按钮 */
  BUTTON = 'BUTTON',
}
