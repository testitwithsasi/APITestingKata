@BookingSuite @UpdateBooking
Feature: Update Booking

  @Regression
  Scenario Outline: Update booking with valid payload combinations
    Given user provides booking id "<bookingId>"
    And user prepares booking request
      | roomid      | <roomid>      |
      | firstname   | <firstname>   |
      | lastname    | <lastname>    |
      | depositpaid | <depositpaid> |
      | checkin     | <checkin>     |
      | checkout    | <checkout>    |
      | email       | <email>       |
      | phone       | <phone>       |
    When user sends a PUT booking request
    Then the booking should be updated successfully

    Examples:
      | bookingId | roomid | firstname | lastname | depositpaid | checkin   | checkout  | email                    | phone       |
      | 2 | 2 | John | Smith | true | 2026-10-13 | 2026-10-15 | john@example.com | 09234567890 |
      | 3 | 3 | John | Doe | true | 2026-10-13 | 2026-10-15 | john@example.com | 08234567890 |

  @Regression
  Scenario Outline: Update booking with invalid payload combinations
    Given user provides booking id "<bookingId>"
    And user prepares booking request
      | roomid      | <roomid>      |
      | firstname   | <firstname>   |
      | lastname    | <lastname>    |
      | depositpaid | <depositpaid> |
      | checkin     | <checkin>     |
      | checkout    | <checkout>    |
      | email       | <email>       |
      | phone       | <phone>       |
    When user sends a PUT booking request
    Then the booking update should be rejected

    Examples:
      | bookingId | roomid | firstname | lastname | depositpaid | checkin   | checkout  | email                    | phone       | statusCode | Test Case |
      | 1 | 2 | "" | Doe | true | 2026-10-13 | 2026-10-15 | john@example.com | 1234567890 | 400 | Empty firstname |
      | 1 | 2 | John | "" | true | 2026-10-13 | 2026-10-15 | john@example.com | 1234567890 | 400 | Empty lastname |
      | 1 | 2 | John | Doe | invalid | 2026-10-13 | 2026-10-15 | john@example.com | 1234567890 | 400 | Invalid boolean |
      | 1 | 2 | John | Doe | true | 2026-10-15 | 2026-10-13 | john@example.com | 1234567890 | 400 | Checkout before checkin |
      | 1 | 2 | John | Doe | true | invalid-date | 2026-10-15 | john@example.com | 1234567890 | 400 | Invalid checkin date |
      | 1 | 2 | John | Doe | true | 2026-10-13 | invalid-date | john@example.com | 1234567890 | 400 | Invalid checkout date |
      | 1 | 2 | John | Doe | true | "" | 2026-10-15 | john@example.com | 1234567890 | 400 | Empty checkin |
      | 1 | 2 | John | Doe | true | 2026-10-13 | "" | john@example.com | 1234567890 | 400 | Empty checkout |
      | 1 | 2 | John | Doe | true | 2026-10-13 | 2026-10-15 | invalid-email | 1234567890 | 400 | Invalid email |
      | 1 | 2 | John | Doe | true | 2026-10-13 | 2026-10-15 | "" | 1234567890 | 400 | Empty email |
      | 1 | 2 | John | Doe | true | 2026-10-13 | 2026-10-15 | john@example.com | "" | 400 | Empty phone |
      | 1 | 2 | John | Doe | true | 2026-10-13 | 2026-10-15 | john@example.com | abcdef | 400 | Alphabetic phone |
      | 1 | 2 | John | Doe | true | 2026-10-13 | 2026-10-15 | john@example.com | 12345 | 400 | Short phone number |
      | 1 | 2 | null | Doe | true | 2026-10-13 | 2026-10-15 | john@example.com | 1234567890 | 400 | Null firstname |
      | 1 | 2 | John | null | true | 2026-10-13 | 2026-10-15 | john@example.com | 1234567890 | 400 | Null lastname |
      | 1 | 2 | John | Doe | null | 2026-10-13 | 2026-10-15 | john@example.com | 1234567890 | 400 | Null deposit paid |
      | 1 | 2 | John | Doe | true | null | 2026-10-15 | john@example.com | 1234567890 | 400 | Null checkin |
      | 1 | 2 | John | Doe | true | 2026-10-13 | null | john@example.com | 1234567890 | 400 | Null checkout |
      | 1 | 2 | John | Doe | true | 2026-10-13 | 2026-10-15 | null | 1234567890 | 400 | Null email |
      | 1 | 2 | John | Doe | true | 2026-10-13 | 2026-10-15 | john@example.com | null | 400 | Null phone |