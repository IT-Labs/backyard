export interface IAppConfig { 
  /**
   * Url should ALWAYS end with slash `/`
   */
  url: string;
  urlApi: string;
}
export interface IEmailConfig {
  prepend: string;
  domain: string;
  password: string;
}


