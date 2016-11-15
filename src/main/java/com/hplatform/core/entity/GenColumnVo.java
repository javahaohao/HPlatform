package com.hplatform.core.entity;

import java.util.List;

/**
 * use for: 默认标签映射
 * Created by javahao on 2016/11/15.
 * auth:JavaHao
 */
public class GenColumnVo {
    private String columnKey;
    private String pluginId;
    private List<Element> elementList;

    public GenColumnVo() {
    }

    public GenColumnVo(String columnKey, String pluginId, List<Element> elementList) {
        this.columnKey = columnKey;
        this.pluginId = pluginId;
        this.elementList = elementList;
    }

    public String getColumnKey() {
        return columnKey;
    }

    public void setColumnKey(String columnKey) {
        this.columnKey = columnKey;
    }

    public String getPluginId() {
        return pluginId;
    }

    public void setPluginId(String pluginId) {
        this.pluginId = pluginId;
    }

    public List<Element> getElementList() {
        return elementList;
    }

    public void setElementList(List<Element> elementList) {
        this.elementList = elementList;
    }
}
