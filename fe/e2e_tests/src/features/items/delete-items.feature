@home @all
Feature: Items Page - Delete Item
    Background: prepare
        Given I login as a admin user 
        And I navigate to admin's items page
        And there are items created

    Scenario: Verify delete icon
        Then I should see delete icon in each row as first option

    Scenario: Verify delete confirmation modal
        When I click on Delete icon
        Then I should see delete confirmation modal
        And the title of the modal should be "Delete item"
        And the message in the modal should be "Are you sure you want to delete this item?"
        And the buttons of the modal should be "Cancel" and "OK" 

    Scenario: Verify correctness of Cancel button in delete confirmation modal  
        When i click on Delete icon
        And I click Cancel from delete confirmation modal
        Then modal should closes
        And I should be on a same item page where previously was
        And the item should not be deleted

    Scenario: Verify delete item that is only item in the table
        When i click on Delete icon
        And I confirm the deletion
        Then I should see that modal is closed
        And I should be on a same item page where previously was
        And I should see that Item is removed from the table
        And I should see that table is no longer displayed
        And I should see that No results found! is displayed

    Scenario: Verify delete item when there are other items in the table
        When i click on Delete icon
        And I confirm the deletion
        Then I should see that modal is closed
        And I should be on a same item page where previously was
        And I should see that Item is removed from the table
        And I should see that No results found! is not displayed
        And I should see the table is now organized to show again 10/25/50/100 results 

    Scenario: Verify delete item for already deleted item
        Given I didn't refreshed the page
        And other admin already deleted my item
        When i click on Delete icon
        Then I should receive red toaster message: This item is already deleted. Please refresh your page! 