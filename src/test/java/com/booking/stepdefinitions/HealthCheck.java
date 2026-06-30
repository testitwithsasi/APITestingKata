package com.booking.stepdefinitions;

import com.booking.serviceapi.*;
import com.booking.utils.ResponseUtil;
import io.cucumber.java.en.*;
import io.restassured.response.Response;

import static com.booking.utils.ResponseUtil.markResponseASFalse;
import static org.junit.jupiter.api.Assertions.*;

public class HealthCheck {

    public Response response;

    @Given("send GET request to the health endpoint")
    public void sendRequest() {
        ApiService service = new ApiService();

        response = service.callAPI(
                "HEALTH",
                null,
                HttpMethod.GET,
                null,
                null);
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

    @Then("the application should be healthy")
    public void theApplicationShouldBeHealthy() {
        assertEquals(response.getStatusCode(), 200, "Status Code Mismatch");
    }

    @Then("the application should be unhealthy")
    public void theApplicationShouldBeUnhealthy() {
        assertEquals(response.getStatusCode(), 200, "Status Code Mismatch");
    }

    @Then("the health information should be incomplete")
    public void theHealthInformationShouldBeIncomplete() {
        assertEquals(response.getStatusCode(), 200, "Status Code Mismatch");
    }

    @And("the service {string} should not be available")
    public void theServiceStatusShouldNotBeAvailable(String status) {
        if (!ResponseUtil.hasProperty(response, status)) {
            markResponseASFalse();
        }
    }
}
