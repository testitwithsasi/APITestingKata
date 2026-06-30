@BookingSuite @DeleteBooking
Feature: Delete Booking

  @Regression
  Scenario Outline: Delete Booking with Unauthorized, missing or invalid token
    Given user provides invalid authentication token
    When user delete booking request without token "<roomid>"
    Then booking response status code should be 403

    Examples:
      | roomid |
      | 2 |
      | 3 |


  @Regression @Positive
  Scenario Outline: Delete Booking based on room Id
    Given user delete booking request "<roomid>"
    Then booking response status code should be 202

    Examples:
      | roomid |
      | 2 |
      | 3 |