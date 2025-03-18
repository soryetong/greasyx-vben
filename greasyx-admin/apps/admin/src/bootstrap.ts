import { createApp, watchEffect } from 'vue';

import { registerAccessDirective } from '@vben/access';
import { initTippy } from '@vben/common-ui';
import { preferences } from '@vben/preferences';
import { initStores } from '@vben/stores';
import '@vben/styles';
import '@vben/styles/ele';

import { useTitle } from '@vueuse/core';

import { $t, setupI18n } from '#/locales';

import { initComponentAdapter } from './adapter/component';
import App from './app.vue';
import { router } from './router';

import Toast, { POSITION } from 'vue-toastification';
import 'vue-toastification/dist/index.css';

import ElementPlus from 'element-plus';
import 'element-plus/dist/index.css';

import { permission } from './directives/permissions';

async function bootstrap(namespace: string) {
  // 初始化组件适配器
  await initComponentAdapter();

  const app = createApp(App);

  // **全局注册 Element Plus**
  app.use(ElementPlus);

  // 国际化 i18n 配置
  await setupI18n(app);

  // 配置 pinia-tore
  await initStores(app, { namespace });

  // 安装权限指令
  registerAccessDirective(app);

  // 初始化 tippy
  initTippy(app);

  // 配置路由及路由守卫
  app.use(router);

  // 动态更新标题
  watchEffect(() => {
    if (preferences.app.dynamicTitle) {
      const routeTitle = router.currentRoute.value.meta?.title;
      const pageTitle =
        (routeTitle ? `${$t(routeTitle)} - ` : '') + preferences.app.name;
      useTitle(pageTitle);
    }
  });

  // 配置 vue-toastification
  app.use(Toast, {
    position: POSITION.TOP_RIGHT,
    timeout: 5000,
  });

  app.directive('permission', permission);

  app.mount('#app');
}

export { bootstrap };
