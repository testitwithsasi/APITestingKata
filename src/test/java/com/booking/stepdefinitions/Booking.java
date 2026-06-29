package com.booking.stepdefinitions;

import com.booking.models.*;
import com.booking.serviceapi.*;
import com.booking.utils.*;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.*;
import io.restassured.response.Response;

import java.util.Map;

import static com.booking.utils.ResponseUtil.markResponseASFalse;
import static org.junit.jupiter.api.Assertions.*;

public class Booking {

    BookingRequest request = new BookingRequest();
    ApiService service = new ApiService();

    @Given("user prepares booking request")
    public void prepareRoomBookingRequest(DataTable dataTable){

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
                HttpMethod.POST,
                ResponseUtil.getHeaders(),
                request));
    }

    @Then("booking response status code should be {int}")
    public void verifyBookingRespStatusCode(Integer expectedStatusCode){
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

        assertEquals(request.getFirstname(), bookingResponse.getFirstName());
        assertEquals(request.getLastName(), bookingResponse.getLastName());
        assertEquals(request.getRoomId(), bookingResponse.getRoomId());
        assertEquals(request.getDepositPaid(), bookingResponse.getDepositPaid());
        assertNotNull(bookingResponse.getBookingId());
        assertEquals(request.getBookingDates().getCheckIn(), bookingResponse.getBookingDates().getCheckIn());
        assertEquals(request.getBookingDates().getCheckOut(), bookingResponse.getBookingDates().getCheckOut());
    }
}
