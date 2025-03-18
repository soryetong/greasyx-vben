<script lang="ts" setup>
import { useVbenDrawer } from '@vben/common-ui';
import { ref } from 'vue';
import type { TreeInstance } from 'element-plus';
import {
  MenuApi,
  getMenuTreeApi,
  buildMenuTree,
  updateRoleAuthApi,
  getRoleInfoApi,
  // 新增API相关接口
  getApiListApi,
  buildApiTree,
} from '#/api';
import type { TreeKey } from 'element-plus/es/components/tree/src/tree.type.mjs';
import { useToast, POSITION } from 'vue-toastification';
import { $t } from '@vben/locales';
import { nextTick } from 'vue';

const toast = useToast();
const data = ref();
// 添加激活的标签页
const activeTab = ref('menu');

// 添加API树相关数据
const apiTreeData = ref<any[]>([]);
const apiTreeRef = ref<TreeInstance>();

const [Drawer, drawerApi] = useVbenDrawer({
  async onOpened() {
    data.value = drawerApi.getData<Record<string, any>>();

    // 同时获取菜单树和API树
    const [menuResult, apiResult] = await Promise.all([
      getMenuTreeApi(null),
      getApiListApi(null),
    ]);

    treeData.value = buildMenuTree(menuResult.items);
    apiTreeData.value = buildApiTree(apiResult.items);

    if (data.value?.row?.id) {
      const roleAuth = await getRoleInfoApi(data.value.row.id);
      await nextTick();
      await nextTick();

      if (roleAuth?.authId && treeRef.value) {
        treeRef.value.setCheckedKeys([], false);
        expandAll();
        setTimeout(() => {
          if (treeRef.value) {
            treeRef.value.setCheckedKeys(roleAuth.authId, false);
          }
        }, 100);
      }

      // 设置API树的选中状态
      if (roleAuth?.apiId && apiTreeRef.value) {
        apiTreeRef.value.setCheckedKeys([], false);
        expandApiAll();
        setTimeout(() => {
          if (apiTreeRef.value) {
            apiTreeRef.value.setCheckedKeys(roleAuth.apiId, false);
          }
        }, 100);
      }
    }
  },

  async onConfirm() {
    let authId: TreeKey[] = [];
    let apiId: TreeKey[] = [];

    // 获取菜单权限
    if (treeRef.value) {
      const checkedKeys = treeRef.value.getCheckedKeys();
      const halfCheckedKeys = treeRef.value.getHalfCheckedKeys();
      authId = [...checkedKeys, ...halfCheckedKeys];
    }

    // 获取API权限
    if (apiTreeRef.value) {
      const checkedKeys = apiTreeRef.value.getCheckedKeys();
      const halfCheckedKeys = apiTreeRef.value.getHalfCheckedKeys();
      apiId = [...checkedKeys, ...halfCheckedKeys];
    }

    if (authId.length <= 0 && apiId.length <= 0) {
      toast.error($t('ui.notification.no_auth'), {
        timeout: 2000,
        position: POSITION.TOP_CENTER,
      });
      return;
    }

    setLoading(true);
    try {
      // 更新权限，同时提交菜单权限和API权限
      await updateRoleAuthApi(data.value.row.id, { authId, apiId });

      toast.success($t('ui.notification.update_success'), {
        timeout: 1000,
        position: POSITION.TOP_RIGHT,
        toastClassName: 'toastification-success',
      });
      drawerApi.setData({ needRefresh: true });
    } catch {
      // toast.error($t('ui.notification.update_failed'), {
      //   timeout: 2000,
      //   position: POSITION.TOP_CENTER,
      // });
    } finally {
      drawerApi.close();
      setLoading(false);
    }
  },
});

const treeData = ref<MenuApi.MenuForm[]>([]);

const treeRef = ref<TreeInstance>();
const defaultProps = {
  children: 'children',
  label: 'name',
};

// 添加 API 树的专用 props
const apiDefaultProps = {
  children: 'children',
  label: 'description',
};

// 递归获取所有节点的 key
const getAllKeys = (data: MenuApi.MenuForm[]): number[] => {
  const keys: number[] = [];
  const traverse = (nodes: MenuApi.MenuForm[]) => {
    nodes.forEach((node) => {
      if (node.id !== undefined && node.id !== null) {
        keys.push(node.id);
      }
      if (node.children?.length) {
        traverse(node.children);
      }
    });
  };
  traverse(data);
  return keys;
};

// 展开所有节点
const expandAll = () => {
  if (treeRef.value) {
    const allKeys = getAllKeys(treeData.value);
    allKeys.forEach((key) => {
      treeRef.value?.store?.nodesMap[key]?.expand();
    });
  }
};

