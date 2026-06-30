package com.booking.stepdefinitions;

import com.booking.models.BookingRequest;
import com.booking.models.LoginRequest;
import com.booking.serviceapi.ApiService;
import com.booking.serviceapi.HttpMethod;
import com.booking.utils.ResponseUtil;
import com.booking.utils.ScenarioContext;
import groovy.util.logging.Slf4j;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.*;
import io.restassured.response.Response;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import javax.xml.crypto.Data;
import java.util.Map;

import static com.booking.utils.ResponseUtil.markResponseASFalse;
import static org.junit.jupiter.api.Assertions.*;

@Slf4j
public class Authentication {

    private static final Log log = LogFactory.getLog(Authentication.class);
    private LoginRequest request = new LoginRequest("admin", "password");
    ApiService service = new ApiService();

    @When("user sends login request")
    public void sendLoginRequest() {

        ScenarioContext.setResponse(service.callAPI(
                "AUTH",
                null,
                HttpMethod.POST,
                ResponseUtil.getHeaders(),
                request));
    }

    @Then("the user should be logged in successfully")
    public void userShouldBeLoggedInSuccessfully() {
        Response response = ScenarioContext.getResponse();
        if (ResponseUtil.isResponseNull(response)) {
            assertEquals(response.getStatusCode(), 200, "Status Code Mismatch");
        } else {
            markResponseASFalse();
        }
    }

    @And("the user should be granted access to the booking system")
    public void verifyAndGetAuthToken() {
        Response response = ScenarioContext.getResponse();
        if (ResponseUtil.isResponseNull(response)) {
            if (ResponseUtil.hasProperty(response, "token")) {
                String token = ResponseUtil.getProperty(response, "token", "NOT_FOUND");
                assertNotNull(token);

                ScenarioContext.getToken();
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

    @Given("the user provides the following credentials")
    public void userInvalidCredentials(DataTable dataTable){
        Map<String, String> data = dataTable.asMap(String.class, String.class);

        request = new LoginRequest();
        request.setUsername(data.get("username"));
        request.setPassword(data.get("password"));

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

    @Then("login should fail")
    public void loginShouldFail() {
        Response response = ScenarioContext.getResponse();
        if (ResponseUtil.isResponseNull(response)) {
            assertEquals(response.getStatusCode(), 401, "Status Code Mismatch");
        } else {
            markResponseASFalse();
        }
    }



}
