import { client } from "nightwatch-api";

export class FooterPage {
  elements = {
    logo: "#logo",   
    link: "#itLabs"
  };
  async validateItLabsLink() {
    return client.assert.elementPresent(this.elements.link);
  }

  async validateLogo() {
    return client.assert.elementPresent(this.elements.logo);
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
