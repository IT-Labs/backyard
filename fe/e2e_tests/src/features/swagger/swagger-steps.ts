import { When, Then } from "cucumber";
import { SwaggerPage } from "../../domain/swagger/swaggerPage";
const swaggerPage = new SwaggerPage();

When("I navigate to swagger", function() {
  return swaggerPage.navigateToSwagger();
});

When("I click on products swagger link", function() {
  return swaggerPage.openProductsTab();
});

Then(/^I should see (.*) action and method (.*)$/, function(action, method) {
  return swaggerPage.verify(action, method);
});
