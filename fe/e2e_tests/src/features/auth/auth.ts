import { Given, Then, When } from "cucumber";
import { AuthPage } from "../../domain/auth/AuthPage";

const page = new AuthPage();
Given("I login as a admin user", function () {
return page.login("sample","sample")
});
Then("I click login", function () {
  return page.clickLink();
});

Then("I fill userName", function () {
  return page.fillUserName("sample");
});

Then("I fill password", function () {
  return page.fillUserPassword("sample");
});
Then("I click sign in", function () {
  return page.clickSignInBtn();
});
