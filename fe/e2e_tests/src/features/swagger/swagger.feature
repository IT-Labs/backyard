@swagger @all
Feature: Swagger
    Background: prepare
        Given I navigate to swagger

    @smoketest
    Scenario: verify product endpoints
        When I click on products swagger link
        Then I should see get action and method get
        Then I should see post action and method post
        Then I should see put action and method put
        Then I should see delete action and method delete
        Then I should see get action and method getItem
