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
