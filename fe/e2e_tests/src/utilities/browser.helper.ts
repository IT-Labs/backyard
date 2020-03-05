interface _WebElemJson {
  sessionId: string;
  status: number;
  value: { ELEMENT?: number; message?: string };
  errorStatus?: number;
  error?: string;
}

async function ifElementIsPresent(browser, _sel): Promise<boolean> {
  var res: any = await helper(browser, _sel);
  return res && res.status > -1;
}

function helper(browser, _sel): Promise<_WebElemJson> {
  return new Promise(function(resolve, reject) {
    browser.api.element('css selector', _sel, function(res: _WebElemJson) {
      resolve(res);
    });
  });
}

export { ifElementIsPresent };
