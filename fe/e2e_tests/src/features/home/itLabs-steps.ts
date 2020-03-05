import { When, Then } from "cucumber";
import { ItLabsPage } from "../../domain/home/itLabsPage";
const page = new ItLabsPage();

Then("I should land on it labs site", function() {
  return page.validateItLabsSite();
});
