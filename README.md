# APITestingKata
API test automation for [automationintesting.online](https://automationintesting.online) — built with Cucumber BDD + REST Assured + JUnit Jupiter 5 + Allure.

## Stack
- Java 17
- Maven
- Cucumber 7.22
- REST Assured 5.5.2
- JUnit Jupiter 5.12.2
- Allure 2.29.1

## How to Run Tests from Command prompt
1. To clone the Repository --> git clone https://github.com/testitwithsasi/APITestingKata.git 
2. Optional: Change the repository as per the project name, in order to run locally --> cd APITestingKata
3. To clean and compile the project --> mvn clean compile

## To run all tests
```
mvn clean test
```

# To run tests by tag
```
mvn clean test -Dcucumber.filter.tags="@Health"
mvn clean test -Dcucumber.filter.tags="@Auth"
mvn clean test -Dcucumber.filter.tags="@Booking"
mvn clean test -Dcucumber.filter.tags="@Smoke"
mvn clean test -Dcucumber.filter.tags="@Regression"
mvn clean test -Dcucumber.filter.tags="@Positive"
mvn clean test -Dcucumber.filter.tags="@Negative"
mvn clean test -Dcucumber.filter.tags="@Validation"
mvn clean test -Dcucumber.filter.tags="@UpdateBooking"
```

## Allure Report
```
allure generate target/allure-results --clean -o target/allure-report
allure open target/allure-report
```