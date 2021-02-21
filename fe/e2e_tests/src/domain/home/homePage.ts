import { client } from "nightwatch-api";
import { appConfig } from "../../config";

export class HomePage {
  elements = {
    url: appConfig.url + "/",
    menu: "#nav_home",
    cardPoster: "#card_poster_",
    itemDescription: "#card_description_",
    itemPublished: "#card_published_",
    itemName: "#card_name_",
    itemLink: "#card_link_",
    content: "#items_container",
    emptyCard: "#card_no_item_header",
  };


  async verifyHomeMessage(message: string) {
    await client.waitForElementVisible(this.elements.emptyCard, 1000);
    return client.expect
      .element(this.elements.emptyCard)
      .text.to.be.equal(message);
  }
  async navigateToHomeUrl() {
    await client.url(this.elements.url);
    return client.waitForElementVisible(this.elements.content, 1000);
  }

  async validateHomeMenuPresent() {
    return client.assert.elementPresent(this.elements.menu);
  }
  async validateCardPresent(id: string) {
    await client.assert.elementPresent(this.elements.itemName + id);
    await client.assert.elementPresent(this.elements.itemPublished + id);
    await client.assert.elementPresent(this.elements.itemDescription + id);
    return client.assert.elementPresent(this.elements.cardPoster + id);
  }
  async validateLinkCardPresent(id: string) {
    return client.assert.elementPresent(this.elements.itemLink + id);
  }
}
