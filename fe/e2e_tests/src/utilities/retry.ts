const log = require('debug')('app:utils:retry');
function delay(ms: number): Promise<any> {
  log(`delaying for ${ms}ms`);
  if (ms <= 0) {
    return Promise.resolve();
  }
  return new Promise(resolve => setTimeout(resolve, ms));
}

function singleRetry(
  singleRunFunc: () => Promise<any>,
  retries: number,
  current: number,
  delayMsBetweenRetry: number
): Promise<any> {
  return singleRunFunc().catch(err => {
    if (current > retries) {
      return Promise.reject(err);
    }

    ++current;
    log(`retry #${current}`);
    return delay(Math.pow(current, 1.6) * delayMsBetweenRetry).then(() =>
      singleRetry(singleRunFunc, retries, current, delayMsBetweenRetry)
    );
  });
}

export function retry<T>(
  func: () => Promise<T>,
  retries: number,
  delayMsBetweenRetry?: number
): Promise<T> {
  return singleRetry(func, retries, 0, delayMsBetweenRetry);
}
