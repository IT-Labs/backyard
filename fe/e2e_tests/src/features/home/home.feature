@home @all
Feature: Home Page
    Background: prepare
        Given I login as a admin user

@smoke @development
    Scenario Outline: Verify menu items from Home page when user is admin
        Then the menu <Link> should be <isVisible>
        Examples:
            | Link        | isVisible |
            | Home        | true      |
            | Admin       | true      |
            | About       | true      |
            | Hi Username | true      |
            | Login       | false     |
            | Logout      | true      |

  