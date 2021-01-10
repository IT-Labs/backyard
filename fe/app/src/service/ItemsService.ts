import { EditItemModel } from "../item/Items";
import { appConfig } from "./config";
export interface Item {
  public: boolean;
  id: string;
  name: string;
  description: string;
  status: string;
  published: Date;
}
class ItemsService {
  private readonly itemUrl = appConfig.urlApi + "items";
  private readonly itemPublicUrl = appConfig.urlApi + "home/items";
  async saveItem(id: string, data: EditItemModel, token: string) {
    let method = id ? "PUT" : "POST";
    let route = id ? this.itemUrl + "/" + id : this.itemUrl;
    const itemApiCall = await fetch(route, {
      headers: {
        Accept: "application/json",
       "Content-Type": "application/json",
        Authorization: "bearer " + token,
      },
      body: JSON.stringify(data),
      method: method,
    });
    if (!itemApiCall.ok) {
      throw Error("something went wrong saving items");
    }

    if (itemApiCall.headers.has("fallback")) {
      throw Error(await itemApiCall.json().then((res) => res.message));
    }
    return itemApiCall.json();
  }
  async deleteById(id: string, token: string) {
    const itemApiCall = await fetch(this.itemUrl + "/" + id, {
      headers: {
        Accept: "application/json",
        Authorization: "bearer " + token,
      },
      method:'DELETE'
    });
    if (!itemApiCall.ok) {
      throw Error("something went wrong deleting items");
    }

    if (itemApiCall.headers.has("fallback")) {
      throw Error(await itemApiCall.json().then((res) => res.message));
    }
    return itemApiCall.json();
  }
  async getById(id: string, token: string) {
    const itemApiCall = await fetch(this.itemUrl + "/" + id, {
      headers: {
        Accept: "application/json",
        Authorization: "bearer " + token,
      },
    });
    if (!itemApiCall.ok) {
      throw Error("something went wrong getting items");
    }

    if (itemApiCall.headers.has("fallback")) {
      throw Error(await itemApiCall.json().then((res) => res.message));
    }
    return itemApiCall.json();
  }
  async get(token: string) {
    const itemApiCall = await fetch(this.itemUrl, {
      headers: {
        Accept: "application/json",
        Authorization: "bearer " + token,
      },
    });
    if (!itemApiCall.ok) {
      throw Error("something went wrong getting items");
    }

    if (itemApiCall.headers.has("fallback")) {
      throw Error(await itemApiCall.json().then((res) => res.message));
    }
    return itemApiCall.json();
  }
  async getPublic() {
    const itemApiCall = await fetch(this.itemPublicUrl);
    if (!itemApiCall.ok) {
      throw Error("something went wrong getting public items");
    }

    if (itemApiCall.headers.has("fallback")) {
      throw Error(await itemApiCall.json().then((res) => res.message));
    }
    return itemApiCall.json();
  }
}

export default ItemsService;
