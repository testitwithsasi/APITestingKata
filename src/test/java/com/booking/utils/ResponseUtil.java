package com.booking.utils;

import io.restassured.response.Response;

import static org.junit.jupiter.api.Assertions.assertFalse;

public class ResponseUtil {

    public static boolean hasProperty(Response response, String jsonPath) {
        return response.jsonPath().get(jsonPath) != null;
    }

    public static String getProperty(Response response, String jsonPath, String defaultValue) {
        Object value = response.jsonPath().get(jsonPath);
        return value != null ? value.toString() : defaultValue;
    }

    public  static  boolean isResponseNull(Response response){
        return response != null ? true : false;
    }

    public static void markResponseASFalse(){
        assertFalse(false);
    }
}
