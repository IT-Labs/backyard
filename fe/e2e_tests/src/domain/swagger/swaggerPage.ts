import { client } from "nightwatch-api";
import { appConfig } from "../../config";
export class SwaggerPage {
  elements = {
    info: ".info",
    version: "",
    link: "#operations-tag-gateway-controller-endpoint",
    actionPrefix: "#operations-gateway-controller-endpoint-globalfilters",
  };
  async navigateToSwagger() {
    const url = appConfig.urlApi + "/swagger-ui/";
    console.log(`navigate to ${url}`);
    await client.url(url);
    return client.waitForElementVisible(this.elements.info, 500);
  }

  openItemTab() {
    return client.click(this.elements.link);
  }

  async verify(action: string, method: string) {
    let element = this.getSwaggerLink(
      this.elements.actionPrefix,
      action,
      method
    );
    console.log(`Link present '${element}'`);
    return client.assert.elementPresent(element);
  }

  private getSwaggerLink(
    controller: string,
    action: string,
    method: string
  ): string {
    return controller.concat("-", method, "Using", action.toUpperCase());
  }
}
