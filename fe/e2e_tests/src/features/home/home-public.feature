@home @all
Feature: Home Page
    Background: prepare
        Given I navigate to home
    @smoke
    Scenario Outline: Verify menu items from Home page when user is public
        Then the menu <Link> should be <isVisible>
        Examples:
            | Link        | isVisible |
            | Home        | true      |
            | Admin       | false     |
            | About       | true      |
            | Hi Username | false     |
            | Login       | true      |
            | Logout      | false     |


    @smoke
    Scenario Outline: Verify menu items redirection from Home page
        Then the result should be <redirectedON>
        Examples:
            | User          | Click on               | redirectedON  |
            | admin         | Home                   | Home page     |
            | admin         | Admin > Items          | Items page    |
            | admin         | About                  | About page    |
            | admin         | Hi Username > Settings | Settings page |
            | admin         | Logout                 | Login page    |
            | not logged in | Home                   | Home page     |
            | not logged in | About                  | About page    |
            | not logged in | Login                  | Login page    |

    @empty
    Scenario: Verify Home page main page when there are no public published items
        Then I should see message in the middle of the screen: There are no items yet!

    Scenario: Verify Home page main page when there are public published items
        Then I should see public published items

    Scenario Outline: Verify the display of the items in the Home page
        Then the result should be <Displayed as>
        Examples:
            | Number of items | Displayed as                                                                                                            |
            | 1               | First item from the left to right, middle alignment, will be dsiplayed in first row                                     |
            | 2               | The two items will have middle alignment, will be dsiplayed in first row                                                |
            | 3               | All 3 will be displayed in the first row                                                                                |
            | 4               | First 3 will be displayed in the first row, the 4th one will be shown under the second from the first row               |
            | 5               | First 3 will be displayed in the first row, the 4th and 5th one will be shown under the first row with middle alignment |
            | 6               | First 3 will be displayed in the first row, second 3 will be displayed in the second row                                |

    @smoke
    Scenario: Verify the appearance of the item card on Home page
        Then I should see correct Poster image
        And I should see correct name below the poster image, centar alignment
        And I should see the the correct Description if description is added
        And I should see empty area in place of the description if description is not added
        And I should see correct Published at

    @smoke
    Scenario: Verify the format on Published At date on the item cards on Home page
        Then I should see the publish At will be in format MM/DD/YYYY
    @smoke
    Scenario: Verify the order of the item cards on Home page
        Then I should see the item cards are ordered based on published At ASC order

    Scenario: Verify upon editing item, edited data will be displayed on Home page
        When I'm logged in as admin user
        And I click on item from Home page
        And I see the edit item screen for that item
        And I change the Name of the item
        And I change the description of the item
        When I save
        And I click on Home again
        Then I should see updated Name
        And I should see updated description
    @smoke
    Scenario: Verify items will be clickable for admin user
        When I'm logged in as admin user
        Then I should see that mouse cursor is hyperlink
    @smoke
    Scenario: Verify items won't be clickable for not logged in user
        When I'm not logged in on the application
        Then I should see that mouse cursor is text select
        And when I click on item from Home page
        Then I should not see the edit item screen for that item
        And I should be still on Home page
    @smoke
    Scenario: Verify upon click on an item, admin will be redirected on edit item page for the item
        When I'm logged in as admin user
        And I click on item from Home page
        Then I should see the edit item screen for that item

    Scenario: Verify deleted item will be removed from the Home page
        When I'm logged in as admin user
        And I find item from Home page
        And I click Admin > Items
        And I find that same item in items list
        And I click Delete icon for that item
        And I confirm the deletion
        When I select Home
        Then I should not see the that item in the Home page

    Scenario: Verify changing item from public to private will remove the item from the Home page
        When I'm logged in as admin user
        And I find item from Home page
        And I click Admin > Items
        And I find that same item in items list
        And I click on that item
        And I deselect isPublic checkbox
        And I save the changes
        When I select Home
        Then I should not see that item in the Home page

    Scenario: Verify changing item from public to private will add the item in the Home page
        When I'm logged in as admin user
        And I click Admin > Items
        And I find item in items list that has Is Public  = false
        And I click on that item
        And I select isPublic checkbox
        And I save the changes
        When I select Home
        Then I should see that item in the Home page

    Scenario: Verify publish date will be updated when user changes item from public to private and back to public
        When I'm logged in as admin user
        And I find item from Home page
        And I spot the Published At date
        And I click Admin > Items
        And I find that same item in items list
        And I click on that item
        And I deselect isPublic checkbox
        And I save the changes
        Then I open the same item
        And I select isPublic
        And save the changes
        When I select Home
        Then I should see that item's pubilished at date is updated to tooday's date in the Home page

    Scenario Outline: Verify publish date will be updated when user changes the status from Done, to <Status> and back to Done
        Then I should see the publish date will be updated
        Examples:
            | Status      |
            | Draft       |
            | In Progress |
            | Close       |

    Scenario: Verify publish date will not be changed when user changes the status from Done, to Done
        Then I should see the publish date will not be changed
