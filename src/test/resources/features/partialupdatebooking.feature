@BookingSuite @PartialUpdateBooking
Feature: Partial update

  # ------ PATCH Method is not allowing ---------------
  Scenario Outline: Partial update of booking with valid fields
    Given user prepares partial booking request
      | roomid      | <roomid>      |
      | firstname   | <firstname>   |
      | lastname    | <lastname>    |
      | depositpaid | <depositpaid> |

    When user sends a partial update request
    Then booking response status code should be 405

    Examples:
      |roomid| firstname | lastname | depositpaid |
      | 2 | John      | Doe      | true        |
      | 2| Jane      | Smith    | false       |
      | 2 | Sam       | NULL     | true        |
      | 2| NULL      | Brown    | false       |
      | 2 | Alice     | White    | NULL        |