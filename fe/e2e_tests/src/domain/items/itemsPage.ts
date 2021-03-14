import { client } from "nightwatch-api";
import { appConfig } from "../../config";

export class ItemsPage {
  contentTimeOut = 10000;
  elements = {
    link: appConfig.url + "/items",
    menu: "#nav_items",
    content: "#items_table",
    addItem: "#link_add_item",
    noItems: "#no_items",
    modal: {
      //nightwatch not able to locate elements using the id selectors,
      //more investigation is needed why
      yes: "button.ui.icon.positive.right.labeled.button",
      no: "button.ui.negative.button",
      title: "#modal_content",
      id: "#modal",
    },
    item: {
      name: "#link_",
      status: "#status_",
      poster: "#poster_",
      published: "#published_",
      isPublic: "#isPublic_",
      description: "#description_",
      delete: "#delete_",
      firstLink: function (row: number): string {
        return `#items_table > tbody > tr:nth-child(${row}) > td:nth-child(1) > a`;
      },
      firstDeleteButton: function (row: number): string {
        return `#items_table > tbody > tr:nth-child(${row}) > td.collapsing > button`;
      },
    },
    header: {
      name: "#header_name",
      status: "#header_status",
      poster: "#header_poster",
      published: "#header_published",
      isPublic: "#header_isPublic",
      description: "#header_description",
    },
    sort: {
      name: "#sort_name",
      status: "#sort_status",
      published: "#sort_published",
      isPublic: "#sort_isPublic",
    },
    search: {
      name: "#search_name",
      status: "#search_status",
      reset: "#search_reset",
      pageSize: "#pageSize",
      page: "#items_pagination",
    },
  };

  async searchByName(value: string) {
    await client.waitForElementVisible(
      this.elements.search.name,
      this.contentTimeOut
    );
    return this.insertText(this.elements.search.name, value);
  }
  async verifyItemByNameNotExist(value: string) {
    await this.searchByName(value);
    return this.verifyNoResultsInItemsTable();
  }
  async verifyNoResultsInItemsTable() {
    return client.waitForElementVisible(
      this.elements.noItems,
      this.contentTimeOut
    );
  }
  async validateItemNamesInResultItems(value: string, row: number) {
    await client.waitForElementVisible(
      this.elements.content,
      this.contentTimeOut
    );

    for (let index = 0; index < row - 1; index++) {
      await this.validateContains(row, value);
    }
    return this.validateContains(row, value);
  }
  async searchAndClickByName(value: string) {
    await this.searchByName(value);
    return this.clickNameLink(1);
  }
  async searchAndClickDeleteByName(value: string) {
    await this.searchByName(value);
    await this.clickDeleteButton(1);
  }

  private async validateContains(row: number, value: string) {
    const rowLink = this.elements.item.firstLink(row);
    await client.waitForElementVisible(rowLink);
    return client.expect.element(rowLink).text.contain(value);
  }

  async validateItemNameInResultItems(value: string) {
    await client.waitForElementVisible(
      this.elements.content,
      this.contentTimeOut
    );
    const firstLink = this.elements.item.firstLink(1);
    await client.waitForElementVisible(firstLink);
    return client.expect.element(firstLink).text.equal(value);
  }
  async navigateToItems() {
    await client.url(this.elements.link);
    return client.waitForElementVisible(
      this.elements.content,
      this.contentTimeOut
    );
  }

  async clickNameLink(row: number) {
    await client.waitForElementVisible(
      this.elements.content,
      this.contentTimeOut
    );
    const firstLink = this.elements.item.firstLink(row);
    await client.waitForElementVisible(firstLink);
    return client.click(firstLink);
  }

  async clickDeleteButton(row: number) {
    await client.waitForElementVisible(
      this.elements.content,
      this.contentTimeOut
    );

    const firstLink = this.elements.item.firstDeleteButton(row);

    await client.waitForElementVisible(firstLink);
    return client.click(firstLink);
  }

  async clickCreateItem() {
    await client.waitForElementVisible(
      this.elements.addItem,
      this.contentTimeOut
    );
    return client.click(this.elements.addItem);
  }
  async validateItemsPage() {
    return client.assert.urlEquals(this.elements.link);
  }
  async validateDeleteConfirmationDialog() {
    return client.waitForElementVisible(this.elements.modal.title);
  }
  async clickOkModal() {
    await client.waitForElementVisible(
      this.elements.modal.yes,
      this.contentTimeOut
    );
    return client.click(this.elements.modal.yes);
  }

  private async insertText(id: string, value: string) {
    await client.assert.visible(id);
    await client.clearValue(id);
    return await client.setValue(id, value);
  }
}
