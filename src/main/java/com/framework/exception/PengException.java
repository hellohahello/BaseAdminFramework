package com.framework.exception;

/**
 * @auther: 翁筱寒
 * @date: 2020/4/10 13:31
 * @desc: //
 */
public class PengException extends Exception {
    private static final long serialVersionUID = 1L;

    // 异常信息
    public String message;

    public PengException(String message){
        super(message);
        this.message = message;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

}
