package com.booking.utils;

import com.booking.config.ObjectMapperConfig;
import com.fasterxml.jackson.core.JsonProcessingException;

public class JsonUtil {

    public static String toJson(Object obj) {
        try {
            return ObjectMapperConfig.getObjectMapper()
                    .writeValueAsString(obj);
        } catch (JsonProcessingException e) {
            throw new RuntimeException("Error converting object to JSON", e);
        }
    }

    public static <T> T fromJson(String json, Class<T> clazz) {
        try {
            return ObjectMapperConfig.getObjectMapper()
                    .readValue(json, clazz);
        } catch (Exception e) {
            throw new RuntimeException("Error converting JSON to object", e);
        }
    }
}
