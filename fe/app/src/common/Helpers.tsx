import { appConfig } from "../service/config";


export const getAvatarUrl = (text:string) => {
  return `${appConfig.avatarUrl}/avataaars/${text}.svg`
}

export const isAdmin = (keycloak:any) => {
  return (
    keycloak &&
    keycloak.tokenParsed 
    // &&
    // keycloak.tokenParsed.resource_access["sample-client"].roles.includes(
    //   "ADMIN"
    // )
  );
};

export const handleLogError = (error:any) => {
  if(error){  if (error.response) {
    console.log(error.response.data);
  } else if (error.request) {
    console.log(error.request);
  } else {
    console.log(error.message);
  }}else{ console.log("Noting")}
};
