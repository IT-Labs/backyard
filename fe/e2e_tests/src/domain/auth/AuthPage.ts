import { client } from "nightwatch-api";

export class AuthPage {
  elements = {
    loginLink: "#login",
    password: "#password",
    userName: "#username",
    loginBtn: "#kc-login",
  };
  async clickLink() {
    await client.waitForElementVisible(this.elements.loginLink, 500);
    return client.click(this.elements.loginLink);
  }
  async fillUserName(userName: string) {
    await client.waitForElementVisible(this.elements.userName, 500);
    return client.setValue(this.elements.userName, userName);
  }
  async fillUserPassword(password: string) {
    return client.setValue(this.elements.password, password);
  }
  async clickSignInBtn() {
    return client.click(this.elements.loginBtn);
  }
}
