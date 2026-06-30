@BookingSuite @Auth
Feature: Authentication

  @Smoke @Regression @Positive
  Scenario Outline: Login with valid credentials
    Given user enters username "<username>"
    And user enters password "<password>"
    When user sends login request
    Then user should be logged in successfully
    And authentication token should be generated
    And authentication token should not be empty

    Examples:
      | username | password |
      |  admin   | password |

  @Validation @Negative
  Scenario Outline: Login with invalid credentials
    Given user enters username "<username>"
    And user enters password "<password>"
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