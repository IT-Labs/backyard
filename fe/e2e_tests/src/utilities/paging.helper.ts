import { client } from 'nightwatch-api';
import { commonConstants } from './common-constants';

const nextPagingLink = 'li.pagination-page.active+li.pagination-page a';
const currentPagingLink = 'li.pagination-page.active a';
const loadMoreButton = '#loadMore';
const lazyLoadingLoader = '#lazyLoading';

export async function navigateToElement(selector: string, gridElementSelector: string) {
  return goToElement(selector, false, false, false, gridElementSelector);
}

export async function scrollToElement(
  selector: string,
  hasLoadMoreButton: boolean,
  waitForLoader: boolean
) {
  return goToElement(selector, true, hasLoadMoreButton, waitForLoader, '');
}

export async function goToElement(
  selector: string,
  hasLazyLoading: boolean,
  hasLoadMoreButton: boolean,
  waitForLoader: boolean,
  gridElementSelector: string
) {
  await client.waitForElementPresent(selector);
  let elementInPage = await elementExistsInCurrenPage(selector);
  if (elementInPage) {
    return;
  }
  let hasMore = hasLazyLoading ? await hasMoreToLoad() : await hasMorePages();

  if (!hasMore) {
    return;
  }

  hasLazyLoading
    ? await scrollToBottom(waitForLoader, hasLoadMoreButton)
    : await goToNextPage(gridElementSelector);

  return goToElement(
    selector,
    hasLazyLoading,
    waitForLoader,
    hasLoadMoreButton,
    gridElementSelector
  );
}

async function elementExistsInCurrenPage(selector: string): Promise<boolean> {
  let exists = false;
  await client.element('css selector', selector, function(result) {
    exists = !!result.value;
  });
  return exists;
}

//#region Lazy Loading
async function hasMoreToLoad(): Promise<boolean> {
  var hasAnyMorePages = true;
  await client.execute(
    function() {
      if (window.innerHeight + window.pageYOffset >= document.body.scrollHeight) {
        return false;
      } else {
        return true;
      }
    },
    [],
    result => {
      hasAnyMorePages = result.value;
    }
  );
  return hasAnyMorePages;
}

async function scrollToBottom(waitForLoader: boolean, hasLoadMoreButton: boolean): Promise<void> {
  await client.execute(function() {
    window.scrollTo(0, document.body.scrollHeight);
  });
  if (hasLoadMoreButton) {
    client.click(loadMoreButton);
  }
  if (waitForLoader) {
    client.waitForElementPresent(lazyLoadingLoader, 5000);
    client.waitForElementNotPresent(lazyLoadingLoader, 5000);
  }
  return;
}
//#endregion

//#region Paging
async function hasMorePages(): Promise<boolean> {
  var hasAnyMorePages = false;
  client.waitForElementPresent(currentPagingLink, 5000);
  await client.element('css selector', nextPagingLink, function(result) {
    hasAnyMorePages = !!result.value && !!result.value.ELEMENT;
  });
  return hasAnyMorePages;
}

async function goToNextPage(gridElementSelector: string): Promise<void> {
  client.click(nextPagingLink);
  if (gridElementSelector == '') {
    return;
  }
  return client.waitForElementPresent(gridElementSelector, commonConstants.maxWaitTimeConstant);
}
//#endregion
