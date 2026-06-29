package com.booking.hooks;

import com.booking.utils.ScenarioContext;
import groovy.util.logging.Slf4j;
import io.cucumber.java.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Slf4j
public class Hooks {

    private static final Logger log = LoggerFactory.getLogger(Hooks.class);

    @After
    public void tearDown() {
        ScenarioContext.clear();
        log.info("Cleared Authentication Token");
    }
}
