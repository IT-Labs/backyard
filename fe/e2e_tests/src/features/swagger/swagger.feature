@swagger @all
Feature: Swagger
    Background: prepare
        Given I navigate to swagger

    @smoketest
    Scenario: verify item endpoints
        When I click on items swagger link
        Then I should see swagger info