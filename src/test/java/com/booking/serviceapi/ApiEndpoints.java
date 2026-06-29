package com.booking.serviceapi;

public class ApiEndpoints {

    public static String getEndpoint(String apiName) {

        switch (apiName.toUpperCase()) {

            case "HEALTH":
                return "/booking/actuator/health";

            default:
                throw new RuntimeException("API not found : " + apiName);
        }
    }
}
