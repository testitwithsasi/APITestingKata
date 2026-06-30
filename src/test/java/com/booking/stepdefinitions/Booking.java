package com.booking.stepdefinitions;

import com.booking.models.*;
import com.booking.serviceapi.*;
import com.booking.utils.*;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.*;
import io.restassured.response.Response;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;
import java.util.Map;

import static com.booking.utils.ResponseUtil.*;
import static org.junit.jupiter.api.Assertions.*;

public class Booking {

    private static final Logger log = LoggerFactory.getLogger(Booking.class);
    BookingRequest request = new BookingRequest();
    ApiService service = new ApiService();
    private String bookingId;


    @Given("user prepares booking request")
    public void prepareRoomBookingRequest(DataTable dataTable) {

        Map<String, String> data = dataTable.asMap(String.class, String.class);

        BookingDates bookingDates = new BookingDates();
        bookingDates.setCheckIn(data.get("checkin"));
        bookingDates.setCheckOut(data.get("checkout"));

        request = new BookingRequest();
        request.setBookingDates(bookingDates);
        request.setRoomId(Integer.parseInt(data.get("roomid")));
        request.setFirstname(data.get("firstname"));
        request.setLastName(data.get("lastname"));
        request.setDepositPaid(Boolean.parseBoolean(data.get("depositpaid")));
        request.setEmail(data.get("email"));
        request.setPhoneNumber(data.get("phone"));
    }

    @When("user send a POST request")
    public void sendBookingRequest() {

        ScenarioContext.setResponse(service.callAPI(
                "BOOKING",
                null,
                HttpMethod.POST,
                ResponseUtil.getHeaders(),
                request));
    }

    @Then("booking response status code should be {int}")
    public void verifyBookingRespStatusCode(Integer expectedStatusCode) {
        Response response = ScenarioContext.getResponse();
        assertNotNull(response, "Response is NULL");
        assertEquals(expectedStatusCode, response.getStatusCode(), "Status Code Mismatch");
    }

    @Then("booking response should contain a booking id")
    public void verifyBookingId() {
        Response response = ScenarioContext.getResponse();
        if (ResponseUtil.isResponseNull(response)) {
            assertNotNull(response.jsonPath().get("bookingid"));
        } else {
            markResponseASFalse();
        }
    }

    @Then("booking response should match the request payload")
    public void verifyResponsePayload() {

        Response response = ScenarioContext.getResponse();

        BookingResponse bookingResponse = JsonUtil.fromJson(response.asString(), BookingResponse.class);

        ScenarioContext.setBookingIds(String.valueOf(bookingResponse.getRoomId()), String.valueOf(bookingResponse.getBookingId()));

        assertEquals(request.getFirstname(), bookingResponse.getFirstName());
        assertEquals(request.getLastName(), bookingResponse.getLastName());
        assertEquals(request.getRoomId(), bookingResponse.getRoomId());
        assertEquals(request.getDepositPaid(), bookingResponse.getDepositPaid());
        assertNotNull(bookingResponse.getBookingId());
        assertEquals(request.getBookingDates().getCheckIn(), bookingResponse.getBookingDates().getCheckIn());
        assertEquals(request.getBookingDates().getCheckOut(), bookingResponse.getBookingDates().getCheckOut());
    }

    @Then("booking response should contain validation error {string}")
    public void checkResponseErrors(String expectedError) {

        Response response = ScenarioContext.getResponse();

        if (ResponseUtil.isResponseNull(response)) {
            if (ResponseUtil.hasProperty(response, "errors")) {
                List<String> errors = response.jsonPath().getList("errors");
                assertNotNull(errors, "Errors array is missing");
                assertTrue(errors.contains(expectedError), "Expected error: " + expectedError + "\nActual errors: " + errors);
            }
        } else {
            markResponseASFalse();
        }
    }

    @Given("user provides booking id {string}")
    public void userProvidesBookingId(String bookingId) {
        this.bookingId = bookingId;
    }

    @When("user sends a GET booking request")
    public void getBookingDetailsById() {

        var headers = getHeaders();
        headers.put("Cookie", "token=" + ScenarioContext.getToken());

        ScenarioContext.setResponse(service.callAPI(
                "BOOKING"
                , bookingId,
                HttpMethod.GET,
                headers,
                null));
    }

    @And("booking response should contain booking id {string}")
    public void verifyBookingResponseByBookingId(String bookingId) {

        Response response = ScenarioContext.getResponse();

        if(isResponseNull(response) && ResponseUtil.hasProperty(response, "bookingid")){
            assertEquals(Integer.parseInt(bookingId), response.jsonPath().getInt("bookingid"));
        }
    }

