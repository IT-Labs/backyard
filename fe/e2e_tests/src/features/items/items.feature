@home @all
Feature: Items Page - list items
    Background: prepare
        Given I navigate to admin's items page
	Then I fill userName
        Then I fill password
        Then I click sign in
        
      @smoketest
    Scenario: verify footer logo
        Then I should see it labs link
        Then I should see logo    

    Scenario: Verify menu items from Admin List items page
        Then I should see Home link
        Then I should see Admin link
        Then I should see About link
        Then I should see Hi Username link
        Then I should see Logout link

    Scenario: Verify menu items redirection from Admin List items page
        When I click Home link
        Then I should see Home page
        When I click Admin link
        And I click Items
        Then I should see Items page
        When I click About link
        Then I should see About page
        When I click Hi Aleksandra
        And I click My profile link
        Then i should see My profile page
        When I click Logout link
        Then I should see login page

    Scenario: Verify Items page without items
        When there are no items created
        Then I should see No results found! 
        And I should not see table header

    Scenario: Verify items page with items
         When there are items created
         Then I should see not No results found 
         And I should see table header
         And I should see created items

    Scenario: Verify table header
         When there are items created
         Then I should see ID as second column
         And I should see Name as second column
         And I should see Description as third column
         And I should see Published as forth column
         And I should see Status as fifth column
         And I should see Is Public as sixth column
         And I should see Poster as seventh column

    Scenario: Verify table default order
         When there are items created
         Then I should see items ordered by created date DESC
         When I create new item
         Then I should see newly created items at the top
         When I edit item
         Then I should not see order changes

    Scenario: Verify table sorting options
         When there are items created
         And I click on ID column header
         Then items should be sorted by ID ASC
         And I click on ID column header again
         Then items should be sorted by ID DESC
         And I click on ID column header third time
         Then items should be default sorted
         When I click on Name column header
         Then items should be sorted by Name ASC
         And I click on Name column header again
         Then items should be sorted by Name DESC
         And I click on Name column header third time
         Then items should be default sorted
         When I click on Description column header
         Then items should be sorted by Description ASC
         And I click on Description column header again
         Then items should be sorted by Description DESC
         And I click on Description column header third time
         Then items should be default sorted
         When I click on Published column header
         Then items should be sorted by Published ASC
         And I click on Published column header again
         Then items should be sorted by Published DESC
         And I click on Published column header third time
         Then items should be default sorted
         When I click on Status column header
         Then items should be sorted by Status ASC
         And I click on Status column header again
         Then items should be sorted by Status DESC
         And I click on Status column header third time
         Then items should be default sorted

    Scenario: Verify pagination
         When there are items created
         Then I should see pagination 10, 25, 50 and 100 as options
         And I should see 10 as default option
         When i choose 10 as pagination option from desired page
         Then I should be able to see 10 items in a table on each page 
         When i choose 25 as pagination option from desired page
         Then I should be able to see 25 items in a table on each page
         When i choose 50 as pagination option from desired page
         Then I should be able to see 50 items in a table on each page
         When i choose 100 as pagination option from desired page
         Then I should be able to see 100 items in a table on each page

    Scenario: Verify navigations using arrows << <  > >>
         When there are items created
         Then I should see arrows << <  > >> navigation
         And << should be disabled when i am on a first page
         And < should be disabled when i am on a first page
         And >> should be disabled when i am on a last page
         And > should be disabled when i am on a last page
         When I am on a page different than first page
         And I click on << 
         Then I should be redirected on the first page
         When I am on a page different than first page
         And I click on < 
         Then I should be redirected on the page before the page where currently am
         When I am on a page different than last page
         And I click on >> 
         Then I should be redirected on the last page
         When I am on a page different than last page
         And I click on >
         Then I should be redirected on the page after the page where currently am

   Scenario: Verify navigations, items order and pagination will work as expected
        When there are items created
        And I sorted the page by ID / Name / Description / Published / Status
        And I am on page 10
        And I choose show 100 results
        Then I should see 100 results per page
        And they should be ordered by chosen sort option
        And I should be redirected to page 1

   Scenario: Verify correct data is displayed in the table 
       When there are items created
       Then all created items should be listed in the table

   Scenario: Verify correct data is displayed in the fields upon creating new item 
       When I create new item with only mandatory data entered
       Then I should see all data in the table correctly populated
       When I create new item with all data entered
       Then I should see all data in the table correctly populated

   Scenario: Verify correct data is displayed in the fields upon editing existing item  
       When I edit item's mandatory data
       Then I should see all data in the table correctly populated
       When I edit item's non mandatory data
       Then I should see all data in the table correctly populated

   Scenario: Verify Poster images are correctly displayed in the table  
       Then I should see random photo as poster image

    Scenario: Verify N/A is displayed in the cells for not published items  
       When I create item 
       And I don't publish the item (status different than Done)
       Then I should see the published date as N/A 
       When I edit the item 
       And I don't publish the item (status is Done)
       Then I should see the published date as N/A 

    Scenario: Verify date in the table is in format MM/DD/YYYY  
       When I create item 
       And I publish the item
       Then I should see the published date as MM/DD/YYYY 
       When I edit the item 
       And I publish the item
       Then I should see the published date as MM/DD/YYYY 

    Scenario: Verify correctness by Search by Name  
       When I add full item's name 
       Then I should get item with that name as a result
       When I add item's partial name
       Then I should get all matching results that contain that partial name
       When I add space
       Then search should not be perfromed
       And I should get all results
       When I add multiple names in the search
       Then I should get results that contain some of those names 

    Scenario: Verify correctness by Search by Status  
       When I select Status Draft 
       Then I should get all items with status draft as a result
       And I should not see items in status In Progress
       And I should not see items in status Close
       And I should not see items in status Done
       When I select Status In Progress 
       Then I should get all items with status In Progress as a result
       And I should not see items in status Draft
       And I should not see items in status Close
       And I should not see items in status Done
       When I select Status Close 
       Then I should get all items with status Close as a result
       And I should not see items in status Draft
       And I should not see items in status In Progress
       And I should not see items in status Done
       When I select Status Done 
       Then I should get all items with status Done as a result
       And I should not see items in status Draft
       And I should not see items in status In Progress
       And I should not see items in status Close