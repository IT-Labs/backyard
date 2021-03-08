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
  return page.clickNameLink(1);
});
When(/^I click to edit item with name (.*)$/, function (value: string) {
  return page.searchAndClickByName(value);
});
When(
  /^I click on Delete icon for item with name(.*)$/,
  function (value: string) {
    return page.searchAndClickDeleteByName(value);
  }
);

When("I click on create button", function () {
  return page.clickCreateItem();
});
When(/^I change the Name to (.*)$/, function (value: string) {
   return itemFormPage.addNameValue(value);
});
When(/^I add Name (.*)$/, function (value: string) {
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


When(/^I add (.*) in items search name$/, function (value: string) {
  return page.searchByName(value);
});
When ("I click on OK on the modal",function(){
  return page.clickOkModal();
})
Then(
  /^Item with name (.*) is not shown on items page$/,
  function (value: string) {
    return page.verifyItemByNameNotExist(value);
  }
);
Then("I should see delete confirmation modal", function () {
  return page.validateDeleteConfirmationDialog();
});
Then(
  /^I should get item with that (.*) as a result$/,
  function (value: string) {
    return page.validateItemNameInResultItems(value);
  }
);
Then(
  /^I should get (.*) results that contain (.*) in the name$/,
  function (rows: number, value: string) {
    return page.validateItemNamesInResultItems(value, rows);
  }
);
Then("Item should be created", function () {
  page.validateItemsPage();
});
Then("I should be redirected on list items page", function () {
  page.validateItemsPage();
});
Then(/^I should see (.*) item page$/, function (action: string) {
  return itemFormPage.validateItemFormPage();
});
