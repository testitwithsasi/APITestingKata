package com.booking.utils;

import io.restassured.response.Response;

public class ScenarioContext {

    private static ThreadLocal<Response> response = new ThreadLocal<>();
    private static ThreadLocal<String> token = new ThreadLocal<>();

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

    public static void clear() {
        response.remove();
        token.remove();
    }
}
