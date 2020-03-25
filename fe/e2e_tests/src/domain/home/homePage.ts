import { client } from "nightwatch-api";
import { appConfig } from "../../config";

export class HomePage {
  elements = {
    logo: "#logo",
    products: "#products",
    faq: "#faq",
    link: "#itLabs",
    itLabsContent: "#page_content"
  };

  async navigateToHome() {
    const url = appConfig.url + "/";
    await client.url(url);
    return client.waitForElementVisible(this.elements.logo, 500);
  }

  async validateItLabsLink() {
    return client.assert.elementPresent(this.elements.link);
  }

  async validateLogo() {
    return client.assert.elementPresent(this.elements.logo);
  }
  navigateToProducts() {
    return client.click(this.elements.products);
  }

  navigateToFaq() {
    return client.click(this.elements.faq);
  }

  async navigateToItlabs() {
    await client.click(this.elements.link);
    return switchTab();
  }
}
async function switchTab() {
  await client.windowHandles(function(result) {
    var handle = result.value[1];
    client.switchWindow(handle);
  });
}
