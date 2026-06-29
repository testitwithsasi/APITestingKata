package com.booking.config;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.PropertyNamingStrategies;

public class ObjectMapperConfig {

    private static ObjectMapper objectMapper;

    private ObjectMapperConfig() {
    }

    public static ObjectMapper getObjectMapper() {

        if (objectMapper == null) {

            objectMapper = new ObjectMapper();

            // 🚀 Ignore unknown JSON fields (prevents your current error)
            objectMapper.configure(
                    DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES,
                    false
            );

            // Optional: consistent naming strategy
            objectMapper.setPropertyNamingStrategy(
                    PropertyNamingStrategies.LOWER_CAMEL_CASE
            );

            // Optional: fail-safe null handling
            objectMapper.configure(
                    DeserializationFeature.FAIL_ON_NULL_FOR_PRIMITIVES,
                    false
            );
        }

        return objectMapper;
    }
}
