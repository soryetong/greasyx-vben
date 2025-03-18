<script lang="ts" setup>
import { useVbenVxeGrid, type VxeGridProps } from '#/adapter/vxe-table';
import { $t } from '#/locales';
import { Page, type VbenFormProps } from '@vben/common-ui';
import { LucideTrash2 } from '@vben/icons';
import { ElButton } from 'element-plus';
import { deleteRecordApi, getRecordListApi } from '#/api';
import { useToast, POSITION } from 'vue-toastification';
import { formatDateTime } from '@vben/utils';

const toast = useToast();

const formOptions: VbenFormProps = {
  // 默认展开
  collapsed: false,
  // 控制表单是否显示折叠按钮
  showCollapseButton: false,
  // 按下回车时是否提交表单
  submitOnEnter: true,
  schema: [
    {
      component: 'Input',
      fieldName: 'username',
      label: $t('page.system.record.username'),
      componentProps: {
        placeholder: $t('ui.placeholder.input'),
        allowClear: true,
      },
    },
    {
      component: 'DatePicker',
      fieldName: 'createTime',
      label: $t('ui.input-search.optTime'),
      componentProps: {
        type: 'datetimerange',
        rangeSeparator: '至',
        startPlaceholder: '开始时间',
        endPlaceholder: '结束时间',
        valueFormat: 'YYYY-MM-DD HH:mm:ss',
        showTime: true,
        allowClear: true,
      },
    },
  ],
};

const gridOptions: VxeGridProps = {
  toolbarConfig: {
    custom: true,
    export: true,
    // import: true,
    refresh: true,
    zoom: true,
  },
  height: 'auto',
  exportConfig: {},
  pagerConfig: {},
  rowConfig: {
    isHover: true,
  },
  stripe: true,

  proxyConfig: {
    ajax: {
      query: async ({ page }, formValues) => {
        return await getRecordListApi({
          page: page.currentPage,
          pageSize: page.pageSize,
          username: formValues.username,
          createTime: formValues.createTime,
        });
      },
    },
  },

  columns: [
    {
      title: $t('ui.table.seq'),
      type: 'seq',
      width: 70,
    },
    {
      title: $t('page.system.record.username'),
      field: 'username',
    },
    {
      title: $t('page.system.record.description'),
      field: 'description',
    },
    {
      title: $t('page.system.record.method'),
      field: 'method',
    },
    {
      title: $t('page.system.record.path'),
      field: 'path',
    },
    {
      title: $t('page.system.record.statusCode'),
      field: 'statusCode',
    },
    {
      title: $t('page.system.record.msg'),
      field: 'msg',
    },
    {
      title: $t('page.system.record.elapsed'),
      field: 'elapsed',
    },
    {
      title: $t('page.system.record.platform'),
      field: 'platform',
    },
    {
      title: $t('page.system.record.ip'),
      field: 'ip',
    },
    {
      title: $t('page.system.record.createTime'),
      field: 'createTime',
      slots: { default: 'createdAt' },
    },
    {
      title: $t('ui.table.action'),
      field: 'action',
      fixed: 'right',
      slots: { default: 'action' },
    },
  ],
};

const [Grid, gridApi] = useVbenVxeGrid({ gridOptions, formOptions });

/* 删除 */
async function handleDelete(row: any) {
  row.pending = true;
  try {
    await deleteRecordApi(row.id);

    toast.success($t('ui.notification.delete_success'), {
      timeout: 1000,
      position: POSITION.TOP_RIGHT,
      toastClassName: 'toastification-success',
    });
  } catch {
    // toast.error($t('ui.notification.delete_failed'), {
    //   timeout: 2000,
    //   position: POSITION.TOP_CENTER,
    // });
  } finally {
    row.pending = false;
    gridApi.query();
  }
}
</script>

<template>
  <Page auto-content-height>
    <Grid :table-title="$t('page.system.record.title')">
      <template #createdAt="{ row }">
        {{ formatDateTime(row.createdAt) }}
      </template>

      <template #action="{ row }">
        <el-popconfirm
          :title="
            $t('ui.text.do_you_want_delete', {
              moduleName: $t('page.system.record.module'),
            })
          "
          :confirm-button-text="$t('ui.button.ok')"
          :cancElButton-text="$t('ui.button.cancel')"
          @confirm="() => handleDelete(row)"
        >
          <template #reference>
            <ElButton
              type="danger"
              v-permission="['system:record:delete']"
              link
              :icon="LucideTrash2"
            />
          </template>
        </el-popconfirm>
      </template>
    </Grid>
  </Page>
</template>
