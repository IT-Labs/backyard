@home @all
Feature: Items Page
    Background: prepare
        Given I navigate to items

    @smoketest
    Scenario: verify footer logo
        Then I should see it labs link
        Then I should see logo

    Scenario: verify items table
        Then I should see items in table



