import { requestClient } from '#/api/request';

/**
 * 获取日志列表
 */
export const getRecordListApi = async (params: any) => {
  return requestClient.getWithParams('/record/list', params);
};

/**
 * 删除日志信息
 *
 * @param id ID
 * @returns
 */
export const deleteRecordApi = async (id: number) => {
  return await requestClient.delete(`/record/delete/${id}`);
};
