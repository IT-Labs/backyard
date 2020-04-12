@swagger @all
Feature: Swagger
    Background: prepare
        Given I navigate to swagger

    @smoketest
    Scenario: verify item endpoints
        When I click on items swagger link
        Then I should see get action and method get
        Then I should see post action and method post
        Then I should see put action and method put
        Then I should see delete action and method delete
        Then I should see get action and method getItem
