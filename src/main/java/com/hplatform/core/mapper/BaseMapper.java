package com.hplatform.core.mapper;

import java.util.List;

import com.hplatform.core.entity.BaseEntity;

public interface BaseMapper<T extends BaseEntity<T>> {
	/**
	 * 新增entity
	 * @param t
	 */
	public void addEntity(T t);
	/**
	 * 修改entity
	 * @param t
	 */
	public void updateEntity(T t);
	/**
	 * 删除entity
	 * @param t
	 */
	public void deleteEntity(T t);
	/**
	 * 批量删除entity
	 * @param t
	 */
	public void deleteBatchEntity(T t);
	/**
	 * 查询一个entity
	 * @param t
	 */
	public T findOne(T t);
	/**
	 * 查询所有entity
	 */
	public List<T> findAll(T t);
	
}
