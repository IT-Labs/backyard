@home @all
Feature: Items Page - Edit Item
    Background: prepare
        Given I login as a admin user 
        And I navigate to admin's items page

    Scenario: Verify menu items from Edit item page
        Then I should see Home link
        Then I should see Admin link
        Then I should see About link
        Then I should see Hi Username link
        Then I should see Logout link

    Scenario: Verify menu items redirection from Edit item page
        When I click Home link
        Then I should see Home page
        When I click Admin link
        And I click Items
        Then I should see Items page
        When I click About link
        Then I should see About page
        When I click Hi Aleksandra
        And I click My profile link
        Then i should see Settings page
        When I click Logout link
        Then I should see login page

    Scenario: Verify edit option
        Then I should see Name column is hyperlink

    Scenario: Verify click on Name hyperlink redirects on Edit Item page
        When I click on a name from the table
        Then I should see edit item page
    
    Scenario: Verify edit item page appearance
        When I click on edit button
        Then I should see edit item page    
        And the title of the page should be "Edit Item"
        And I should see Name textbox prepopulated with correct name
        And I should see Description textarea prepopulated with correct description
        When status Draft was chosen for the Item
        Then I should see Draft preselected in Status dropdown
        When status In Progress was chosen for the Item
        Then I should see In Progress preselected in Status dropdown
        When status Done was chosen for the Item
        Then I should see Done preselected in Status dropdown
        When Is Public checkbox is checked
        Then I should see Is Public checkbox checked
        When Is Public checkbox is not checked
        Then I should see Is Public checkbox unchecked
        And I should not see ID field
        And I should not see Poster field
        And I should see Cancel button
        And I should see Save button

    Scenario: Verify correctness of Cancel button
        When I click to edit item
        Then I should see edit item page    
        When I click Cancel button
        Then I should be redirected on list items page
        And no error messages should be shown
        And item should not be changed

    Scenario: Verify required fields in edit item page
        When I click to edit item
        Then I should see edit item page    
        When I try to save item without data
        Then I should see "Name is required." message under name field
        And I should see Name label has asterisks symbol next to it
        And I should see Status label has asterisks symbol next to it
        And I should see that Description does not have asterisks symbol
        And I should see Description label has asterisks symbol next to it
        And I should see that Publish does not have asterisks symbol
        And I should see that Is Public does not have asterisks symbol        
        And I should not see "Is Public is required." message under is public field

    Scenario: Verify max lenght limit in edit item page
        When I click to edit item
        Then I should see edit item page    
        When I try to save Name with more than 30 characters
        Then I should see Name is restricted on FE with 30 characters
        And I should see API returns message "Name should have 30 characters." message
        When I try to save Description with more than 100 characters
        Then I should see Description is restricted on FE with 100 characters
        And I should see API returns message "Description should have 100 characters." message
     
    Scenario: Verify user can edit item changing only mandatory fields
        When I click to edit item
        Then I should see edit item page
        When I change the Name
        And I change the Status
        And click Save
        Then Item should be saved
        And I should be redirected on list items page

    Scenario: Verify user can edit item changing all fields in edit page
        When I click to edit item
        Then I should see edit item page
        When I change the Name
        And I change the Description
        And I change the Status option
        And I change Is Public option
        And click Save
        Then Item should be saved
        And I should be redirected on list items page

   Scenario: Verify user can edit item removing non mandatory data in edit page
        When I click to edit item
        Then I should see edit item page
        When I remove the description
        And I uncheck Is Public checkbox
        And click Save
        Then Item should be saved
        And I should be redirected on list items page

   Scenario: Verify user can edit item adding data in non mandatory fields that was previously empty in edit page
        When I click to edit item
        Then I should see edit item page
        When I remove the description
        And I uncheck Is Public checkbox
        And click Save
        Then Item should be saved
        And I should be redirected on list items page

    Scenario: Verify correctness of published private edited items
        When I click to edit item
        Then I should see edit item page
        When I edit item
        And I choose status Done
        And I choose item to be private
        Then item shouldn't be seen on Home Page by me        
        And item shouldn't be seen on Home Page by other logged in users        
        And item shouldn't be seen on Home Page by other not logged in users

    Scenario: Verify correctness of published public edited items
        When I click to edit item
        Then I should see edit item page
        When I edit item
        And I choose status Done
        And I choose item to be private
        Then item should be seen on Home Page by me        
        And item should be seen on Home Page by other logged in users        
        And item should be seen on Home Page by other not logged in users