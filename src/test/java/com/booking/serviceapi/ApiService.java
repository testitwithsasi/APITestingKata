package com.booking.serviceapi;

import io.restassured.response.Response;

import java.util.Map;

public class ApiService {

    ApiBuilder builder = new ApiBuilder();

    public Response callAPI(String apiName,
                            String extraParam,
                            HttpMethod method,
                            Map<String, String> headers,
                            Object body) {

        String endpoint = ApiEndpoints.getEndpoint(apiName);

        if (extraParam != null && !extraParam.isBlank()) {
            endpoint += "/" + Integer.parseInt(extraParam);
        }


        return builder.executeRequest(
                method,
                endpoint,
                headers,
                body);
    }
}
