import { When } from "cucumber";
import { HomePage } from "../../domain/home/homePage";
const page = new HomePage();
When("I navigate to home", function() {
  return page.navigateToHomeUrl();
});


