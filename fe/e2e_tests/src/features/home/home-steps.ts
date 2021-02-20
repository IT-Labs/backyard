import { Then, When } from "cucumber";
import { HomePage } from "../../domain/home/homePage";
const page = new HomePage();
When("I navigate to home", function () {
  return page.navigateToHomeUrl();
});

Then(
  /^I should see message in the middle of the screen: (.*)$/,
  function (message: string) {
    return page.verifyHomeMessage(message);
  }
);
