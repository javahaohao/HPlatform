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

	@Override
	public boolean equals(Object o) {
		if (this == o) return true;
		if (o == null || getClass() != o.getClass()) return false;

		ColumnValidate that = (ColumnValidate) o;

		if (columnId != null ? !columnId.equals(that.columnId) : that.columnId != null) return false;
		if (validateId != null ? !validateId.equals(that.validateId) : that.validateId != null) return false;
		if (validateVal != null ? !validateVal.equals(that.validateVal) : that.validateVal != null) return false;
		return validateMessage != null ? validateMessage.equals(that.validateMessage) : that.validateMessage == null;

	}

	@Override
	public int hashCode() {
		int result = columnId != null ? columnId.hashCode() : 0;
		result = 31 * result + (validateId != null ? validateId.hashCode() : 0);
		result = 31 * result + (validateVal != null ? validateVal.hashCode() : 0);
		result = 31 * result + (validateMessage != null ? validateMessage.hashCode() : 0);
		return result;
	}
}
