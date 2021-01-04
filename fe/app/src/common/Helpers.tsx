import { appConfig } from "../service/config";

export const getAvatarUrl = (text: string) => {
  return `${appConfig.avatarUrl}/avataaars/${text}.svg`;
};

export const isAdmin = (keycloak: any) => {
  return (
    keycloak && keycloak.tokenParsed
    // &&
    // keycloak.tokenParsed.resource_access["sample-client"].roles.includes(
    //   "USER"
    // )
  );
};

export const handleLog = (data: any) => {
  if (!data) {
    console.log("Noting");
    return;
  }
  if (data.response) {
    console.log(data.response.data);
    return;
  }
  if (data.request) {
    console.log(data.request);
    return;
  }
  if (data.message) {
    console.log(data.message);
    return;
  }
  console.log(data);
};
