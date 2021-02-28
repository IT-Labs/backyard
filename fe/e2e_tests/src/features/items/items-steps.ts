import { Then, When } from "cucumber";
import { ItemFormPage } from "../../domain/items/itemFormPage";
import { ItemsPage } from "../../domain/items/itemsPage";
import { MenuPage } from "../../domain/menu/menuPage";
const page = new ItemsPage();
const menu = new MenuPage();
const itemFormPage = new ItemFormPage();
When("I navigate to items", function () {
  return page.navigateToItems();
});

When("I navigate to admin's items page", function () {
  return menu.clickItemsMenu();
});

When("I click on a name from the table", function () {
  return page.clickNameLink();
});

When("I click on create button", function () {
 return page.clickCreateItem();
});

When(/^I add Name (.*)$/, function (value:string) {
 return itemFormPage.addNameValue(value);
});
When(/^I add Description (.*)$/, function (value: string) {
  return itemFormPage.addDescriptionValue(value);
});
When("I select Status", function () {
  return itemFormPage.selectStatus();
});
When("I check Is Public checkbox", function () {
  return itemFormPage.checkPublic();
});
When("click create item", function () {
  return itemFormPage.clickCreate();
});
Then("Item should be created", function () {
  page.validateItemsPage();
});
Then("I should be redirected on list items page", function () {
  page.validateItemsPage();
});
Then(/^I should see (.*) item page$/, function (action: string) {
  return itemFormPage.validateItemFormPage();
});
