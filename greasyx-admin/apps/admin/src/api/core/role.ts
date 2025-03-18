import { requestClient } from '#/api/request';

/**
 * 获取角色列表
 */
export const getRoleListApi = async (params: any) => {
  return requestClient.getWithParams('/role/list', params);
};

/**
 * 获取角色信息
 */
export const getRoleInfoApi = async (id: number) => {
  return requestClient.get(`/role/info/${id}`);
};

/**
 * 新增角色信息
 *
 * @param param 数据
 * @returns
 */
export const createRoleApi = async (param: any) => {
  return await requestClient.post('/role/add', param);
};

/**
 * 修改角色信息
 *
 * @param id ID
 * @param param 数据
 * @returns
 */
export const updateRoleApi = async (id: number, param: any) => {
  return await requestClient.put(`/role/update/${id}`, param);
};

/**
 * 删除角色信息
 *
 * @param id ID
 * @returns
 */
export const deleteRoleApi = async (id: number) => {
  return await requestClient.delete(`/role/delete/${id}`);
};

/**
 * 分配权限
 *
 * @param id ID
 * @param param 数据
 * @returns
 */
export const updateRoleAuthApi = async (id: number, param: any) => {
  return await requestClient.put(`/role/assign/${id}`, param);
};
