package com.booking.serviceapi;

import io.restassured.response.Response;

import java.util.Map;

public class ApiService {

    ApiBuilder builder = new ApiBuilder();

    public Response callAPI(String apiName,
                            HttpMethod method,
                            Map<String, String> headers,
                            Object body) {

        String endpoint = ApiEndpoints.getEndpoint(apiName);

        return builder.executeRequest(
                method,
                endpoint,
                headers,
                body);
    }
}
