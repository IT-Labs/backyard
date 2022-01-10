import React from "react";
import { ReactKeycloakProvider } from "@react-keycloak/web";
import Keycloak, { KeycloakConfig } from "keycloak-js";
import { Route, Routes, BrowserRouter as Router, BrowserRouter } from "react-router-dom";
import { Dimmer, Header, Icon } from "semantic-ui-react";
import PrivateRoute from "./common/PrivateRoute";
import Navbar from "./common/Navbar";
import { handleLog } from "./common/Helpers";
import Home from "./home/Home";
import { appConfig } from "./service/config";
import About from "./about/About";
import Items from "./item/Items";
import Footer from "./common/footer";
import Notfound from "./NotFound";
import "./common/common.css";
import "./App.css";
import ItemForm from "./item/ItemForm";

function App() {
  const keycloakConfig: KeycloakConfig = {
    url: `${appConfig.authApi}auth`,
    realm: appConfig.authRealm,
    clientId: appConfig.authClientId,
  };
  const keycloak = Keycloak(keycloakConfig);


  const handleOnEvent = async (event: string, error: any) => {
    handleLog("Event: " + event);
    if (event !== "onAuthSuccess") {
      handleLog(error);
      return;
    }
    if (!keycloak.authenticated) {
      return;
    }
    if (keycloak.profile) {
      return;
    }
    handleLog("Profile not found");
  };

  const loadingComponent = (
    <Dimmer inverted active={true} page>
      <Header style={{ color: "#4d5c4d" }} as="h1" icon inverted>
        <Icon loading name="cog" />
        <Header.Content>
          Auth is loading
         </Header.Content>
      </Header>
    </Dimmer>
  );
  const initOptions = { pkceMethod: "S256" };
  return (
    <ReactKeycloakProvider
      authClient={keycloak}
      initOptions={initOptions}
      LoadingComponent={loadingComponent}
      onEvent={(event, error) => handleOnEvent(event, error)}
    >
      <BrowserRouter>
        <Navbar />

        <Routes>
          <Route path="/" element={Home} />
          <Route path="/home" element={Home} />
          <Route path="/about" element={About} />
          <Route
            path="/items"
            element={<PrivateRoute component={Items} />}
          />
          <Route
            path="/item/:id"
            element={<PrivateRoute component={ItemForm} />}
          />
          <Route
            path="/item/"
            element={<PrivateRoute component={ItemForm} />}
          />
          <Route element={Notfound} />
        </Routes>
      </BrowserRouter>
      <Footer />
    </ReactKeycloakProvider>
  );
}

export default App;
