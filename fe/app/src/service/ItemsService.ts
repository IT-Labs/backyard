import { appConfig } from "./config";

class ItemsService {
    private readonly itemUrl = appConfig.urlApi+"items";
  async get(){
   
    try {     
        const itemApiCall = await fetch(this.itemUrl);
        return await itemApiCall.json();
       
      } catch (err) {
          //TODO handle error on UI
        console.log("Error fetching data", err);
      }
      return  [];
   }
   
  }
  
  export default ItemsService;