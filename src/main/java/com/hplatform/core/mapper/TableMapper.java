package com.hplatform.core.mapper;

import com.hplatform.core.common.annotation.MyBatisMapper;
import com.hplatform.core.entity.Table;

@MyBatisMapper
public interface TableMapper extends BaseMapper<Table>{
    /**
     * 创建表
     * @param table
     */
    public void createTable(Table table);

    /**
     * 删除表
     * @param table
     */
    public void dropTable(Table table);
}
