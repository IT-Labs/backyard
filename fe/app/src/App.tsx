import React from "react";
import logo from "./logo.svg";
import "./App.css";

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <p>Home Page</p>
        <a
          className="App-link"
          href="https://www.it-labs.com/"
          target="_blank"
          id="itLabs"
          rel="noopener noreferrer"
          data-testid="itLabs"
        >
          It Labs
        </a>
      </header>
      <div id="logo_section" className="logo-section">
        <img id="logo" src={logo} className="App-logo" alt="logo" />
      </div>
    </div>
  );
}

export default App;
