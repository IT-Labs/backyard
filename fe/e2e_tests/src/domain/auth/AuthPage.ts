import { client } from "nightwatch-api";
import { appConfig } from "../../config";

export class AuthPage {
  async login(userName: string, password: string) {
   await  client.url(this.elements.link);
    console.log("navigate to root");
  await   this.clickLink();
   await  this.fillUserName(userName);
   await  this.fillUserPassword(password);
    return this.clickSignInBtn();  
  }
  elements = {
    link:appConfig.url,
    loginLink: "#nav_login",
    password: "#password",
    userName: "#username",
    loginBtn: "#kc-login",
  };
  async clickLink() {
    await client.waitForElementVisible(this.elements.loginLink, 500);
    console.log("login click");
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
     console.log("user SignInBtn click ");
    return client.click(this.elements.loginBtn);
  }
}
