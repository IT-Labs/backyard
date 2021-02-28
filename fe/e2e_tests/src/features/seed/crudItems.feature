@seed @development
Feature: Items Init CRUD Seed
    Background: prepare
        Given I login as a admin user
        And I navigate to admin's items page
        And I click on create button
    Scenario Outline: Seeds Items for CRUD test
        When I add Name <Name>
        And I add Description <Description>
        And click create item
        Then Item should be created
        Examples:
            | Name       | Description           |
            | EditItem   | EditItemDescription   |
            | DeleteItem | DeleteItemDescription |
            | SearchItem | SearchItemDescription |
