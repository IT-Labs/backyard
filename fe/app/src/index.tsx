import React from "react";
import ReactDOM from "react-dom";
import { Route, Switch, Link, BrowserRouter as Router } from "react-router-dom";
import "./index.css";
import App from "./App";
import * as serviceWorker from "./serviceWorker";
import "bootstrap/dist/css/bootstrap.min.css";
import Items from "./item/Items";
import Notfound from "./NotFound";
import About from "./about/About";
const routing = (
  <Router>
    <div>
      <Link to="/" id="home_nav" className="nav-link">
        Home
      </Link>

      <Link to="/items" id="items_nav" className="nav-link">
        Items
      </Link>

      <Link to="/about" id="items_about" className="nav-link">
        About
      </Link>

      <Switch>
        <Route path="/" exact component={App} />
        <Route path="/items" component={Items} />
        <Route path="/about" component={About} />
        <Route component={Notfound} />
      </Switch>
    </div>
  </Router>
);
ReactDOM.render(routing, document.getElementById("root"));

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();
