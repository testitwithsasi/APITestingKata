package com.booking.stepdefinitions;

import com.booking.serviceapi.*;
import com.booking.utils.ResponseUtil;
import io.cucumber.java.en.*;
import io.restassured.response.Response;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class HealthCheckTest {

    private static final Log log = LogFactory.getLog(HealthCheckTest.class);
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

    @Then("the response status code should be {int}")
    public void verifyStatusCode_200(int expectedStatusCode){
        assertEquals(response.getStatusCode(), expectedStatusCode, "Status Code Mismatch");
    }

    @And("the response body should contain status {string}")
    public void verifyStatusFromResponse(String expectedStatus){
        if (ResponseUtil.hasProperty(response, "status")) {
            String status = ResponseUtil.getProperty(response, "status", "NOT_FOUND");
            System.out.println(status);
            assertEquals(status, expectedStatus);
        }
    }
}
