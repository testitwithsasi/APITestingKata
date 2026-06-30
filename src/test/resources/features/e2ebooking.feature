@BookingSuite @E2E
Feature: Booking End-to-End Flow

  @Regression @Positive
  Scenario Outline: Verify complete booking lifecycle like Create, Retrieve, Update and Delete Booking successfully

    # Create Booking
    Given the user provides the booking information
      | roomid      | 1 |
      | firstname   | John |
      | lastname    | Smith |
      | depositpaid | true |
      | checkin     | 2026-07-01 |
      | checkout    | 2026-07-05 |
      | email       | john.smith@test.com |
      | phone       | 09123456789 |
    When user sends a request
    Then room booking should be created successfully
    And booking response should contain a booking id
    And user stores the booking id

    # Retrieve Created Booking
    When the user retrieves the booking
    Then the booking should be retrieved successfully
    And booking response should contain all mandatory fields

    # Update Booking
    Given the user provides the booking information
      | roomid      | 1 |
      | firstname   | Jane |
      | lastname    | Doe |
      | depositpaid | false |
      | checkin     | 2026-07-10 |
      | checkout    | 2026-07-15 |
      | email       | jane.doe@test.com |
      | phone       | 09876543210 |
    When the user requests to update the booking
    Then the booking should be updated successfully

    # Verify Updated Booking
    When the user retrieves the booking
    Then the booking should be retrieved successfully
    And booking response should contain all mandatory fields

    # Delete Booking
    When user delete booking request "<roomid>"
    Then room booking should be deleted successfully

    # Verify Booking Deleted
    When the user retrieves the booking
    Then the booking should not be found

    Examples:
      | roomid |
      | 1 |