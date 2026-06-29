package com.booking.stepdefinitions;

import com.booking.models.LoginRequest;
import com.booking.serviceapi.ApiService;
import com.booking.serviceapi.HttpMethod;
import com.booking.utils.ResponseUtil;
import com.booking.utils.ScenarioContext;
import groovy.util.logging.Slf4j;
import io.cucumber.java.en.*;
import io.restassured.response.Response;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.HashMap;
import java.util.Map;

import static com.booking.utils.ResponseUtil.markResponseASFalse;
import static org.junit.jupiter.api.Assertions.*;

@Slf4j
public class Authentication {

    private static final Log log = LogFactory.getLog(Authentication.class);
    private LoginRequest request;
    ApiService service = new ApiService();

    @Given("user enters username {string}")
    public void setUserUsername(String username) {
        if (request == null) request = new LoginRequest();
        request.setUsername(username);
    }

    @And("user enters password {string}")
    public void setUserPassword(String password) {
        if (request == null) request = new LoginRequest();
        request.setPassword(password);
    }

    @When("user sends login request")
    public void sendLoginRequest() {

        Map<String, String> headers = new HashMap<>();
        headers.put("Content-Type", "application/json");
        headers.put("Accept", "application/json");

        ScenarioContext.setResponse(service.callAPI(
                "AUTH",
                HttpMethod.POST,
                headers,
                request));
    }

    @Then("response status code should be {int}")
    public void verifyLoginRespStatusCode(int statusCode) {
        Response response = ScenarioContext.getResponse();
        if (ResponseUtil.isResponseNull(response)) {
            assertEquals(response.getStatusCode(), statusCode, "Status Code Mismatch");
        } else {
            markResponseASFalse();
        }
    }

    @And("authentication token should be generated")
    public void verifyAndGetAuthToken() {
        Response response = ScenarioContext.getResponse();
        if (ResponseUtil.isResponseNull(response)) {
            if (ResponseUtil.hasProperty(response, "token")) {
                String token = ResponseUtil.getProperty(response, "token", "NOT_FOUND");
                assertNotNull(token);

                ScenarioContext.setToken(token);
            }
        } else {
            markResponseASFalse();
        }
    }

    @And("authentication token should not be empty")
    public void validateAuthToken() {
        Response response = ScenarioContext.getResponse();
        if (ResponseUtil.isResponseNull(response)) {
            if (ResponseUtil.hasProperty(response, "token")) {
                String token = ResponseUtil.getProperty(response, "token", "NOT_FOUND");
                assertFalse(token.isEmpty());
            }
        } else {
            markResponseASFalse();
        }
    }

    @And("response should contain error {string}")
    public void validateErrorResponse(String expectedError) {
        Response response = ScenarioContext.getResponse();
        if (ResponseUtil.isResponseNull(response)) {
            if (ResponseUtil.hasProperty(response, "error")) {
                String error = ResponseUtil.getProperty(response, "error", "NOT_FOUND");

                assertNotNull(error);
                assertFalse(error.isEmpty());
                assertEquals(expectedError, error);
            }
        } else {
            markResponseASFalse();
        }
    }
}
