@home @all
Feature: Items Page
    Background: prepare
        Given I navigate to items
        Then I fill userName
        Then I fill password
        Then I click sign in

    @smoketest
    Scenario: verify footer logo
        Then I should see it labs link
        Then I should see logo

    Scenario: verify items table
        Then I should see items in table



