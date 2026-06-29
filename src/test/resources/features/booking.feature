@Booking
Feature: Booking API

  @Smoke @Regression @Positive
  Scenario Outline: Create booking with valid payload
    Given user prepares booking request
      | roomid        | <roomid>        |
      | firstname     | <firstname>     |
      | lastname      | <lastname>      |
      | depositpaid   | <depositpaid>   |
      | checkin       | <checkin>       |
      | checkout      | <checkout>      |
      | email         | <email>         |
      | phone         | <phone>         |

    Then user send a POST request
    Then booking response status code should be 201
    And booking response should contain a booking id
    And booking response should match the request payload

    Examples:
      | roomid | firstname | lastname   | depositpaid | checkin     | checkout    | email                     | phone        |
      | 1      | Sarah     | Ali        | true        | 2026-07-01  | 2026-07-12  | sarah.ali@google.com      | 09234567890   |
      | 2      | Abraham   | David      | true        | 2026-07-25  | 2026-07-30  | abraham.david@mail.com    | 09876543210   |
      | 3      | Elsa      | Kokelberg  | false       | 2026-12-10  | 2026-12-12  | elsa.kokelberg@mail.com   | 09988776655   |
