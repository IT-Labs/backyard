import { client } from "nightwatch-api";
import { appConfig } from "../../config";

export class AboutPage {
  elements = {  
    link: appConfig.url + "/about",
    content:"#comingSoon"
  };
  async navigateToAbout() {   
    await client.url(this.elements.link);
    return client.waitForElementVisible(this.elements.content, 500);
  }
}
