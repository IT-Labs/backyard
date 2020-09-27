import { When } from "cucumber";
import { ItemsPage } from "../../domain/items/itemsPage";
const page = new ItemsPage();
When("I navigate to items", function() {
  return page.navigateToItems();
});


