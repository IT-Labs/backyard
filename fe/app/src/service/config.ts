import { IAppConfig } from "./IAppConfig";
var appConfig: IAppConfig = Object.assign({});

appConfig.urlApi = !process.env.REACT_APP_API_URL
  ? "http://localhost:5000/"
  : process.env.REACT_APP_API_URL;

appConfig.authApi = !process.env.REACT_APP_AUTH_URL
  ? "http://localhost:6180/"
  : process.env.REACT_APP_AUTH_URL;

appConfig.authRealm = !process.env.REACT_APP_AUTH_REALM
  ? "realm-sample"
  : process.env.REACT_APP_AUTH_REALM;

appConfig.authClientId = !process.env.REACT_APP_AUTH_CLIENT_ID
  ? "sample-client"
  : process.env.REACT_APP_AUTH_CLIENT_ID;

console.info("env", process.env);
console.info("app config", appConfig);
export { appConfig };
