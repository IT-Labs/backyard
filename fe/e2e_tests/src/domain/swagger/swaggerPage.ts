import { client } from "nightwatch-api";
import { appConfig } from "../../config";
export class SwaggerPage {
  elements = {
    info: ".info",
    version: "",
    productsLink: "#operations-tag-product-controller",
    productActionPrefix:'#operations-product-controller',
  };
  async navigateToSwagger() {
   
    const url = appConfig.url_api + "/swagger-ui.html";
    console.log(`naigate to ${url}`)
    await client.url(url);
    return client.waitForElementVisible(this.elements.info, 500);
  }

  openProductsTab() {
   return client.click(this.elements.productsLink);
  } 

  async verify(action: string,method: string) {
    let element = this.getSwaggerLink(this.elements.productActionPrefix,action,method);
    console.log(`Link present '${element}'`)
    return client.assert.elementPresent(element);
  }
  
  private getSwaggerLink(controller: string,action: string,method: string):string {
    return controller.concat("-",method,"Using",action.toUpperCase())};
 
}
