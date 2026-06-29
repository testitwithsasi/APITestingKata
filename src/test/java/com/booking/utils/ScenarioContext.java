package com.booking.utils;

import io.restassured.response.Response;

import java.util.HashMap;
import java.util.Map;

public class ScenarioContext {

    private static   ThreadLocal<Response> response = new ThreadLocal<>();
    private static   ThreadLocal<String> token = new ThreadLocal<>();
    private static Map<String, String> bookingIds = new HashMap<>();

    public static void setResponse(Response res) {
        response.set(res);
    }

    public static Response getResponse() {
        return response.get();
    }

    public static void setToken(String t) {
        token.set(t);
    }

    public static String getToken() {
        return token.get();
    }

    public static String getBookingIds(String key) {
        return bookingIds.get(key);
    }

    public static void setBookingIds(String key,String value) {
        bookingIds.put(key, value);
    }

    public static void clear() {
        response.remove();
        token.remove();
    }
}