    @And("booking response should contain all mandatory fields")
    public void validateAllResponseFields() {

        Response response = ScenarioContext.getResponse();
        BookingResponse bookingResponse = JsonUtil.fromJson(response.asString(), BookingResponse.class);

        ScenarioContext.setBookingIds(String.valueOf(bookingResponse.getRoomId()), String.valueOf(bookingResponse.getBookingId()));

        assertNotNull(response.jsonPath().get("bookingid"));
        assertNotNull(response.jsonPath().get("roomid"));
        assertNotNull(response.jsonPath().get("firstname"));
        assertNotNull(response.jsonPath().get("lastname"));
        assertNotNull(response.jsonPath().get("depositpaid"));
        assertNotNull(response.jsonPath().get("bookingdates.checkin"));
        assertNotNull(response.jsonPath().get("bookingdates.checkout"));
    }

    @And("user provides invalid authentication token")
    public void userProvidesInvalidAuthenticationToken() {
        ScenarioContext.clear();
    }

    @And("booking response should have valid data types")
    public void validateResponseDataTypes() {

        Response response = ScenarioContext.getResponse();

        assertTrue(response.jsonPath().get("bookingid") instanceof Integer);
        assertTrue(response.jsonPath().get("roomid") instanceof Integer);
        assertTrue(response.jsonPath().get("firstname") instanceof String);
        assertTrue(response.jsonPath().get("lastname") instanceof String);
        assertTrue(response.jsonPath().get("depositpaid") instanceof Boolean);
        assertTrue(response.jsonPath().get("bookingdates.checkin") instanceof String);
        assertTrue(response.jsonPath().get("bookingdates.checkout") instanceof String);
    }

    @And("response content type should be {string}")
    public void verifyResponseContent(String contentType) {

        Response response = ScenarioContext.getResponse();

        assertTrue(response.getContentType().contains(contentType));
    }

    @When("user sends a GET booking request without token")
    public void getBookingDetailsByIdWithoutToken() {

        Response response = service.callAPI(
                "BOOKING",
                bookingId,
                HttpMethod.GET,
                null,
                null);

        ScenarioContext.setResponse(response);
    }

    @When("user sends a PUT booking request")
    public void updateBookingRequest() {

        var headers = getHeaders();
        headers.remove("Cookie");
        headers.put("Cookie", "token=" + ScenarioContext.getToken());

        String roomID = String.valueOf(request.getRoomId());

        request.setBookingId(Integer.valueOf(ScenarioContext.getBookingIds(roomID)).intValue());
        ScenarioContext.setResponse(service.callAPI(
                "BOOKING",
                String.valueOf(request.getBookingId()),
                HttpMethod.PUT,
                headers,
                request));
    }

    @Given("user prepares partial booking request")
    public void preparePartialRequest(DataTable table){

        Map<String, String> data = table.asMap(String.class, String.class);

        request = new BookingRequest();
        request.setRoomId(Integer.parseInt(data.get("roomid")));
        request.setFirstname(data.get("firstname"));
        request.setLastName(data.get("lastname"));
        request.setDepositPaid(Boolean.parseBoolean(data.get("depositpaid")));
    }

    @When("user sends a partial update request")
    public void sendPartialRequest(){

        var headers = getHeaders();
        headers.remove("Cookie");
        headers.put("Cookie", "token=" + ScenarioContext.getToken());

        String roomID = String.valueOf(request.getRoomId());

        ScenarioContext.setResponse(service.callAPI(
                "BOOKING",
                ScenarioContext.getBookingIds(roomID),
                HttpMethod.PATCH,
                headers,
                request));
    }

    @Given("user delete booking request {string}")
    public void userProvidesRoomId(String roomId) {

        var headers = getHeaders();
        headers.remove("Cookie");
        headers.put("Cookie", "token=" + ScenarioContext.getToken());

        ScenarioContext.setResponse(service.callAPI(
                "BOOKING",
                ScenarioContext.getBookingIds(roomId),
                HttpMethod.DELETE,
                headers,
                null));

    }

    @When("user delete booking request without token {string}")
    public void deleteBookingRequestWithoutToken(String roomId) {
        var headers = getHeaders();
        headers.remove("Cookie");

        ScenarioContext.setResponse(service.callAPI(
                "BOOKING",
                ScenarioContext.getBookingIds(roomId),
                HttpMethod.DELETE,
                headers,
                null));
    }

    @And("user stores the booking id")
    public void usrStoreBookingId() {

        Response response = ScenarioContext.getResponse();

        BookingResponse bookingResponse = JsonUtil.fromJson(response.asString(), BookingResponse.class);

        userProvidesBookingId(String.valueOf(bookingResponse.getBookingId()));

        ScenarioContext.setBookingIds(String.valueOf(bookingResponse.getRoomId()), String.valueOf(bookingResponse.getBookingId()));
    }
}
