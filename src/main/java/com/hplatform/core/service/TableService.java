package com.hplatform.core.service;

import cn.org.rapid_framework.util.ObjectUtils;
import com.hplatform.core.common.util.ConstantsUtil;
import com.hplatform.core.common.util.FreeMarkerUtil;
import com.hplatform.core.common.util.PingYinUtil;
import com.hplatform.core.constants.ColumnsConstants;
import com.hplatform.core.constants.TableConstants;
import com.hplatform.core.entity.Columns;
import com.hplatform.core.entity.Table;
import com.hplatform.core.exception.CRUDException;
import com.hplatform.core.mapper.TableMapper;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Service
public class TableService extends BaseService<Table, TableMapper> {
	@Autowired
	private ColumnsService columnsService;
	@Autowired
	private ElementService elementService;
	/**
	 * 批量代码生成
	 * @param table
	 * @throws Exception 
	 */
	public void genCodeBatch(Table table) throws Exception {
		List<String> idList = Arrays.asList(table.getId().split(","));
		Table genTable = null;
		for(String id : idList){
			genTable = findOne(new Table(id));
			if(null!=genTable){
				if(Table.RelationType.one_2_more.equals(genTable.getRelationType())) {
					if(CollectionUtils.isNotEmpty(genTable.getChilds()))
						genOneToMore(genTable);
					else
						genOne(genTable);
				}else if(Table.RelationType.more_2_one.equals(genTable.getRelationType())) {
					if(ObjectUtils.isNotEmpty(genTable.getParent())){
						//反向按照一对多进行生成
						genTable.getParent().addChilds(genTable);
						genOneToMore(genTable.getParent());
					}else{
						//如果没有父表则按照单表生成策略生成
						genOne(genTable);
					}
				}else if (Table.RelationType.one.equals(genTable.getRelationType())){
					genOne(genTable);
				}else if (Table.RelationType.one_2_one.equals(genTable.getRelationType())){
					genOneToOne(genTable);
				}
			}

		}
	}

	/**
	 * 生成单表
	 * @param genTable
	 * @throws Exception
	 */
	public void genOne(Table genTable) throws Exception {
		genTable = comTable(genTable);
		genTable.setRelationType(Table.RelationType.one);
		FreeMarkerUtil.genCode(genTable);
	}

	/**
	 * 生成一对一的表结构代码
	 * @param genTable
	 * @throws Exception
	 */
	public void genOneToOne(Table genTable)throws Exception {
		//主表采用一对一模板从表采用多对一模板
		genOneToMore(genTable);
	}
	/**
	 * 生成一对多代码
	 * @param genTable
	 * @throws Exception
	 */
	public void genOneToMore(Table genTable) throws Exception {
		genTable = comTable(genTable);
		FreeMarkerUtil.genCode(genTable);
		genChildCode(genTable);
	}

	/**
	 * 按照关系生成子表代码
	 * @param parent
	 * @throws Exception
	 */
	public void genChildCode(Table parent) throws Exception{
		for(Table child : parent.getChilds()){
			child.setParent(parent);
			child.setRelationType(Table.RelationType.more_2_one);
			FreeMarkerUtil.genCode(child);
		}
	}
	/**
	 * 按照表id组合表与字段的关系
	 * @param genTable
	 * @return
	 */
	public Table comTable(Table genTable)throws CRUDException{
		try {
			Columns columns = new Columns();
			columns.setTableId(genTable.getId());
			columns.setGenFlag(Boolean.TRUE);
			ArrayList<Columns> columnList = columnsService.findByRelation(columns);
			for(Table child:genTable.getChilds()){
				columns.setTableId(child.getId());
				child.setColumnList(columnsService.findByRelation(columns));
			}
			genTable.setColumnList(columnList);
		} catch (CRUDException e) {
			log.error(e);
			throw new CRUDException(e);
		}
		return genTable;
	}
	@Override
	public void save(Table t) throws CRUDException {
		super.save(t);
		if(CollectionUtils.isNotEmpty(t.getChilds())){
			for(Table child : t.getChilds()){
				child.setParent(t);
				child.setStep(TableConstants.GEN_STEP_ONE);
				super.save(child);
			}
		}
	}

	@Override
	public void update(Table t) throws CRUDException {
		super.update(t);
		if(CollectionUtils.isNotEmpty(t.getChilds())){
			for(Table child : t.getChilds()){
				if(StringUtils.isNotBlank(child.getId()))
					super.update(child);
				else
					super.save(child);
			}
		}
	}

