<script lang="ts" setup>
import { h } from 'vue';
import { useVbenVxeGrid, type VxeGridProps } from '#/adapter/vxe-table';
import { $t } from '#/locales';
import { Page, useVbenDrawer, type VbenFormProps } from '@vben/common-ui';
import { LucideFilePenLine, LucideTrash2 } from '@vben/icons';
import { ElButton } from 'element-plus';
import ApiDrawer from './drawer.vue';
import { deleteApiApi, getApiListApi } from '#/api';
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
      fieldName: 'description',
      label: $t('page.system.api.description'),
      componentProps: {
        placeholder: $t('ui.placeholder.input'),
        allowClear: true,
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
  pagerConfig: {
    enabled: false,
  },
  rowConfig: {
    isHover: true,
    height: 56,
  },
  stripe: true,
  treeConfig: {
    parentField: 'parentId',
    childrenField: 'children',
    rowField: 'id',
    transform: true,
  },

  proxyConfig: {
    ajax: {
      query: async ({ page }, formValues) => {
        return await getApiListApi({
          page: page.currentPage,
          pageSize: page.pageSize,
          description: formValues.description,
          path: formValues.path,
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
      title: $t('page.system.api.parentId'),
      field: 'parentId',
      slots: { default: 'parentId' },
      treeNode: true,
    },
    {
      title: $t('page.system.api.description'),
      field: 'description',
    },
    {
      title: $t('page.system.api.method'),
      field: 'method',
    },
    {
      title: $t('page.system.api.path'),
      field: 'path',
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

const [Drawer, drawerApi] = useVbenDrawer({
  connectedComponent: ApiDrawer,
  onClosed() {
    const data = drawerApi.getData();
    if (data && data.needRefresh) {
      gridApi.query();
    }
  },
});

const expandAll = () => {
  gridApi.grid?.setAllTreeExpand(true);
};

const collapseAll = () => {
  gridApi.grid?.setAllTreeExpand(false);
};

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
    await deleteApiApi(row.id);

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
    <Grid :table-title="$t('page.system.api.title')">
      <template #toolbar-tools>
        <el-button
          class="mr-2"
          v-permission="['system:api:create']"
          type="primary"
          @click="handleCreate"
        >
          {{ $t('page.system.api.button.create') }}
        </el-button>

        <el-button class="mr-2" @click="expandAll">
          {{ $t('ui.tree.expand_all') }}
        </el-button>
        <el-button class="mr-2" @click="collapseAll">
          {{ $t('ui.tree.collapse_all') }}
        </el-button>
      </template>

      <template #createdAt="{ row }">
        {{ formatDateTime(row.createdAt) }}
      </template>

      <template #parentId="{ row }">
        <span :style="{ marginRight: '15px' }">
          <template v-if="row.parentId === 0"> 根API </template></span
        >
      </template>

      <template #action="{ row }">
        <ElButton
          type="primary"
          link
          v-permission="['system:api:update']"
          :icon="h(LucideFilePenLine)"
          @click="() => handleEdit(row)"
        />

        <el-popconfirm
          :title="
            $t('ui.text.do_you_want_delete', {
              moduleName: $t('page.system.api.module'),
            })
          "
          :confirm-button-text="$t('ui.button.ok')"
          :cancElButton-text="$t('ui.button.cancel')"
          @confirm="() => handleDelete(row)"
        >
          <template #reference>
            <ElButton
              type="danger"
              v-permission="['system:api:delete']"
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
