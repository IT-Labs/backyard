import React from "react";
import { ReactKeycloakProvider } from "@react-keycloak/web";
import Keycloak, { KeycloakConfig } from "keycloak-js";
import "./common/common.css";
import "./App.css";
import Notfound from "./NotFound";
import { Route, Switch, BrowserRouter as Router } from "react-router-dom";
import About from "./about/About";

import { Dimmer, Header, Icon } from "semantic-ui-react";
import PrivateRoute from "./common/PrivateRoute";
import Navbar from "./common/Navbar";
import Home from "./home/Home";
import EditItem from "./item/Item";
import { appConfig } from "./service/config";

import { handleLogError } from "./common/Helpers";
import Items from "./item/Items";
import Footer from "./common/footer";

function App() {
  const keycloakConfig: KeycloakConfig = {
    url: `${appConfig.authApi}auth`,
    realm: appConfig.authRealm,
    clientId: appConfig.authClientId,
  };
  const keycloak = Keycloak(keycloakConfig);
  const initOptions = { pkceMethod: "S256" };

  const handleOnEvent = async (event: string, error: any) => {
    console.info("Event: " + event);
    if (event === "onAuthSuccess") {
      // if (keycloak.authenticated) {
      //   let response = await moviesApi.getUserExtrasMe(keycloak.token)
      //   if (response.status === 404) {
      //     const userExtra = { avatar: keycloak.tokenParsed.preferred_username }
      //     response = await moviesApi.saveUserExtrasMe(keycloak.token, userExtra)
      //     console.log('UserExtra created for ' + keycloak.tokenParsed.preferred_username)
      //   }
      //   keycloak['avatar'] = response.data.avatar
      // }
    }
    handleLogError(error);
  };

  const loadingComponent = (
    <Dimmer inverted active={true} page>
      <Header style={{ color: "#4d4d4d" }} as="h2" icon inverted>
        <Icon loading name="cog" />
        <Header.Content>
          Keycloak is loading
          <Header.Subheader style={{ color: "#4d4d4d" }}>
            or running authorization code flow with PKCE
          </Header.Subheader>
        </Header.Content>
      </Header>
    </Dimmer>
  );

  return (
    
    <ReactKeycloakProvider
      authClient={keycloak}
      initOptions={initOptions}
      LoadingComponent={loadingComponent}
      onEvent={(event, error) => handleOnEvent(event, error)}
    >
      <Header />
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
