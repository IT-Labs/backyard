import { client } from 'nightwatch-api';
import { commonConstants } from './common-constants';

export async function ng2chooseTypeaheadValue(
  valueToFilter: string,
  valueToSelect: string,
  typeaheadSelector: string
) {
  await client.waitForElementVisible(`${typeaheadSelector} input`, 500);
  await client.clearValue(`${typeaheadSelector} input`);
  await client.click(`${typeaheadSelector} input`);
  await client.keys([valueToFilter]);
  await client.waitForElementVisible(
    `${typeaheadSelector} ul.dropdown-menu`,
    commonConstants.maxWaitTimeConstant
  );
  let optionSelector = `(//*[@id="${typeaheadSelector.replace(
    '#',
    ''
  )}"]//*[text()="${valueToSelect}"])[1]`;
  await client
    .useXpath()
    .waitForElementVisible(optionSelector, commonConstants.maxWaitTimeConstant);

  return await client.click(optionSelector).useCss();
}
