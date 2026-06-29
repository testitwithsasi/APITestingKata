Feature: Health Checkup API

  @Smoke @Regression
  Scenario: Verify the application health status
    When send GET request to the health endpoint
    Then the response status code should be 200
    And the response body should contain status "UP"