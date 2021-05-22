import { Then, When } from "cucumber";
import { HomePage } from "../../domain/home/homePage";
import { MenuPage } from "../../domain/menu/menuPage";
const page = new HomePage();
const menu = new MenuPage();
When("I navigate to home", function () {
  return page.navigateToHomeUrl();
});

Then(
  /^I should see message in the middle of the screen: (.*)$/,
  function (message: string) {
    return page.verifyHomeMessage(message);
  }
  
);//
Then(/^the menu (.*) should be (.*)$/, function (link:string,isVisible:boolean) {
  return menu.checkLinkVisibility(link, isVisible);
});
