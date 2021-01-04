import React from "react";
import { useKeycloak } from "@react-keycloak/web";
import { NavLink, withRouter } from "react-router-dom";
import { Container, Dropdown, Menu } from "semantic-ui-react";
import { isAdmin } from "./Helpers";
import { useState, useEffect } from "react";
import { KeycloakProfile } from "keycloak-js";
function Navbar(props: any) {
  const { keycloak } = useKeycloak();
  const [profile, setProfile] = useState<KeycloakProfile>({});
  const handleLogInOut = () => {
    if (keycloak.authenticated) {
      props.history.push("/");
      keycloak.logout();
    } else {
      keycloak.login();
    }
  };

  const checkAuthenticated = () => {
    if (!keycloak.authenticated) {
      handleLogInOut();
    }
  };

  const getUsername =  () => {

    //TODO: extend d.ts to get from token the preferred_username
    return (
      keycloak.authenticated && profile.username
    );
  };

  useEffect(() => {
    if (!keycloak.profile) {
      keycloak.loadUserProfile()
      .then(profile=>{ 
        console.log("Profile loaded"+profile);
        keycloak.profile= profile;
        setProfile(profile);
      });     
  }
  }, [keycloak]);  

  const getLogInOutText = () => {
    return keycloak.authenticated ? "Logout" : "Login";
  };

  const getAdminMenuStyle = () => {
    return keycloak.authenticated && isAdmin(keycloak)
      ? { display: "block" }
      : { display: "none" };
  };

  return (
    <Menu stackable>
      <Container>
       <Menu.Item as={NavLink} exact to="/home">
          Home
        </Menu.Item>
        
        <Dropdown item text="Admin" style={getAdminMenuStyle()}>
          <Dropdown.Menu>
            <Dropdown.Item
              as={NavLink}
              exact
              to="/items"
              onClick={checkAuthenticated}
            >
              items
            </Dropdown.Item>
          </Dropdown.Menu>
       
        </Dropdown>
        <Menu.Item as={NavLink} exact to="/about">
          About
        </Menu.Item>
        <Menu.Menu position="right">
          {keycloak.authenticated && (
            <Dropdown
              text={`Hi ${getUsername()}`}
              pointing
              className="link item"
            >
              <Dropdown.Menu>
                <Dropdown.Item as={NavLink} to="/settings">
                  Settings
                </Dropdown.Item>
              </Dropdown.Menu>
            </Dropdown>
          )}
          <Menu.Item as={NavLink}  id="login" exact to="/login" onClick={handleLogInOut}>
            {getLogInOutText()}
          </Menu.Item>
        </Menu.Menu>
      </Container>
    </Menu>
  );
}

export default withRouter(Navbar);
