@BookingSuite @Health
Feature: Health Checkup API

  @Smoke @Regression @Positive
  Scenario: Verify the application health status
    When user send a request
    Then the application should be healthy
    And response status should be "UP"

  @Negative
  Scenario: Verify health endpoint returns invalid status
    When user send a request
    Then the application should be unhealthy
    And response status should be "DOWN"

  @Negative
  Scenario: Verify health endpoint missing status field
    When user send a request
    Then the health information should be incomplete
    And the service "status" should not be available