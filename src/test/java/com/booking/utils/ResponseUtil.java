package com.booking.utils;

import io.restassured.response.Response;

public class ResponseUtil {

    public static boolean hasProperty(Response response, String jsonPath) {
        return response.jsonPath().get(jsonPath) != null;
    }

    public static String getProperty(Response response, String jsonPath, String defaultValue) {
        Object value = response.jsonPath().get(jsonPath);
        return value != null ? value.toString() : defaultValue;
    }
}
