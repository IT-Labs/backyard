import { IAppConfig } from "./IAppConfig";

const host = "http://localhost:5000/";
const apiVersion = "api/v1/";
 
  var appConfig: IAppConfig = Object.assign({});
  
  if(process.env.REACT_APP_API_URL){
    appConfig.urlApi= process.env.REACT_APP_API_URL +apiVersion;
}  else{  
appConfig.urlApi= host +apiVersion;
}
console.info("env", process.env);
console.info("env.REACT_APP_API_URL", process.env.REACT_APP_API_URL);
console.info("app config", appConfig);
  export { appConfig };