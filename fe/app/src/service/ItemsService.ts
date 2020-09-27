import { appConfig } from "./config";

class ItemsService {
  private readonly itemUrl = appConfig.urlApi + "items";
  async get() {
    const itemApiCall = await fetch(this.itemUrl);
    if (!itemApiCall.ok) {
      throw Error("something went wrong");
    }

    if (itemApiCall.headers.has("fallback")) {
      throw Error(await itemApiCall.json().then((res) => res.message));
    }
    return itemApiCall.json();
  }
}

export default ItemsService;
