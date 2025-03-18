import { requestClient } from '#/api/request';

/**
 * 获取字典列表
 */
export const getDictListApi = async (params: any) => {
  return requestClient.getWithParams('/dict/list', params);
};

/**
 * 获取字典信息
 */
export const getDictInfoApi = async (id: number) => {
  return requestClient.get(`/dict/info/${id}`);
};

/**
 * 新增字典信息
 *
 * @param param 数据
 * @returns
 */
export const createDictApi = async (param: any) => {
  return await requestClient.post('/dict/add', param);
};

/**
 * 修改字典信息
 *
 * @param id ID
 * @param param 数据
 * @returns
 */
export const updateDictApi = async (id: number, param: any) => {
  return await requestClient.put(`/dict/update/${id}`, param);
};

/**
 * 删除字典信息
 *
 * @param id ID
 * @returns
 */
export const deleteDictApi = async (id: number) => {
  return await requestClient.delete(`/dict/delete/${id}`);
};
