import { client } from 'nightwatch-api';

export async function selectValueFromDropdown(valueToSelect: string, selector: string) {
  await client
    .useXpath()
    .waitForElementVisible(`//*[@id="${selector.replace('#', '')}"]//select`)
    .useCss();
  await client
    .useXpath()
    .click(`//*[@id="${selector.replace('#', '')}"]//select`)
    .useCss();
  await client
    .useXpath()
    .waitForElementVisible(`//option[text()="${valueToSelect}"]`)
    .useCss();
  return await client
    .useXpath()
    .click(`//option[text()="${valueToSelect}"]`)
    .useCss();
}
