import React from "react";
import logo from "./logo.svg";
import "./App.css";

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <img id="logo" src={logo} className="App-logo" alt="logo" />

        <p>Home Page</p>
        <a
          className="App-link"
          href="https://www.it-labs.com/"
          target="_blank"
          id="itLabs"
          rel="It Labs"
        >
          It Labs
        </a>
      </header>
    </div>
  );
}

export default App;
