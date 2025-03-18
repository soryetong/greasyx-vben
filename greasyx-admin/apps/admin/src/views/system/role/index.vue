<script lang="ts" setup>
import { h } from 'vue';
import { useVbenVxeGrid, type VxeGridProps } from '#/adapter/vxe-table';
import { $t } from '#/locales';
import { Page, useVbenDrawer, type VbenFormProps } from '@vben/common-ui';
import { LucideFilePenLine, LucideTrash2, LucidePencil } from '@vben/icons';
import { ElButton } from 'element-plus';
import RoleDrawer from './drawer.vue';
import SetAuthDrawer from './set-auth.vue';
import { deleteRoleApi, getRoleListApi, updateRoleApi } from '#/api';
import { formatDateTime } from '@vben/utils';
import { useToast, POSITION } from 'vue-toastification';
import { statusList } from '#/store';
import { hasPermission } from '#/directives/permissions';

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
      fieldName: 'name',
      label: $t('page.system.role.name'),
      defaultValue: '',
      componentProps: {
        placeholder: $t('ui.placeholder.input'),
        allowClear: true,
      },
    },
    {
      component: 'Select',
      fieldName: 'status',
      label: $t('ui.table.status'),
      componentProps: {
        options: statusList,
        placeholder: $t('ui.placeholder.select'),
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
    autoLoad: true,
    ajax: {
      query: async ({ page }, formValues) => {
        return await getRoleListApi({
          page: page.currentPage,
          pageSize: page.pageSize,
          name: formValues.name,
          status: formValues.status,
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
      title: $t('page.system.role.name'),
      field: 'name',
    },
    {
      title: $t('page.system.role.code'),
      field: 'code',
    },
    {
      title: $t('ui.table.sortId'),
      field: 'sort',
    },
    {
      title: $t('ui.table.status'),
      field: 'status',
      slots: { default: 'status' },
      width: 95,
    },
    {
      title: $t('ui.table.remark'),
      field: 'remark',
    },
    {
      title: $t('ui.table.createTime'),
      field: 'createdAt',
      slots: { default: 'createdAt' },
    },
    {
      title: $t('ui.table.action'),
      field: 'action',
      fixed: 'right',
      slots: { default: 'action' },
      width: 120,
    },
  ],
};

const [Grid, gridApi] = useVbenVxeGrid({ gridOptions, formOptions });

async function handleStatusChanged(row: any, checked: boolean) {
  row.pending = true;
  row.status = checked ? 1 : 2;
  try {
    await updateRoleApi(row.id, row);

    toast.success($t('ui.notification.update_success'), {
      timeout: 1000,
      position: POSITION.TOP_RIGHT,
      toastClassName: 'toastification-success',
    });
  } catch {
    // toast.error($t('ui.notification.update_failed'), {
    //   timeout: 2000,
    //   position: POSITION.TOP_CENTER,
    // });
  } finally {
    row.pending = false;
    gridApi.query();
  }
}

const [Drawer, drawerApi] = useVbenDrawer({
  connectedComponent: RoleDrawer,
  onClosed() {
    const data = drawerApi.getData();
    if (data && data.needRefresh) {
      gridApi.query();
    }
  },
});

const [AuthDrawer, authDrawerApi] = useVbenDrawer({
  connectedComponent: SetAuthDrawer,
  onClosed() {
    const data = drawerApi.getData();
    if (data && data.needRefresh) {
      gridApi.query();
    }
  },
});

function openDrawer(create: boolean, row?: any) {
  drawerApi.setData({
    create,
    row,
  });
  drawerApi.open();
}

function openAuthDrawer(row?: any) {
  authDrawerApi.setData({
    row,
  });
  authDrawerApi.open();
}

/* 创建 */
function handleCreate() {
  openDrawer(true);
}

/* 编辑 */
function handleEdit(row: any) {
  openDrawer(false, row);
}

/* 删除 */
async function handleDelete(row: any) {
  row.pending = true;
  try {
    await deleteRoleApi(row.id);

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

function handleSetAuth(row: any) {
  openAuthDrawer(row);
}
</script>

<template>
  <Page auto-content-height>
    <Grid :table-title="$t('page.system.role.title')">
      <template #toolbar-tools>
        <el-button
          class="mr-2"
          type="primary"
          v-permission="['system:role:create']"
          @click="handleCreate"
        >
          {{ $t('page.system.role.button.create') }}
        </el-button>
      </template>

      <template #status="{ row }">
        <el-switch
          :model-value="row.status === 1"
          :loading="row.pending"
          :inline-prompt="true"
          :active-text="$t('ui.switch.active')"
          :inactive-text="$t('ui.switch.inactive')"
          @change="(checked: boolean) => handleStatusChanged(row, checked)"
          :disabled="!hasPermission(['system:role:update'])"
        />
      </template>

      <template #createdAt="{ row }">
        {{ formatDateTime(row.createdAt) }}
      </template>

      <template #action="{ row }">
        <ElButton
          type="primary"
          link
          :icon="h(LucidePencil)"
          @click="() => handleSetAuth(row)"
        />

        <ElButton
          type="primary"
          link
          v-permission="['system:role:update']"
          :icon="h(LucideFilePenLine)"
          @click="() => handleEdit(row)"
        />

        <el-popconfirm
          :title="
            $t('ui.text.do_you_want_delete', {
              moduleName: $t('page.system.role.module'),
            })
          "
          :confirm-button-text="$t('ui.button.ok')"
          :cancElButton-text="$t('ui.button.cancel')"
          @confirm="() => handleDelete(row)"
        >
          <template #reference>
            <ElButton
              type="danger"
              v-permission="['system:role:delete']"
              link
              :icon="LucideTrash2"
            />
          </template>
        </el-popconfirm>
      </template>
    </Grid>
    <Drawer />
    <AuthDrawer />
  </Page>
</template>
