package com.c2.g4.enums;


public enum OrderStatusEnum implements CodeEnum {
    NEW(0, "New OrderMain"),
    FINISHED(1, "Finished"),
    CANCELLED(2, "CancelLed")
    ;

    private  int code;
    private String msg;

    OrderStatusEnum(Integer code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    @Override
    public Integer getCode() {
        return code;
    }
}
