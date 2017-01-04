package com.hplatform.core.service;

import com.hplatform.core.entity.BaseEntity;
import com.hplatform.core.entity.Page;
import com.hplatform.core.exception.CRUDException;
import com.hplatform.core.mapper.BaseMapper;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Arrays;
import java.util.List;

public abstract class BaseService<T extends BaseEntity<T>, M extends BaseMapper<T>> {
	
	protected final transient Log log = LogFactory.getLog(this.getClass());
	
	@Autowired
	protected M m;

	/**
	 * 根据对象ID查询一个对象
	 * 
	 * @param t
	 * @return
	 * @throws CRUDException 
	 */
	public T findOne(T t) throws CRUDException {
		try{
			return m.findOne(t);
		}catch(Exception e){
			log.error(e);
			throw new CRUDException(e);
		}
	}

	/**
	 * 查询满足条件的对象集合，当t中所有属性为空时查询所有对象
	 * 
	 * @param t
	 * @return
	 * @throws CRUDException 
	 */
	public List<T> findAll(T t) throws CRUDException {
		try{
			return m.findAll(t);
		}catch(Exception e){
			log.error(e);
			throw new CRUDException(e);
		}
	}
	/**
	 * 按照分页查询数据
	 * @param t
	 * @return
	 * @throws CRUDException 
	 */
	public Page<T> findAllByPage(T t) throws CRUDException {
		try{
			Page.setPageFromRequest();
			return new Page<T>(m.findAll(t));
		}catch(Exception e){
			log.error(e);
			throw new CRUDException(e);
		}
	}
	/**
	 * 保存一个对象
	 * 
	 * @param t
	 * @throws CRUDException 
	 */
	public void save(T t) throws CRUDException {
		try{
			t.preInsert();
			m.addEntity(t);
		}catch(Exception e){
			log.error(e);
			throw new CRUDException(e);
		}
	}

	/**
	 * 更新一个对象
	 * 
	 * @param t
	 * @throws CRUDException 
	 */
	public void update(T t) throws CRUDException {
		try{
			t.preUpdate();
			m.updateEntity(t);
		}catch(Exception e){
			log.error(e);
			throw new CRUDException(e);
		}
	}

	/**
	 * 根据ID删除一个对象
	 * 
	 * @param t
	 * @throws CRUDException 
	 */
	public void delete(T t) throws CRUDException {
		try{
			m.deleteEntity(t);
		}catch(Exception e){
			log.error(e);
			throw new CRUDException(e);
		}
	}

	/**
	 * 根据idList批量删除对象
	 * 
	 * @param t
	 * @throws CRUDException 
	 */
	public void deleteBatch(T t) throws CRUDException {
		try{
			t.setIdList(Arrays.asList(t.getId().split(",")));
			m.deleteBatchEntity(t);
		}catch(Exception e){
			log.error(e);
			throw new CRUDException(e);
		}
	}
}
