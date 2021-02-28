import { client } from "nightwatch-api";

export class MenuPage {
  elements = {
    home: "#nav_home",
    about: "#nav_about",
    admin: "#nav_admin",
    username: "#nav_username",
    login: "#nav_login",
    items: "#nav_items",
  };

  async checkLinkVisibility(link: string, isVisible: boolean) {
    console.log("click on " + link);
    switch (link) {
      case "Home":
        return this.validateMainMenu(this.elements.home, isVisible);
      case "About":
        return this.validateMainMenu(this.elements.about, isVisible);
      case "Admin":
        return this.validateMainMenu(this.elements.admin, isVisible);
      case "Hi Username": {
        if (isVisible == true) {
          console.log("testing visible" + isVisible);
          return await client.assert.elementPresent(this.elements.username);
        }
        console.log("testing not visible" + isVisible);
        return await client.assert.elementNotPresent(this.elements.username);
      }
      case "Login":
        return this.validateLogin(this.elements.login, link, isVisible);
      case "Logout":
        return this.validateLogin(this.elements.login, link, isVisible);
    }
  }
  async validateLogin(element: string, link: string, isVisible: boolean) {
    client.getText(element, function (result) {
      isVisible
        ? this.assert.equal(link, result)
        : this.assert.notEqual(link, result);
    });
  }
  async validateMainMenu(element: string, isVisible: boolean) {
    if (isVisible) {
      return await client.assert.elementPresent(element);
    }

    return await client.assert.waitForElementNotVisible(element);
  }

  async clickItemsMenu() {
    await this.checkLinkVisibility("Admin",true);
    await client.click(this.elements.admin);
    return client.click(this.elements.items);
  }
}
