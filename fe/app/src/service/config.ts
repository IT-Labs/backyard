import { IAppConfig } from "./IAppConfig";

const host = "http://localhost:5000/";
const apiVersion = "api/v1/";
 
  var appConfig: IAppConfig = Object.assign({});
  
  if(process.env.API_URL){
    appConfig.urlApi= process.env.API_URL +apiVersion;
}  else{  
appConfig.urlApi= host +apiVersion;
}
console.info("env", process.env);
console.info("env.API_URL", process.env.API_URL);
console.info("app config", appConfig);
  export { appConfig };