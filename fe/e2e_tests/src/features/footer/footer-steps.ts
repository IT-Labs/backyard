import { When, Then } from "cucumber";
import { FooterPage } from "../../domain/footer/footer";
const page = new FooterPage();
Then('I should see it labs link', function() {
    return page.validateItLabsLink();
  });

  Then('I should see logo', function() {
    return page.validateLogo();
  });

  When("I click on it labs link", function() {
    return page.navigateToItlabs();
  });



