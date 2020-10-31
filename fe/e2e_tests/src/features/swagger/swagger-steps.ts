import { When, Then } from "cucumber";
import { SwaggerPage } from "../../domain/swagger/swaggerPage";
const swaggerPage = new SwaggerPage();

When("I navigate to swagger", function () {
  return swaggerPage.navigateToSwagger();
});

When("I click on items swagger link", function () {
  return swaggerPage.openItemTab();
});
Then("I should see swagger info",function(){
  return swaggerPage.verifyInfo();
})
Then(/^I should see (.*) action and method (.*)$/, function (action, method) {
  return swaggerPage.verify(action, method);
});
