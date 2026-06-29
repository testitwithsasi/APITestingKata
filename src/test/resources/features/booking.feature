@Booking
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
      | 1      | Sarah     | Ali        | true        | 2026-07-01  | 2026-07-12  | sarah.ali@google.com      | 09234567890   |
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
      | 1      | Jo                   | Smith                | true        | 2026-07-01 | 2026-07-05 | john@test.com          | 09123456789          | size must be between 3 and 18          |
      | 1      | firstnamefirstnamefirstnamefirstname  | Smith                | true        | 2026-07-01 | 2026-07-05 | john@test.com          | 09123456789          | size must be between 3 and 18          |
      | 1      | John                 | Do                   | true        | 2026-07-01 | 2026-07-05 | john@test.com          | 09123456789          | size must be between 3 and 30          |
      | 1      | John                 | lastnamelastnamelastnamelastname  | true        | 2026-07-01 | 2026-07-05 | john@test.com          | 09123456789          | size must be between 3 and 30          |
      | 1      | John                 | Smith                | true        | 2026-07-01 | 2026-07-05 | invalidemail           | 09123456789          | must be a well-formed email address    |
      | 1      | John                 | Smith                | true        | 2026-07-01 | 2026-07-05 | @gmail.com             | 09123456789          | must be a well-formed email address    |
      | 1      | John                 | Smith                | true        | 2026-07-01 | 2026-07-05 | !@#$%^&john@test       | 09123456789          | must be a well-formed email address    |
      | 1      | John                 | Smith                | true        | 2026-07-01 | 2026-07-05 | john@test.com          | 12                   | size must be between 11 and 21          |
      | 1      | John                 | Smith                | true        | 2026-07-01 | 2026-07-05 | john@test.com          | 123456789012345678901234 | size must be between 11 and 21          |
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



  @Regression @Positive
  Scenario Outline: Retrieve booking with valid booking id
    Given user provides booking id "<bookingId>"
    When user sends a GET booking request
    Then booking response status code should be 200
    And booking response should contain booking id "<bookingId>"
    And booking response should contain all mandatory fields

    Examples:
      | bookingId |
      | 1 |
      | 2 |
      | 3 |

  @Regression @Negative
  Scenario Outline: Retrieve booking with invalid authentication token
    Given user provides booking id "<bookingId>"
    And user provides invalid authentication token
    When user sends a GET booking request without token
    Then booking response status code should be 403

    Examples:
      | bookingId |
      | 1 |
      | 2 |

  @Regression @Negative
  Scenario Outline: Retrieve booking without authentication token
    Given user provides booking id "<bookingId>"
    When user sends a GET booking request without token
    Then booking response status code should be 403

    Examples:
      | bookingId |
      | 1 |
      | 2 |


  @Regression @UpdateBooking
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
    Then booking response status code should be <statusCode>

    Examples:
      | bookingId | roomid | firstname | lastname | depositpaid | checkin   | checkout  | email                    | phone       | statusCode | Test Case |
      | 1 | 2 | Jane | Doe | true | 2026-10-13 | 2026-10-15 | jane@example.com | 09876543210 | 200 | Update firstname |
      | 2 | 2 | John | Smith | true | 2026-10-13 | 2026-10-15 | john@example.com | 09234567890 | 200 | Update lastname |
      | 3 | 3 | John | Doe | true | 2026-10-13 | 2026-10-15 | john@example.com | 08234567890 | 200 | Update room id |

  @Regression @UpdateBooking
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
    Then booking response status code should be <statusCode>

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