	/**
	 * 修改标的生成标识为已完成
	 * @param id
	 * @throws CRUDException
	 */
	public void updateGenComplete(String id) throws CRUDException {
		Table update = new Table(id);
		update.setStatu(ConstantsUtil.get().getDICT_YES_PARENT_ID());
		update.setStep(TableConstants.GEN_STEP_THREE);
		update.setGenFlag(true);
		super.update(update);
	}

	/**
	 * 重置方案生成规则
	 * @param tableId
	 */
	public void resetGenRules(String tableId)throws CRUDException{
		try{
			Table table = new Table(tableId);
			columnsService.resetGenRules(table);
			table.setStep(TableConstants.GEN_STEP_ONE);
			table.setStatu(ConstantsUtil.get().getDICT_NO_PARENT_ID());
			table.setGenFlag(true);
			super.update(table);
		}catch(Exception e){
			log.error(e);
			throw new CRUDException(e);
		}
	}

	/**********自定义表单start*************/
	/**
	 * 保存自定义表单方案
	 * @param table
	 */
	public void saveFormProgramme(Table table) throws CRUDException {
		saveFormTable(table);
		saveFormColumns(table);
	}

	/**
	 * 保存自定义表单表定义方案
	 * @param table
	 */
	public void saveFormTable(Table table)throws CRUDException{
		try {
			String comments = PingYinUtil.getFirstSpell(table.getComments());
			table.setRelationType(Table.RelationType.one);
			table.setTableName(comments.toUpperCase());
			table.setTableAlias(comments.toLowerCase());
			table.setDomainName(com.hplatform.core.common.util.StringUtils.getFirstUperHumStr(comments));
			table.setBumodel("form");
			table.setPkg("com.hplatform");
			table.setStatu(ConstantsUtil.get().getDICT_NO_PARENT_ID());
			table.setStep(2);
			table.setGenFlag(true);
			table.setGenType(ConstantsUtil.get().getZERO());
            if(org.apache.commons.lang.StringUtils.isNotBlank(table.getId()))
                super.update(table);
            else
			    super.save(table);
		} catch (CRUDException e) {
			log.error(e);
			throw new CRUDException(e);
		}
	}

	/**
	 * 保存自定义表单定义的列方案
	 * @param table
	 * @throws CRUDException
	 */
	public void saveFormColumns(Table table) throws CRUDException {
		try {
			List<Columns> columns = table.getColumnList();
			if(CollectionUtils.isNotEmpty(columns)){
				columns.addAll(ColumnsConstants.defaultsColumns);
				String comments = null;
				for(Columns c : columns){
					comments =PingYinUtil.getFirstSpell(c.getComments());
					c.setTableId(table.getId());
					if(StringUtils.isEmpty(c.getColumnName()))
						c.setColumnName(comments);
					if(c.getColumnLength()!=null)
						c.setColumnType(String.format("%s(%s)",c.getDataType(),c.getColumnLength()));
					else
						c.setColumnType(c.getDataType());
					c.setPropertiesName(com.hplatform.core.common.util.StringUtils.getHumpStr(c.getColumnName()));
					c.setPropertiesType(ConstantsUtil.get().getMysqlDataType(c.getDataType()));
				}
				//全删全增维护列，方便前台维护
				if(StringUtils.isNotBlank(table.getId())){
					Columns delete = new Columns();
					delete.setTableId(table.getId());
					columnsService.deleteColumnsByTable(delete);
				}
				columnsService.editColumns(columns);
			}
		} catch (CRUDException e) {
			log.error(e);
			throw new CRUDException(e);
		}
	}

    /**
     * 生成自定义表单代码
     * @param table
     */
	public void genForm(Table table) throws CRUDException {
        try {
			//删除表
			dropTable(table);
            //创建表
            createTable(table);
            //生成代码
            genCodeBatch(table);
        } catch (Exception e) {
            log.error(e);
            throw new CRUDException(e);
        }
    }

    /**
     *  创建表
     * @param table
     * @throws CRUDException
     */
    public void createTable(Table table) throws CRUDException {
        try {
            m.createTable(table);
        } catch (Exception e) {
            log.error(e);
            throw new CRUDException(e);
        }
    }

	/**
	 * 删除表
	 * @param table
	 * @throws CRUDException
	 */
    public void dropTable(Table table) throws CRUDException {
        try {
            m.dropTable(table);
        } catch (Exception e) {
            log.error(e);
            throw new CRUDException(e);
        }
    }
	/**********自定义表单end*************/
}
