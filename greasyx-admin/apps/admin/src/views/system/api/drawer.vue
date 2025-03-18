<script lang="ts" setup>
import { computed, ref } from 'vue';
import { useVbenDrawer, z } from '@vben/common-ui';
import { $t } from '@vben/locales';
import { useVbenForm } from '#/adapter/form';
import { createApiApi, getApiListApi, updateApiApi } from '#/api';
import { useToast, POSITION } from 'vue-toastification';
import { methodList } from '#/store';

const toast = useToast();
const data = ref();
const getTitle = computed(() =>
  data.value?.create
    ? $t('ui.modal.create', { moduleName: $t('page.system.api.module') })
    : $t('ui.modal.update', { moduleName: $t('page.system.api.module') }),
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
      component: 'ApiSelect',
      fieldName: 'parentId',
      label: $t('page.system.api.parentId'),
      componentProps: {
        placeholder: $t('ui.placeholder.select'),
        api: async () => {
          const result = await getApiListApi({
            onlyParent: true,
          });
          return result.items;
        },
        labelField: 'description',
        valueField: 'id',
      },
      rules: 'selectRequired',
    },
    {
      component: 'Input',
      fieldName: 'description',
      label: $t('page.system.api.description'),
      componentProps: {
        placeholder: $t('ui.placeholder.input'),
        allowClear: true,
      },
      rules: z.string().min(1, { message: $t('ui.formRules.required') }),
    },
    {
      component: 'Select',
      fieldName: 'method',
      label: $t('page.system.api.method'),
      componentProps: {
        options: methodList,
        placeholder: $t('ui.placeholder.select'),
      },
      dependencies: {
        required(values) {
          return values.parentId != 0;
        },
        triggerFields: ['parentId'],
      },
    },
    {
      component: 'Input',
      fieldName: 'path',
      label: $t('page.system.api.path'),
      componentProps: {
        placeholder: $t('ui.placeholder.input'),
        allowClear: true,
      },
      dependencies: {
        required(values) {
          return values.parentId != 0;
        },
        triggerFields: ['parentId'],
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
        ? createApiApi(values)
        : updateApiApi(data.value.row.id, values));

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
