import { requestClient } from '#/api/request';

/**
 * 获取API列表
 */
export const getApiListApi = async (params: any) => {
  return requestClient.getWithParams('/api/list', params);
};

/**
 * 新增API信息
 *
 * @param param 数据
 * @returns
 */
export const createApiApi = async (param: any) => {
  return await requestClient.post('/api/add', param);
};

/**
 * 修改API信息
 *
 * @param id ID
 * @param param 数据
 * @returns
 */
export const updateApiApi = async (id: number, param: any) => {
  return await requestClient.put(`/api/update/${id}`, param);
};

/**
 * 删除API信息
 *
 * @param id ID
 * @returns
 */
export const deleteApiApi = async (id: number) => {
  return await requestClient.delete(`/api/delete/${id}`);
};
