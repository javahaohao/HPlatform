package com.hplatform.core.exception;
/**
 * 说明：数据操作自定义异常类 <br>
 * 作者：libing<br>
 * 更改记录： <br>
 * -------------------------------------------------------<br>
 * 改动人 时间 原因<br>
 * -------------------------------------------------------<br>
 * libing 2011-07-26 创建文件<br>
 * -------------------------------------------------------<br>
 */
public class CRUDException extends Exception {

    private static final long serialVersionUID = 4570573798200354363L;

    public CRUDException(String msg) {
        super(msg);
    }

    public CRUDException(Throwable cause) {
        super(cause);
    }

    public CRUDException(String msg, Throwable cause) {
        super(msg, cause);
    }
}
