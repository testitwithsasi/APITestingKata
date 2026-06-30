@BookingSuite @DeleteBooking
Feature: Delete Booking

  @Regression
  Scenario Outline: Delete Booking with Unauthorized, missing or invalid token
    Given user provides invalid authentication token
    When user delete booking request without token "<roomid>"
    Then access to booking should be denied

    Examples:
      | roomid |
      | 2 |
      | 3 |


  @Regression @Positive
  Scenario Outline: Delete Booking based on room Id
    Given user delete booking request "<roomid>"
    Then room booking should be deleted successfully

    Examples:
      | roomid |
      | 2 |
      | 3 |