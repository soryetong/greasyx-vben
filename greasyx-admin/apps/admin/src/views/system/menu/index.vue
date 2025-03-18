<script lang="ts" setup>
import { h } from 'vue';
import { useVbenVxeGrid, type VxeGridProps } from '#/adapter/vxe-table';
import { $t } from '#/locales';
import { Page, useVbenDrawer, type VbenFormProps } from '@vben/common-ui';
import { LucideFilePenLine, LucideTrash2 } from '@vben/icons';
import { ElButton } from 'element-plus';
import MenuDrawer from './drawer.vue';
import { deleteMenuApi, getMenuTreeApi, updateMenuApi } from '#/api';
import { MenuType, statusList } from '#/store';
import { Icon } from '@iconify/vue';
import { useToast, POSITION } from 'vue-toastification';
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
    // {
    //   component: 'Input',
    //   fieldName: 'name',
    //   label: $t('page.system.menu.name'),
    //   defaultValue: '',
    //   componentProps: {
    //     placeholder: $t('ui.placeholder.input'),
    //     allowClear: true,
    //   },
    // },
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
        return await getMenuTreeApi({
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
      title: $t('page.system.menu.name'),
      field: 'meta.name',
      slots: { default: 'title' },
      treeNode: true,
    },
    {
      title: $t('page.system.menu.type'),
      field: 'type',
      slots: { default: 'type' },
    },
    {
      title: $t('page.system.menu.icon'),
      field: 'meta.icon',
      slots: { default: 'icon' },
    },
    {
      title: $t('page.system.menu.path'),
      field: 'path',
    },
    {
      title: $t('page.system.menu.component'),
      field: 'component',
      width: 320,
    },
    {
      title: $t('page.system.menu.perm'),
      field: 'perm',
    },
    {
      title: $t('ui.table.status'),
      field: 'status',
      slots: { default: 'status' },
    },
    {
      title: $t('ui.table.updateTime'),
      field: 'updateTime',
      formatter: 'formatDateTime',
      width: 160,
    },
    {
      title: $t('ui.table.action'),
      field: 'action',
      fixed: 'right',
      slots: { default: 'action' },
    },
  ],
};

const [Grid, gridApi] = useVbenVxeGrid({
  gridOptions,
  formOptions,
});

const expandAll = () => {
  gridApi.grid?.setAllTreeExpand(true);
};

const collapseAll = () => {
  gridApi.grid?.setAllTreeExpand(false);
};

async function handleStatusChanged(row: any, checked: boolean) {
  row.pending = true;
  row.status = checked ? 1 : 2;
  try {
    await updateMenuApi(row.id, row);

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
  connectedComponent: MenuDrawer,
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
    await deleteMenuApi(row.id);

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
    <Grid :table-title="$t('page.system.menu.title')">
      <template #toolbar-tools>
        <el-button
          class="mr-2"
          type="primary"
          v-permission="['system:menu:create']"
          @click="handleCreate"
        >
          {{ $t('page.system.menu.button.create') }}
        </el-button>
        <el-button class="mr-2" @click="expandAll">
          {{ $t('ui.tree.expand_all') }}
        </el-button>
        <el-button class="mr-2" @click="collapseAll">
          {{ $t('ui.tree.collapse_all') }}
        </el-button>
      </template>

      <template #title="{ row }">
        <span :style="{ marginRight: '15px' }">{{ $t(row.meta.name) }}</span>
      </template>

      <template #type="{ row }">
        <el-tag v-if="row.type === MenuType.FOLDER" type="warning">
          目录
        </el-tag>
        <el-tag v-if="row.type === MenuType.MENU" type="success"> 菜单 </el-tag>
        <el-tag v-if="row.type === MenuType.BUTTON" type="danger">
          按钮
        </el-tag>
      </template>

      <template #icon="{ row }">
        <div class="flex h-full items-center justify-center">
          <Icon
            v-if="row.meta.icon !== undefined"
            :icon="row.meta.icon"
            class="size-4"
          />
        </div>
      </template>

      <template #status="{ row }">
        <el-switch
          :model-value="row.status === 1"
          :loading="row.pending"
          :inline-prompt="true"
          :active-text="$t('ui.switch.active')"
          :inactive-text="$t('ui.switch.inactive')"
          @change="(checked: boolean) => handleStatusChanged(row, checked)"
          :disabled="!hasPermission(['system:menu:update'])"
        />
      </template>

      <template #action="{ row }">
        <ElButton
          type="primary"
          link
          v-permission="['system:menu:update']"
          :icon="h(LucideFilePenLine)"
          @click="() => handleEdit(row)"
        />

        <el-popconfirm
          :title="
            $t('ui.text.do_you_want_delete', {
              moduleName: $t('page.system.menu.module'),
            })
          "
          :confirm-button-text="$t('ui.button.ok')"
          :cancElButton-text="$t('ui.button.cancel')"
          @confirm="() => handleDelete(row)"
        >
          <template #reference>
            <ElButton
              type="danger"
              v-permission="['system:menu:delete']"
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
