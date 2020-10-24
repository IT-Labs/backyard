import { client } from "nightwatch-api";
import { appConfig } from "../../config";

export class ItemsPage {
  elements = {  
    link: appConfig.url + "/items",
    content:"#item"
  };
  async navigateToItems() {   
    await client.url(this.elements.link);
    return client.waitForElementVisible(this.elements.content, 10000);
  }
}
