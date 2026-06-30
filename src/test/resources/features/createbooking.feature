@BookingSuite @CreateBooking
Feature: Booking API

  @Smoke @Regression @Positive
  Scenario Outline: Create booking with valid payload like future, long stay
    Given user prepares booking request
      | roomid        | <roomid>        |
      | firstname     | <firstname>     |
      | lastname      | <lastname>      |
      | depositpaid   | <depositpaid>   |
      | checkin       | <checkin>       |
      | checkout      | <checkout>      |
      | email         | <email>         |
      | phone         | <phone>         |

    When user send a POST request
    Then booking response status code should be 201
    And booking response should contain a booking id
    And booking response should match the request payload

    Examples:
      | roomid | firstname | lastname   | depositpaid | checkin     | checkout    | email                     | phone        |
      | 2      | Abraham   | David      | true        | 2026-07-25  | 2026-07-30  | abraham.david@mail.com    | 09876543210   |
      | 3      | Elsa      | Kokelberg  | false       | 2026-12-10  | 2026-12-12  | elsa.kokelberg@mail.com   | 09988776655   |

  @Negative
  Scenario Outline: Create booking with invalid payload
    Given user prepares booking request
      | roomid        | <roomid>      |
      | firstname     | <firstname>   |
      | lastname      | <lastname>    |
      | depositpaid   | <depositpaid> |
      | checkin       | <checkin>     |
      | checkout      | <checkout>    |
      | email         | <email>       |
      | phone         | <phone>       |

    When user send a POST request
    Then booking response status code should be 400
    And booking response should contain validation error "<error>"

    Examples:
      | roomid | firstname            | lastname             | depositpaid | checkin    | checkout   | email                  | phone                | error                                  |
      | 2      | Jo                   | Smith                | true        | 2026-07-01 | 2026-07-05 | john@test.com          | 09123456789          | size must be between 3 and 18          |
      | 2      | firstnamefirstnamefirstnamefirstname  | Smith                | true        | 2026-07-01 | 2026-07-05 | john@test.com          | 09123456789          | size must be between 3 and 18          |
      | 2      | John                 | Do                   | true        | 2026-07-01 | 2026-07-05 | john@test.com          | 09123456789          | size must be between 3 and 30          |
      | 2      | John                 | lastnamelastnamelastnamelastname  | true        | 2026-07-01 | 2026-07-05 | john@test.com          | 09123456789          | size must be between 3 and 30          |
      | 2      | John                 | Smith                | true        | 2026-07-01 | 2026-07-05 | invalidemail           | 09123456789          | must be a well-formed email address    |
      | 2      | John                 | Smith                | true        | 2026-07-01 | 2026-07-05 | @gmail.com             | 09123456789          | must be a well-formed email address    |
      | 3      | John                 | Smith                | true        | 2026-07-01 | 2026-07-05 | !@#$%^&john@test       | 09123456789          | must be a well-formed email address    |
      | 3      | John                 | Smith                | true        | 2026-07-01 | 2026-07-05 | john@test.com          | 12                   | size must be between 11 and 21          |
      | 3      | John                 | Smith                | true        | 2026-07-01 | 2026-07-05 | john@test.com          | 123456789012345678901234 | size must be between 11 and 21          |
      | 0      | John                 | Smith                | true        | 2026-07-01 | 2026-07-05 | john@test.com          | 09123456789          | must be greater than or equal to 1                         |
      | -1     | John                 | Smith                | true        | 2026-07-01 | 2026-07-05 | john@test.com          | 09123456789          | must be greater than or equal to 1                         |



  @Negative
  Scenario Outline: Create booking when checkOut date is not after checkIn date and also with same dates
    Given user prepares booking request
      | roomid        | <roomid>      |
      | firstname     | <firstname>   |
      | lastname      | <lastname>    |
      | depositpaid   | <depositpaid> |
      | checkin       | <checkin>     |
      | checkout      | <checkout>    |
      | email         | <email>       |
      | phone         | <phone>       |

    When user send a POST request
    Then booking response status code should be 409

    Examples:
      | roomid  | firstname | lastname  | depositpaid |  checkin     | checkout    | email                     | phone        |
      | 10       | Sylvia   | Sen       |  false      |  2026-07-20  | 2026-07-18  | sylvia.sen@gmail.com      | 07234567890  |
      | 11       | Comte    | Flandre   |  true       |  2026-07-20  | 2026-07-18  | comte.flandre@gmail.com   | 09234567890  |











