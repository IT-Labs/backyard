@home @all
Feature: Items Page - Create Item
    Background: prepare
        Given I login as a admin user
        And I navigate to admin's items page

    Scenario: Verify menu items from Create item page
        Then I should see Home link
        Then I should see Admin link
        Then I should see About link
        Then I should see Hi Username link
        Then I should see Logout link

    Scenario: Verify menu items redirection from Create item page
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

    @smoke
    Scenario: Verify create button will redirect on Create Item page
        When I click on create button
        Then I should see create item page

    Scenario: Verify create item page appearance
        When I click on create button
        Then I should see create item page
        And the title of the page should be "Create Item"
        And I should see Name textbox
        And I should see Description textarea
        And I should see Status dropdown
        And I should see Is Public checkbox
        And I should not see ID field
        And I should not see Poster field
        And I should see Cancel button
        And I should see Create button
        And I should see that all fields are blank and checkboxes not checked
        When I create item open again create page
        Then I should see that all fields are blank and checkboxes not checked
        When I fill the data in create item page, click cancel and open again create page
        Then I should see that all fields are blank and checkboxes not checked

    Scenario: Verify correctness of Cancel button
        When I click on create button
        Then I should see create item page
        When I click Cancel button
        Then I should be redirected on list items page
        And no error messages should be shown
        And item should not be created

    Scenario: Verify required fields in Create item page
        When I click on create button
        Then I should see create item page
        When I try to save item without data
        Then I should see "Name is required." message under name field
        And I should see Name label has asterisks symbol next to it
        And I should see Status label has asterisks symbol next to it
        And I should see Description label does not have asterisks symbol next to it
        And I should see that Is Public does not have asterisks symbol
        And I should not see "Description is required." message under description field
        And I should not see "Is Public is required." message under is public field

    Scenario: Verify max lenght limit in Create item page
        When I click on create button
        Then I should see create item page
        When I try to save Name with more than 30 characters
        Then I should see Name is restricted on FE with 30 characters
        And I should see API returns message "Name should have 30 characters." message
        When I try to save Description with more than 100 characters
        Then I should see Description is restricted on FE with 100 characters
        And I should see API returns message "Description should have 100 characters." message

    Scenario: Verify user can create item using only mandatory fields in Create item page
        When I click on create button
        Then I should see create item page
        When I add Name
        And I select Status
        And click create item
        Then Item should be created
        And I should be redirected on list items page

    @basics  
    Scenario: Verify user can create item using all fields in Create item page
        When I click on create button
        Then I should see create item page
        When I add Name SampleName
        And I add Description SampleDescription
        And I select Status
        And I check Is Public checkbox
        And click create item
        Then Item should be created
        And I should be redirected on list items page

    Scenario: Verify correctness of published private newly created items
        When I click on create button
        Then I should see create item page
        When I create item
        And I choose status Done
        And I choose item to be private
        Then item shouldn't be seen on Home Page by me
        And item shouldn't be seen on Home Page by other logged in users
        And item shouldn't be seen on Home Page by other not logged in users

    Scenario: Verify correctness of published public newly created items
        When I click on create button
        Then I should see create item page
        When I create item
        And I choose status Done
        And I choose item to be private
        Then item should be seen on Home Page by me
        And item should be seen on Home Page by other logged in users
        And item should be seen on Home Page by other not logged in users