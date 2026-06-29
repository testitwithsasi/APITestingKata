package com.booking.serviceapi;

import io.restassured.RestAssured;
import io.restassured.response.Response;

import java.util.Map;

public class ApiBuilder {

    private final String BASE_URL = "https://automationintesting.online/api";

    public Response executeRequest(
            HttpMethod method,
            String endpoint,
            Map<String, String> headers,
            Object body) {

        var request = RestAssured
                .given()
                .baseUri(BASE_URL);

        if (headers != null && !headers.isEmpty()) {
            request.headers(headers);
        }

        if (body != null) {
            request.body(body);
        }

        switch (method) {

            case GET:
                return request.get(endpoint);

            case POST:
                return request.post(endpoint);

            case PUT:
                return request.put(endpoint);

            case PATCH:
                return request.patch(endpoint);

            case DELETE:
                return request.delete(endpoint);

            default:
                throw new RuntimeException("Invalid Method");
        }
    }
}
