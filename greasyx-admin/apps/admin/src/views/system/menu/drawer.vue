<script lang="ts" setup>
import { computed, ref } from 'vue';

import { useVbenDrawer } from '@vben/common-ui';
import { $t } from '@vben/locales';

// import lucide from '@iconify/json/json/lucide.json';
// import { addCollection } from '@iconify/vue';
import { useVbenForm } from '#/adapter/form';

import {
  buildMenuTree,
  createMenuApi,
  updateMenuApi,
  getMenuTreeApi,
} from '#/api';
import { MenuType, statusList } from '#/store';
import { useToast, POSITION } from 'vue-toastification';
const toast = useToast();

const isMenu = (type: string) => type === MenuType.MENU;
const isButton = (type: string) => type === MenuType.BUTTON;

const menuTypeList = computed(() => [
  { value: MenuType.FOLDER, label: $t('enum.menuType.folder') },
  { value: MenuType.MENU, label: $t('enum.menuType.menu') },
  { value: MenuType.BUTTON, label: $t('enum.menuType.button') },
]);

// addCollection(lucide);

const data = ref();

const getTitle = computed(() =>
  data.value?.create
    ? $t('ui.modal.create', { moduleName: $t('page.system.menu.module') })
    : $t('ui.modal.update', { moduleName: $t('page.system.menu.module') }),
);

const [BaseForm, baseFormApi] = useVbenForm({
  showDefaultActions: false,
  // 所有表单项共用，可单独在表单内覆盖
  commonConfig: {
    // 所有表单项
    componentProps: {
      class: 'w-full',
    },
  },
  schema: [
    {
      component: 'RadioGroup',
      fieldName: 'type',
      label: $t('page.system.menu.type'),
      componentProps: {
        optionType: 'button',
        class: 'flex flex-wrap', // 如果选项过多，可以添加class来自动折叠
        options: menuTypeList,
      },
      defaultValue: MenuType.FOLDER,
      rules: 'selectRequired',
    },
    {
      component: 'Input',
      fieldName: 'meta.name',
      label: $t('page.system.menu.name'),
      rules: 'required',
      componentProps: {
        placeholder: $t('ui.placeholder.input'),
        allowClear: true,
      },
    },
    {
      component: 'Input',
      fieldName: 'routeName',
      label: $t('page.system.menu.routeName'),
      rules: 'required',
      componentProps: {
        placeholder: $t('ui.placeholder.input'),
        allowClear: true,
      },
    },
    {
      component: 'ApiTreeSelect',
      fieldName: 'parentId',
      label: $t('page.system.menu.parentId'),
      componentProps: {
        checkStrictly: true,
        showCheckbox: true,
        placeholder: $t('ui.placeholder.select'),
        api: async () => {
          const formValues = baseFormApi.form.values;
          const result = await getMenuTreeApi({
            name: formValues.name,
            status: formValues.status,
          });
          return result.items;
        },
        childrenField: 'children',
        labelField: 'meta.name',
        valueField: 'id',
        afterFetch: (data: any) => {
          return buildMenuTree(data);
        },
      },
    },
    // {
    //   component: 'InputNumber',
    //   fieldName: 'meta.sort',
    //   label: $t('ui.table.sortId'),
    //   componentProps: {
    //     placeholder: $t('ui.placeholder.input'),
    //     allowClear: true,
    //   },
    // },
    {
      component: 'IconPicker',
      fieldName: 'meta.icon',
      label: $t('page.system.menu.icon'),
      componentProps: {
        prefix: 'lucide',
      },
      dependencies: {
        show: (values) => !isButton(values.type),
        triggerFields: ['type'],
      },
    },
    {
      component: 'Input',
      fieldName: 'perm',
      label: $t('page.system.menu.perm'),
      rules: 'required',
      componentProps: {
        placeholder: $t('ui.placeholder.input'),
        allowClear: true,
      },
      dependencies: {
        show: (values) => isButton(values.type),
        triggerFields: ['type'],
      },
    },
    {
      component: 'Input',
      fieldName: 'path',
      label: $t('page.system.menu.path'),
      rules: 'required',
      componentProps: {
        placeholder: $t('ui.placeholder.input'),
        allowClear: true,
      },
      dependencies: {
        show: (values) => !isButton(values.type),
        triggerFields: ['type'],
      },
    },
    {
      component: 'Input',
      fieldName: 'component',
      label: $t('page.system.menu.component'),
      defaultValue: 'BasicLayout',
      rules: 'required',
      componentProps: {
        placeholder: $t('ui.placeholder.input'),
        allowClear: true,
      },
      dependencies: {
        show: (values) => isMenu(values.type),
        triggerFields: ['type'],
      },
    },
    {
      component: 'RadioGroup',
      fieldName: 'status',
      defaultValue: 1,
      label: $t('ui.table.status'),
      rules: 'selectRequired',
      componentProps: {
        optionType: 'button',
        class: 'flex flex-wrap', // 如果选项过多，可以添加class来自动折叠
        options: statusList,
      },
    },
    {
      component: 'Switch',
      fieldName: 'meta.affixTab',
      label: $t('page.system.menu.affixTab'),
      componentProps: {
        activeValue: 1,
        inactiveValue: 0,
        class: 'w-auto',
      },
      dependencies: {
        show: (values) => !isButton(values.type),
        triggerFields: ['type'],
      },
    },
    {
      component: 'Switch',
      fieldName: 'meta.hideChildrenInMenu',
      label: $t('page.system.menu.hideChildrenInMenu'),
      componentProps: {
        activeValue: 1,
        inactiveValue: 0,
        class: 'w-auto',
      },
      dependencies: {
        show: (values) => !isButton(values.type),
        triggerFields: ['type'],
      },
    },
    {
      component: 'Switch',
      fieldName: 'meta.hideInBreadcrumb',
      label: $t('page.system.menu.hideInBreadcrumb'),
      componentProps: {
        activeValue: 1,
        inactiveValue: 0,
        class: 'w-auto',
      },
      dependencies: {
        show: (values) => !isButton(values.type),
        triggerFields: ['type'],
      },
    },
    {
      component: 'Switch',
      fieldName: 'meta.hideInMenu',
      label: $t('page.system.menu.hideInMenu'),
      componentProps: {
        activeValue: 1,
        inactiveValue: 0,
        class: 'w-auto',
      },
      dependencies: {
        show: (values) => !isButton(values.type),
        triggerFields: ['type'],
      },
    },
    {
      component: 'Switch',
      fieldName: 'meta.hideInTab',
      label: $t('page.system.menu.hideInTab'),
      componentProps: {
        activeValue: 1,
        inactiveValue: 0,
        class: 'w-auto',
      },
      dependencies: {
        show: (values) => !isButton(values.type),
        triggerFields: ['type'],
      },
    },
    {
      component: 'Switch',
      fieldName: 'meta.keepAlive',
      label: $t('page.system.menu.keepAlive'),
      componentProps: {
        activeValue: 1,
        inactiveValue: 0,
        class: 'w-auto',
      },
      dependencies: {
        show: (values) => isMenu(values.type),
        triggerFields: ['type'],
      },
    },
  ],
});

