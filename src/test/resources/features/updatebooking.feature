@BookingSuite @UpdateBooking
Feature: Update Booking

  @Regression
  Scenario Outline: Update booking with valid payload combinations
    Given the user provides the booking information
      | roomid      | <roomid>      |
      | firstname   | <firstname>   |
      | lastname    | <lastname>    |
      | depositpaid | <depositpaid> |
      | checkin     | <checkin>     |
      | checkout    | <checkout>    |
      | email       | <email>       |
      | phone       | <phone>       |
    When the user requests to update the booking
    Then the booking should be updated successfully

    Examples:
      | roomid | firstname | lastname | depositpaid | checkin   | checkout  | email                    | phone       |
      | 2 | John | Smith | true | 2026-10-13 | 2026-10-15 | john@example.com | 09234567890 |
      | 3 | John | Doe | true | 2026-10-13 | 2026-10-15 | john@example.com | 08234567890 |

  @Regression
  Scenario Outline: Update booking with invalid payload combinations
    Given the user provides the booking information
      | roomid      | <roomid>      |
      | firstname   | <firstname>   |
      | lastname    | <lastname>    |
      | depositpaid | <depositpaid> |
      | checkin     | <checkin>     |
      | checkout    | <checkout>    |
      | email       | <email>       |
      | phone       | <phone>       |
    When the user requests to update the booking
    Then the booking update should be rejected

    Examples:
      | roomid | firstname | lastname | depositpaid | checkin   | checkout  | email                    | phone       | statusCode | Test Case |
      | 2 | "" | Doe | true | 2026-10-13 | 2026-10-15 | john@example.com | 1234567890 | 400 | Empty firstname |
      | 2 | John | "" | true | 2026-10-13 | 2026-10-15 | john@example.com | 1234567890 | 400 | Empty lastname |
      | 2 | John | Doe | invalid | 2026-10-13 | 2026-10-15 | john@example.com | 1234567890 | 400 | Invalid boolean |
      | 2 | John | Doe | true | 2026-10-15 | 2026-10-13 | john@example.com | 1234567890 | 400 | Checkout before checkin |
      | 2 | John | Doe | true | invalid-date | 2026-10-15 | john@example.com | 1234567890 | 400 | Invalid checkin date |
      | 2 | John | Doe | true | 2026-10-13 | invalid-date | john@example.com | 1234567890 | 400 | Invalid checkout date |
      | 2 | John | Doe | true | "" | 2026-10-15 | john@example.com | 1234567890 | 400 | Empty checkin |
      | 2 | John | Doe | true | 2026-10-13 | "" | john@example.com | 1234567890 | 400 | Empty checkout |
      | 2 | John | Doe | true | 2026-10-13 | 2026-10-15 | invalid-email | 1234567890 | 400 | Invalid email |
      | 2 | John | Doe | true | 2026-10-13 | 2026-10-15 | "" | 1234567890 | 400 | Empty email |
      | 2 | John | Doe | true | 2026-10-13 | 2026-10-15 | john@example.com | "" | 400 | Empty phone |
      | 2 | John | Doe | true | 2026-10-13 | 2026-10-15 | john@example.com | abcdef | 400 | Alphabetic phone |
      | 2 | John | Doe | true | 2026-10-13 | 2026-10-15 | john@example.com | 12345 | 400 | Short phone number |
      | 2 | null | Doe | true | 2026-10-13 | 2026-10-15 | john@example.com | 1234567890 | 400 | Null firstname |
      | 2 | John | null | true | 2026-10-13 | 2026-10-15 | john@example.com | 1234567890 | 400 | Null lastname |
      | 2 | John | Doe | null | 2026-10-13 | 2026-10-15 | john@example.com | 1234567890 | 400 | Null deposit paid |
      | 2 | John | Doe | true | null | 2026-10-15 | john@example.com | 1234567890 | 400 | Null checkin |
      | 2 | John | Doe | true | 2026-10-13 | null | john@example.com | 1234567890 | 400 | Null checkout |
      | 2 | John | Doe | true | 2026-10-13 | 2026-10-15 | null | 1234567890 | 400 | Null email |
      | 2 | John | Doe | true | 2026-10-13 | 2026-10-15 | john@example.com | null | 400 | Null phone |