@home @all
Feature: About Page
    Background: prepare
        Given I navigate to about

    @smoketest
    Scenario: verify footer logo
        Then I should see it labs link
        Then I should see logo
             