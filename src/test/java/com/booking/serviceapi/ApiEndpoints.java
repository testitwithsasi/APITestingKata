package com.booking.serviceapi;

public class ApiEndpoints {

    public static String getEndpoint(String apiName) {

        switch (apiName.toUpperCase()) {

            case "HEALTH":
                return "/booking/actuator/health";

            case "AUTH":
                return "/auth/login";

            case "BOOKING":
                return "/booking";

            default:
                throw new RuntimeException("API not found : " + apiName);
        }
    }
}
