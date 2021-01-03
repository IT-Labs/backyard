import { appConfig } from "./config";

class ItemsService {
  private readonly itemUrl = appConfig.urlApi + "items";

  async get(token:string) {
       const itemApiCall = await fetch(this.itemUrl,{
      headers:{
        'Accept': 'application/json',
        'Authorization': 'bearer ' + token,
      }
    });
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
