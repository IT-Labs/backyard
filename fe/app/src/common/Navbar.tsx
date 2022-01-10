import { useKeycloak } from "@react-keycloak/web";
import { NavLink, useNavigate } from "react-router-dom";
import { Container, Dropdown, Menu } from "semantic-ui-react";
import { handleLog, isAdmin } from "./Helpers";
import { useState, useEffect } from "react";
import { KeycloakProfile } from "keycloak-js";
import { ToastContainer } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";
function Navbar() {
  const { keycloak } = useKeycloak();
  const [profile, setProfile] = useState<KeycloakProfile>({});
  const navigate = useNavigate();
  const handleLogInOut = () => {
    if (keycloak.authenticated) {
      keycloak.logout();
      navigate("/");
    } else {
      keycloak.login();
    }
  };

  const checkAuthenticated = () => {
    if (!keycloak.authenticated) {
      handleLogInOut();
    }
  };

  const getUsername = () => {
    //TODO: extend d.ts to get from token the preferred_username
    return keycloak.authenticated && profile.username;
  };

  useEffect(() => {
    if (!keycloak.profile) {
      keycloak.loadUserProfile().then((profile) => {
        handleLog("Profile loaded" + profile);
        keycloak.profile = profile;
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
        <Menu.Item id="nav_home" as={NavLink} to="/home">
          Home
        </Menu.Item>

        <Dropdown id="nav_admin" item text="Admin" style={getAdminMenuStyle()}>
          <Dropdown.Menu>
            <Dropdown.Item
              as={NavLink}
              id="nav_items"
              to="/items"
              onClick={checkAuthenticated}
            >
              items
            </Dropdown.Item>
          </Dropdown.Menu>
        </Dropdown>
        <Menu.Item id="nav_about" as={NavLink} to="/about">
          About
        </Menu.Item>
        <Menu.Menu position="right">
          {keycloak.authenticated && (
            <Dropdown
              text={`Hi ${getUsername()}`}
              pointing
              className="link item"
              id="nav_username"
            >
              <Dropdown.Menu>
                <Dropdown.Item id="nav_settings" as={NavLink} to="/settings">
                  Settings
                </Dropdown.Item>
              </Dropdown.Menu>
            </Dropdown>
          )}
          <Menu.Item
            as={NavLink}
            id="nav_login"
            to="/login"
            onClick={handleLogInOut}
          >
            {getLogInOutText()}
          </Menu.Item>
        </Menu.Menu>
        <ToastContainer />
      </Container>
    </Menu>
  );
}
export default Navbar;
