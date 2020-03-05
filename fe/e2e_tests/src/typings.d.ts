import * as nightwatchCucumber from 'nightwatch-api';
import * as nightwatch from 'nightwatch';

declare module 'nightwatch-api' {
  export const client: nightwatch.NightwatchBrowser;
  export function startWebDriver(env?: string): Promise<void>;
  export function stopWebDriver(): Promise<void>;
  export function createSession(env?: string): Promise<nightwatch.NightwatchAPI>;
  export function closeSession(): Promise<void>;
  export function runQueue(): Promise<void>;

  export interface Client extends nightwatch.NightwatchBrowser {
    startSession: Function;
  }
}
