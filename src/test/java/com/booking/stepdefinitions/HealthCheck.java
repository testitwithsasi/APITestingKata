package com.booking.stepdefinitions;

import com.booking.serviceapi.*;
import com.booking.utils.ResponseUtil;
import io.cucumber.java.en.*;
import io.restassured.response.Response;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.Objects;

import static com.booking.utils.ResponseUtil.markResponseASFalse;
import static org.junit.jupiter.api.Assertions.*;

public class HealthCheck {

    private static final Log log = LogFactory.getLog(HealthCheck.class);
    public Response response;

    @Given("send GET request to the health endpoint")
    public void sendRequest() {
        ApiService service = new ApiService();

        response = service.callAPI(
                "HEALTH",
                HttpMethod.GET,
                null,
                null);
    }

    @Then("health response status code should be {int}")
    public void verifyStatusCode_200(int expectedStatusCode) {
        assertEquals(response.getStatusCode(), expectedStatusCode, "Status Code Mismatch");
    }

    @And("response status should be {string}")
    public void verifyResponseStatus(String expectedStatus) {
        if (ResponseUtil.hasProperty(response, "status")) {
            String status = ResponseUtil.getProperty(response, "status", "NOT_FOUND");
            if (status.equalsIgnoreCase(expectedStatus))
                assertEquals(status, expectedStatus);
            else
                assertNotEquals(status, expectedStatus);
        }
    }

    @And("response body should not contain key {string}")
    public void verifyStatusKey(String key) {
        if (!ResponseUtil.hasProperty(response, key)) {
            markResponseASFalse();
        }
    }
}
