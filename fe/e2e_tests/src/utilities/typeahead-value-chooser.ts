import { client } from 'nightwatch-api';

export async function chooseTypeaheadValue(
  valueToFilter: string,
  valueToSelect: string,
  typeaheadSelector: string
): Promise<void> {
  await client.click(`${typeaheadSelector} input[uib-typeahead]`);
  await client.keys([valueToFilter]);
  await client.waitForElementVisible(`${typeaheadSelector} ul.dropdown-menu`);
  let optionSelector = `//*[@id="${typeaheadSelector.replace(
    '#',
    ''
  )}"]//strong[text()="${valueToSelect}"]`;
  client.useXpath();
  await client.waitForElementVisible(optionSelector);
  client.useXpath();
  await client.click(optionSelector);
  client.useCss();
}
