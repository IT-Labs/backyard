export interface IAppConfig { 
  /**
   * Url should ALWAYS end with slash `/`
   */
  url: string;
  url_api: string;
  saucelabs: { username: string; accessKey: string };
  browserstack: { username: string; accessKey: string }; 
}
export interface IEmailConfig {
  prepend: string;
  domain: string;
  password: string;
}


