import type { UserInfo } from '@vben/types';

import { requestClient } from '#/api/request';

/**
 * 获取用户信息
 */
export const getUserInfoApi = async () => {
  return requestClient.get<UserInfo>('/user/info');
};

/**
 * 获取用户列表
 */
export const getUserListApi = async (param: any) => {
  return requestClient.getWithParams('/user/list', param);
};

/**
 * 新增用户信息
 *
 * @param param 数据
 * @returns
 */
export const createUserApi = async (param: any) => {
  return await requestClient.post('/user/add', param);
};

/**
 * 修改用户信息
 *
 * @param id ID
 * @param param 数据
 * @returns
 */
export const updateUserApi = async (id: number, param: any) => {
  return await requestClient.put(`/user/update/${id}`, param);
};

/**
 * 删除用户信息
 *
 * @param id ID
 * @param param 数据
 * @returns
 */
export const deleteUserApi = async (id: number) => {
  return await requestClient.delete(`/user/delete/${id}`);
};
