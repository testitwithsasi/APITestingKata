# APITestingKata
API test automation for [automationintesting.online](https://automationintesting.online) — built with Cucumber BDD + REST Assured + JUnit Jupiter 5 + Allure.

    
# Overview
This project is a BDD-based API automation framework developed using Java, Cucumber, JUnit 5, and REST Assured. 
It automates the testing of the Restful Booker API by validating authentication, health check, and booking management endpoints.
The framework follows the Page Object-like design for APIs by separating feature files, step definitions, request builders, payloads, and utility classes to improve maintainability and scalability.


# Stack
- Java 17
- Maven
- Cucumber 7.22
- REST Assured 5.5.2
- JUnit Jupiter 5.12.2
- Allure 2.29.1


# Project Structure

```
├── pom.xml
├── README.md
└── src
    └── test
        ├── java
        │   └── com
        │       └── booking
        │           ├── config
        │           ├── models
        │           ├── serviceapi
        │           ├── stepdefinitions
        │           ├── utils
        │           └── TestRunner.java
        └── resources
            └── features
```



# API Base URL
    https://automationintesting.online/api

# Endpoints

## Health API

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/booking/actuator/health` | Check API health status |

---

## Authentication API

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/auth/login` | Generate authentication token |

---

## Booking API

| Method | Endpoint | Description                                                               |
|--------|----------|---------------------------------------------------------------------------|
| POST | `/booking` | Create booking                                                            |
| GET | `/booking/{id}` | Retrieve booking                                                          |
| PUT | `/booking/{id}` | Update booking                                                            |
| PATCH | `/booking/{id}` | Partial update booking (But its not working as expected from the website) |
| DELETE | `/booking/{id}` | Delete booking                                                            |


# How to Run Tests from Command prompt
1. To clone the Repository --> git clone https://github.com/testitwithsasi/APITestingKata.git 
2. Optional: Change the repository as per the project name, in order to run locally --> cd APITestingKata
3. To clean and compile the project --> mvn clean compile

# To run all tests
```
mvn clean test
```

# Reporting
## Generate Allure results
```
allure generate target/allure-results --clean -o target/allure-report
allure open target/allure-report
```