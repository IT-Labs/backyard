@home @all
Feature: Home Page
    Background: prepare
        Given I navigate to home

    @smoketest
    Scenario: verify home logo
        Then I should see it labs link
        Then I should see logo
     
    @smoketest
    Scenario: navigate to it labs site
        When I click on it labs link
        Then I should land on it labs site
        