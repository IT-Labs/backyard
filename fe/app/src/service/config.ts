import { IAppConfig } from "./IAppConfig";

const host = "http://localhost:5000/";
 
  var appConfig: IAppConfig = Object.assign({});  
  if(process.env.REACT_APP_API_URL){
    appConfig.urlApi= process.env.REACT_APP_API_URL;
} 
 else{  
appConfig.urlApi= host;
}
console.info("env", process.env);
console.info("env.REACT_APP_API_URL", process.env.REACT_APP_API_URL);
console.info("app config", appConfig);
  export { appConfig };