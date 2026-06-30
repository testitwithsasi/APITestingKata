@BookingSuite @Health
Feature: Health Checkup API

  @Smoke @Regression @Positive
  Scenario: Verify the application health status
    When send GET request to the health endpoint
    Then the application should be healthy
    And response status should be "UP"

  @Negative
  Scenario: Verify health endpoint returns invalid status
    When send GET request to the health endpoint
    Then the application should be unhealthy
    And response status should be "DOWN"

  @Negative
  Scenario: Verify health endpoint missing status field
    When send GET request to the health endpoint
    Then the health information should be incomplete
    And the service "status" should not be available