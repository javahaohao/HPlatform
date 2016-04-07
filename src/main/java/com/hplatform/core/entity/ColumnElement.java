package com.hplatform.core.entity;

public class ColumnElement extends BaseEntity<ColumnElement> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String columnId;
	private String elementId;
	private Element element;
	private String elementValue;
	
	public Element getElement() {
		return element;
	}
	public void setElement(Element element) {
		this.element = element;
	}
	public String getColumnId() {
		return columnId;
	}
	public void setColumnId(String columnId) {
		this.columnId = columnId;
	}
	public String getElementId() {
		return elementId;
	}
	public void setElementId(String elementId) {
		this.elementId = elementId;
	}
	public String getElementValue() {
		return elementValue;
	}
	public void setElementValue(String elementValue) {
		this.elementValue = elementValue;
	}
}
