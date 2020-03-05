import { When, Then } from "cucumber";
import { HomePage } from "../../domain/home/homePage";
import { ItLabsPage } from "../../domain/home/itLabsPage";

const page = new HomePage();
When("I navigate to home", function() {
  return page.navigateToHome();
});

Then('I should see it labs link', function() {
    return page.validateItLabsLink();
  });

  Then('I should see logo', function() {
    return page.validateLogo();
  });

  When("I click on it labs link", function() {
    return page.navigateToItlabs();
  });



