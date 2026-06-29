@Health
Feature: Health Checkup API

  @Smoke @Regression @Positive
  Scenario: Verify the application health status
    When send GET request to the health endpoint
    Then health response status code should be 200
    And response status should be "UP"

  @Negative
  Scenario: Verify health endpoint returns invalid status
    When send GET request to the health endpoint
    Then health response status code should be 200
    And response status should be "DOWN"

  @Negative
  Scenario: Verify health endpoint missing status field
    When send GET request to the health endpoint
    Then health response status code should be 200
    And response body should not contain key "status"