import { client } from "nightwatch-api";
export class ItLabsPage {
  elements = {
    menu: ".menu-item",
    layout: "#layout"
  };

  async validateItLabsSite() {   
      
    await client.waitForElementVisible(this.elements.menu, 5000);
    return client.assert.elementPresent(this.elements.menu);
  }
}


