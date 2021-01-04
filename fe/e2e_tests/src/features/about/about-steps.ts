import { When } from "cucumber";
import { AboutPage } from "../../domain/about/aboutPage";
const page = new AboutPage();
When("I navigate to about", function () {
  return page.navigateToAbout();
});
