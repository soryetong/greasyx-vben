<script lang="ts" setup>
import { h } from 'vue';
import { useVbenVxeGrid, type VxeGridProps } from '#/adapter/vxe-table';
import { $t } from '#/locales';
import { Page, useVbenDrawer, type VbenFormProps } from '@vben/common-ui';
import { LucideFilePenLine, LucideTrash2 } from '@vben/icons';
import { ElButton } from 'element-plus';
import UserDrawer from './drawer.vue';
import { deleteUserApi, getUserListApi, updateUserApi } from '#/api';
import { statusList } from '#/store';
import { useToast, POSITION } from 'vue-toastification';
import { formatDateTime } from '@vben/utils';
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
      fieldName: 'username',
      label: $t('page.system.user.username'),
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
    ajax: {
      query: async ({ page }, formValues) => {
        return await getUserListApi({
          page: page.currentPage,
          pageSize: page.pageSize,
          username: formValues.username,
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
      title: $t('page.system.user.username'),
      field: 'username',
    },
    {
      title: $t('page.system.user.nickName'),
      field: 'nickname',
    },
    {
      title: $t('page.system.user.email'),
      field: 'email',
    },
    {
      title: $t('page.system.user.role'),
      field: 'roleName',
      slots: { default: 'roleName' },
    },
    {
      title: $t('ui.table.status'),
      field: 'status',
      slots: { default: 'status' },
    },
    {
      title: $t('page.system.user.lastLoginTime'),
      field: 'lastLoginTime',
      slots: { default: 'lastLoginTime' },
    },
    {
      title: $t('page.system.user.lastLoginIp'),
      field: 'lastLoginIp',
    },
    {
      title: $t('ui.table.createTime'),
      field: 'createTime',
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
    await updateUserApi(row.id, row);

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
  connectedComponent: UserDrawer,
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
    await deleteUserApi(row.id);

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
    <Grid :table-title="$t('page.system.user.title')">
      <template #toolbar-tools>
        <el-button
          class="mr-2"
          v-permission="['system:user:create']"
          type="primary"
          @click="handleCreate"
        >
          {{ $t('page.system.user.button.create') }}
        </el-button>
      </template>

      <template #createdAt="{ row }">
        {{ formatDateTime(row.createdAt) }}
      </template>

      <template #roleName="{ row }">
        <el-tag type="success" size="large">
          {{ row.roleName }}
        </el-tag>
      </template>

      <template #status="{ row }">
        <el-switch
          :model-value="row.status === 1"
          :loading="row.pending"
          :inline-prompt="true"
          :active-text="$t('ui.switch.active')"
          :inactive-text="$t('ui.switch.inactive')"
          @change="(checked: boolean) => handleStatusChanged(row, checked)"
          :disabled="!hasPermission(['system:user:update'])"
        />
      </template>

      <template #lastLoginTime="{ row }">
        {{ formatDateTime(row.lastLoginTime) }}
      </template>

      <template #action="{ row }">
        <ElButton
          type="primary"
          link
          v-permission="['system:user:update']"
          :icon="h(LucideFilePenLine)"
          @click="() => handleEdit(row)"
        />

        <el-popconfirm
          :title="
            $t('ui.text.do_you_want_delete', {
              moduleName: $t('page.system.user.module'),
            })
          "
          :confirm-button-text="$t('ui.button.ok')"
          :cancElButton-text="$t('ui.button.cancel')"
          @confirm="() => handleDelete(row)"
        >
          <template #reference>
            <ElButton
              type="danger"
              v-permission="['system:user:delete']"
              link
              :icon="LucideTrash2"
            />
          </template>
        </el-popconfirm>
      </template>
    </Grid>
    <Drawer />
  </Page>
</template>
