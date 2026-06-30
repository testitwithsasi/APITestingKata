Feature: Booking End-to-End Flow

  @E2E @Regression
  Scenario Outline: Verify complete booking lifecycle like Create, Retrieve, Update and Delete Booking successfully

    # Create Booking
    Given user prepares booking request
      | roomid      | 1 |
      | firstname   | John |
      | lastname    | Smith |
      | depositpaid | true |
      | checkin     | 2026-07-01 |
      | checkout    | 2026-07-05 |
      | email       | john.smith@test.com |
      | phone       | 09123456789 |
    When user send a POST request
    Then booking response status code should be 201
    And booking response should contain a booking id
    And user stores the booking id

    # Retrieve Created Booking
    When user sends a GET booking request
    Then booking response status code should be 200
    And booking response should contain all mandatory fields

    # Update Booking
    Given user prepares booking request
      | roomid      | 1 |
      | firstname   | Jane |
      | lastname    | Doe |
      | depositpaid | false |
      | checkin     | 2026-07-10 |
      | checkout    | 2026-07-15 |
      | email       | jane.doe@test.com |
      | phone       | 09876543210 |
    When user sends a PUT booking request
    Then booking response status code should be 200

    # Verify Updated Booking
    When user sends a GET booking request
    Then booking response status code should be 200
    And booking response should contain all mandatory fields

    # Delete Booking
    When user delete booking request "<roomid>"
    Then booking response status code should be 202

    # Verify Booking Deleted
    When user sends a GET booking request
    Then booking response status code should be 404

    Examples:
      | roomid |
      | 1 |