import { client } from 'nightwatch-api';

export async function selectUserFromAutocomplete(
  valueToFilter: string,
  typeaheadSelector: string
): Promise<void> {
  await client.waitForElementVisible(`${typeaheadSelector} input`);
  await client.click(`${typeaheadSelector} input`);
  await client.keys([valueToFilter]);
  await client.waitForElementVisible(`${typeaheadSelector} ul.dropdown-menu`);
  let optionSelector = `//*[@id="${typeaheadSelector.replace(
    '#',
    ''
  )}"]//span[contains(text(),"${valueToFilter}")]`;
  client.useXpath();
  await client.waitForElementVisible(optionSelector);
  client.useXpath();
  await client.click(optionSelector);
  client.useCss();
}
