@BookingSuite @Auth
Feature: Authentication

  @Smoke @Regression @Positive
  Scenario: Login with valid credentials
    Given user sends login request
    Then the user should be logged in successfully
    And the user should be granted access to the booking system
    And authentication token should not be empty

  @Validation @Negative
  Scenario Outline: Login with invalid credentials
    Given the user provides the following credentials
      | username       |   password     |
      | <username>     |   <password>   |
    When user sends login request
    Then login should fail
    And response should contain error "Invalid credentials"

    Examples:
      | username | password |
      |          |          |
      |          | password |
      | admin    |          |
      | wrong    | password |
      | admin    | wrong    |
      | 123456789    | password    |
      | #@!^&*(%^    | password    |
      | admin    | 123456password    |
      | admin    | #@!^&*(%^    |
      | loginwithinvalidusernameloginwithinvalidusernameloginwithinvalidusernameloginwithinvalidusernameloginwithinvalidusernameloginwithinvalidusernameloginwithinvalidusernameloginwithinvalidusernameloginwithinvalidusernameloginwithinvalidusernameloginwithinvalidusername         |          |
      | loginwithinvalidusernameloginwithinvalidusernameloginwithinvalidusernameloginwithinvalidusernameloginwithinvalidusernameloginwithinvalidusernameloginwithinvalidusernameloginwithinvalidusernameloginwithinvalidusernameloginwithinvalidusernameloginwithinvalidusername         |  password  |
      | admin    |  loginwithinvalidpasswordloginwithinvalidpasswordloginwithinvalidpasswordloginwithinvalidpasswordloginwithinvalidpasswordloginwithinvalidpasswordloginwithinvalidpasswordloginwithinvalidpasswordloginwithinvalidpasswordloginwithinvalidpasswordloginwithinvalidpassword  |
      |          |  loginwithinvalidpasswordloginwithinvalidpasswordloginwithinvalidpasswordloginwithinvalidpasswordloginwithinvalidpasswordloginwithinvalidpasswordloginwithinvalidpasswordloginwithinvalidpasswordloginwithinvalidpasswordloginwithinvalidpasswordloginwithinvalidpassword  |