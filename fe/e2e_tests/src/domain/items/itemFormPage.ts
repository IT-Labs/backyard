import { client } from "nightwatch-api";
import { appConfig } from "../../config";

export class ItemFormPage {
  elements = {
    link: appConfig.url + "/item",
    content: "#item",
    save: "#save",
    back: "#back",
    name: "#name",
    status: "#status",
    openStatus: "#status > i",
    statusDone:
      "#status > div.visible.menu.transition > div:nth-child(2) > span",
    isPublic: "#item > div:nth-child(4) > div > label",
    description: "#description",
  };
  async navigateToItem(id: string) {
    await client.url(this.elements.link + "/" + id);
    return client.waitForElementVisible(this.elements.content, 10000);
  }
  async saveItem() {
    return client.click(this.elements.save);
  }

  async back() {
    return client.click(this.elements.back);
  }
  async validateItemFormPage() {
    await client.pause(2000);
    return client.assert.urlContains("/item/");
  }

  async addNameValue(value: string) {
    return this.insertText(this.elements.name, value);
  }
  async clickCreate() {
    return client.click(this.elements.save);
  }

  async checkPublic() {
    return client.click(this.elements.isPublic);
  }
  async selectStatus() {
    await client.click(this.elements.openStatus);
    return client.click(this.elements.statusDone);
  }

  async addDescriptionValue(value: string) {
    return this.insertText(this.elements.description, value);
  }
  async validateName(value: string) {
    return this.validateText(this.elements.name, value);
  }
  async validateStatus(value: string) {
    return this.validateText(this.elements.status, value);
  }
  async validateIsPublic(value: string) {
    return this.validateText(this.elements.status, value);
  }
  async validateDescription(value: string) {
    return this.validateText(this.elements.description, value);
  }

  private async validateText(id: string, value: string) {
    await client.assert.visible(id);
    return client.expect.element(id).text.equal(value);
  }

  private async insertText(id: string, value: string) {
    await client.assert.visible(id);
    await client.clearValue(id);
    return await client.setValue(id, value);
  }
}
