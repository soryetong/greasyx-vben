<script lang="ts" setup>
import { computed, ref } from 'vue';
import { useVbenDrawer, z } from '@vben/common-ui';
import { $t } from '@vben/locales';
import { useVbenForm } from '#/adapter/form';
import { createUserApi, getRoleListApi, updateUserApi } from '#/api';
import { statusList } from '#/store';
import { useToast, POSITION } from 'vue-toastification';

const toast = useToast();
const data = ref();
const isCreate = computed(() => data.value?.create);
const getTitle = computed(() =>
  isCreate.value
    ? $t('ui.modal.create', { moduleName: $t('page.system.user.module') })
    : $t('ui.modal.update', { moduleName: $t('page.system.user.module') }),
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
      component: 'Input',
      fieldName: 'username',
      label: $t('page.system.user.username'),
      componentProps: {
        placeholder: $t('ui.placeholder.input'),
        allowClear: true,
      },
      rules: z.string().min(1, { message: $t('ui.formRules.required') }),
    },
    {
      component: 'Input',
      fieldName: 'nickname',
      label: $t('page.system.user.nickName'),
      componentProps: {
        placeholder: $t('ui.placeholder.input'),
        allowClear: true,
      },
      rules: 'required',
    },
    {
      component: 'VbenInputPassword',
      fieldName: 'password',
      label: $t('ui.table.password'),
      componentProps: {
        passwordStrength: true,
        placeholder: $t('ui.placeholder.input'),
      },
      help: '默认密码: 123456',
    },
    {
      component: 'ApiSelect',
      fieldName: 'roleId',
      label: $t('page.system.user.authority'),
      componentProps: {
        placeholder: $t('ui.placeholder.select'),
        api: async () => {
          const result = await getRoleListApi({});
          return result.items;
        },
        labelField: 'name',
        valueField: 'id',
      },
      rules: 'selectRequired',
    },
    {
      component: 'Input',
      fieldName: 'email',
      label: $t('page.system.user.email'),
      componentProps: {
        placeholder: $t('ui.placeholder.input'),
        allowClear: true,
      },
    },
    {
      component: 'Input',
      fieldName: 'remark',
      label: $t('ui.table.remark'),
      componentProps: {
        type: 'textarea',
        autosize: true,
        rows: 5,
        placeholder: $t('ui.placeholder.input'),
        allowClear: true,
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

    try {
      await (data.value?.create
        ? createUserApi(values)
        : updateUserApi(data.value.row.id, values));

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

      if (data.value?.row?.meta && data.value?.row?.meta?.authority) {
        const authority = data.value.row.meta.authority;
        data.value.row.meta.authority = authority.join(',');
      }

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
