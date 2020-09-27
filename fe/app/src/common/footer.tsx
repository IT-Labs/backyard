import React from "react";
import logo from "./logo.svg";

class Footer extends React.Component {
  render() {
    return (
      <footer className="App-footer">
        <a
          className="App-link"
          href="https://www.it-labs.com/"
          target="_blank"
          id="itLabs"
          rel="noopener noreferrer"
          data-testid="itLabs"
        >
          <div id="logo_section" className="logo-section">
            <img id="logo" src={logo} className="App-logo" alt="logo" />
          </div>
        </a>
      </footer>
    );
  }
}

export default Footer;
