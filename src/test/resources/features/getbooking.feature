@BookingSuite @GetBooking
Feature: Get Booking

  @Regression @Positive
  Scenario Outline: Retrieve booking with valid booking id
    Given user provides booking id "<bookingId>"
    When the user retrieves the booking
    Then the booking should be retrieved successfully
    And booking response should contain booking id "<bookingId>"
    And booking response should contain all mandatory fields

    Examples:
      | bookingId |
      | 2 |
      | 3 |

  @Regression @Negative
  Scenario Outline: Retrieve booking with invalid authentication token
    Given user provides booking id "<bookingId>"
    And user provides invalid authentication token
    When user requests a booking without token
    Then access to booking should be denied

    Examples:
      | bookingId |
      | 2 |
      | 3 |

  @Regression @Negative
  Scenario Outline: Retrieve booking without authentication token
    Given user provides booking id "<bookingId>"
    When user requests a booking without token
    Then access to booking should be denied

    Examples:
      | bookingId |
      | 2 |
      | 3 |