const [Drawer, drawerApi] = useVbenDrawer({
  onCancel() {
    drawerApi.close();
  },

  async onConfirm() {
    // 校验输入的数据
    const validate = await baseFormApi.validate();
    if (!validate.valid) {
      return;
    }

    setLoading(true);

    // 获取表单数据
    const values = await baseFormApi.getValues();

    console.log(getTitle.value, values);

    try {
      await (data.value?.create
        ? createMenuApi(values)
        : updateMenuApi(data.value.row.id, values));

      toast.success(
        data.value?.create
          ? $t('ui.notification.create_success')
          : $t('ui.notification.update_success'),
        {
          timeout: 1000,
          position: POSITION.TOP_RIGHT,
          toastClassName: 'toastification-success',
        },
      );
      drawerApi.setData({ needRefresh: true });
    } catch {
      // toast.error(
      //   data.value?.create
      //     ? $t('ui.notification.create_failed')
      //     : $t('ui.notification.update_failed'),
      //   {
      //     timeout: 2000,
      //     position: POSITION.TOP_CENTER,
      //   },
      // );
    } finally {
      drawerApi.close();
      setLoading(false);
    }
  },

  onOpenChange(isOpen) {
    if (isOpen) {
      // 获取传入的数据
      data.value = drawerApi.getData<Record<string, any>>();

      // 为表单赋值
      baseFormApi.setValues(data.value?.row);

      setLoading(false);
    }
  },
});

function setLoading(loading: boolean) {
  drawerApi.setState({ loading });
}
</script>

<template>
  <Drawer :title="getTitle">
    <BaseForm />
  </Drawer>
</template>
