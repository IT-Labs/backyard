import { client } from "nightwatch-api";
import { appConfig } from "../../config";


export class ItemsPage {
  contentTimeOut = 10000;
  elements = {
    link: appConfig.url + "/items",
    menu: "#nav_items",
    content: "#items_table",
    addItem: "#link_add_item",
    modal: {
      yes: "#modal_yes",
      no: "#modal_no",
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
      firstLink: "#items_table > tbody > tr:nth-child(1) > td:nth-child(1) > a",
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
  async navigateToItems() {
    await client.url(this.elements.link);
    return client.waitForElementVisible(
      this.elements.content,
      this.contentTimeOut
    );
  }

  async clickNameLink() {
    await client.waitForElementVisible(
      this.elements.content,
      this.contentTimeOut
    );
    await client.waitForElementVisible(this.elements.item.firstLink);
    return client.click(this.elements.item.firstLink);
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
}
