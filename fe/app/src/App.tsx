import React from "react";
import { ReactKeycloakProvider } from "@react-keycloak/web";
import Keycloak, { KeycloakConfig } from "keycloak-js";
import { Route, Switch, BrowserRouter as Router } from "react-router-dom";
import { Dimmer, Header, Icon } from "semantic-ui-react";
import PrivateRoute from "./common/PrivateRoute";
import Navbar from "./common/Navbar";
import { handleLog } from "./common/Helpers";
import Home from "./home/Home";
import EditItem from "./item/Item";
import { appConfig } from "./service/config";
import About from "./about/About";
import Items from "./item/Items";
import Footer from "./common/footer";
import Notfound from "./NotFound";
import "./common/common.css";
import "./App.css";

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
      <Router>
        <Navbar />
        <Switch>
          <Route path="/" exact component={Home} />
          <Route path="/home" component={Home} />
          <Route path="/about" component={About} />
          <PrivateRoute path="/items" component={Items} />
          <PrivateRoute path="/items/:id" component={EditItem} />
          <Route component={Notfound} />
        </Switch>
      </Router>
      <Footer />
    </ReactKeycloakProvider>
  );
}

export default App;