// 收起所有节点
const collapseAll = () => {
  if (treeRef.value) {
    const allKeys = getAllKeys(treeData.value);
    allKeys.forEach((key) => {
      treeRef.value?.store?.nodesMap[key]?.collapse();
    });
  }
};

// 全选所有节点
const checkAll = () => {
  if (treeRef.value) {
    const allKeys = getAllKeys(treeData.value);
    treeRef.value.setCheckedKeys(allKeys);
  }
};

// 取消全选
const uncheckAll = () => {
  if (treeRef.value) {
    treeRef.value.setCheckedKeys([]);
  }
};

// 添加API树操作方法
// 展开所有API节点
const expandApiAll = () => {
  if (apiTreeRef.value) {
    const allKeys = getAllApiKeys(apiTreeData.value);
    allKeys.forEach((key) => {
      apiTreeRef.value?.store?.nodesMap[key]?.expand();
    });
  }
};

// 收起所有API节点
const collapseApiAll = () => {
  if (apiTreeRef.value) {
    const allKeys = getAllApiKeys(apiTreeData.value);
    allKeys.forEach((key) => {
      apiTreeRef.value?.store?.nodesMap[key]?.collapse();
    });
  }
};

// 全选所有API节点
const checkApiAll = () => {
  if (apiTreeRef.value) {
    const allKeys = getAllApiKeys(apiTreeData.value);
    apiTreeRef.value.setCheckedKeys(allKeys);
  }
};

// 取消全选API节点
const uncheckApiAll = () => {
  if (apiTreeRef.value) {
    apiTreeRef.value.setCheckedKeys([]);
  }
};

// 递归获取所有API节点的key
const getAllApiKeys = (data: any[]): number[] => {
  const keys: number[] = [];
  const traverse = (nodes: any[]) => {
    nodes.forEach((node) => {
      if (node.id !== undefined && node.id !== null) {
        keys.push(node.id);
      }
      if (node.children?.length) {
        traverse(node.children);
      }
    });
  };
  traverse(data);
  return keys;
};

function setLoading(loading: boolean) {
  drawerApi.setState({ loading });
}
</script>

<template>
  <Drawer :title="$t('page.system.role.button.auth')">
    <el-tabs v-model="activeTab" class="mb-4" type="border-card">
      <!-- 菜单权限标签页 -->
      <el-tab-pane :label="$t('page.system.role.menuAuth')" name="menu">
        <div class="flex flex-col gap-4">
          <div class="flex gap-2">
            <el-button @click="expandAll">{{
              $t('ui.tree.expand_all')
            }}</el-button>
            <el-button @click="collapseAll">{{
              $t('ui.tree.collapse_all')
            }}</el-button>
            <el-button @click="checkAll">{{
              $t('ui.tree.select_all')
            }}</el-button>
            <el-button @click="uncheckAll">{{
              $t('ui.tree.unselect_all')
            }}</el-button>
          </div>

          <el-tree
            ref="treeRef"
            :data="treeData"
            show-checkbox
            node-key="id"
            :props="defaultProps"
            :check-strictly="false"
            class="w-full"
          >
            <template #default="{ data }">
              <div class="flex items-center">
                <el-icon v-if="data.meta.icon" class="mr-2">
                  <component :is="data.meta.icon" />
                </el-icon>
                <span>{{ data.meta.name }}</span>
              </div>
            </template>
          </el-tree>
        </div>
      </el-tab-pane>

      <!-- API权限标签页 -->
      <el-tab-pane :label="$t('page.system.role.apiAuth')" name="api">
        <div class="flex flex-col gap-4">
          <div class="flex gap-2">
            <el-button @click="expandApiAll">{{
              $t('ui.tree.expand_all')
            }}</el-button>
            <el-button @click="collapseApiAll">{{
              $t('ui.tree.collapse_all')
            }}</el-button>
            <el-button @click="checkApiAll">{{
              $t('ui.tree.select_all')
            }}</el-button>
            <el-button @click="uncheckApiAll">{{
              $t('ui.tree.unselect_all')
            }}</el-button>
          </div>

          <el-tree
            ref="apiTreeRef"
            :data="apiTreeData"
            show-checkbox
            node-key="id"
            :props="apiDefaultProps"
            :check-strictly="false"
            class="w-full"
          >
            <template #default="{ data }">
              <div class="flex items-center">
                <span>{{ data.description }}</span>
                <span v-if="data.path" class="ml-2 text-xs text-gray-400">{{
                  data.path
                }}</span>
              </div>
            </template>
          </el-tree>
        </div>
      </el-tab-pane>
    </el-tabs>
  </Drawer>
</template>
