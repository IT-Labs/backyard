import { client } from "nightwatch-api";
import { appConfig } from "../../config";

export class HomePage {
  elements = {  
    link: appConfig.url + "/",
    content:"#comingSoon"
  };
  async navigateToHome() {   
    await client.url(this.elements.link);
    return client.waitForElementVisible(this.elements.content, 500);
  }
}
