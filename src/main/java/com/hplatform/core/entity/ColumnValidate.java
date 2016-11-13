package com.hplatform.core.entity;

public class ColumnValidate extends BaseEntity<ColumnValidate> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String columnId;
	private String validateId;
	private String validateVal;
	private String validateMessage;
	private Dict validate;
	
	public Dict getValidate() {
		return validate;
	}
	public void setValidate(Dict validate) {
		this.validate = validate;
	}
	public String getValidateMessage() {
		return validateMessage;
	}
	public void setValidateMessage(String validateMessage) {
		this.validateMessage = validateMessage;
	}
	public String getColumnId() {
		return columnId;
	}
	public void setColumnId(String columnId) {
		this.columnId = columnId;
	}
	public String getValidateId() {
		return validateId;
	}
	public void setValidateId(String validateId) {
		this.validateId = validateId;
	}
	public String getValidateVal() {
		return validateVal;
	}
	public void setValidateVal(String validateVal) {
		this.validateVal = validateVal;
	}
}
