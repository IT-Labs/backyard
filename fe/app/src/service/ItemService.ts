const host = "http://localhost:5000/api/v1/";
//TODO : get host and api version from configuration
class ItemService {
    private readonly itemUrl = host+"item/";
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
  
  export default ItemService;