import React from "react";
import { Link } from "react-router-dom";

class Header extends React.Component {
  render() {
    return (
      <ul>
        <li>
          <Link to="/" id="home_nav" className="nav-link">
            Home
          </Link>
        </li>
        <li>
          {" "}
          <Link to="/items" id="items_nav" className="nav-link">
            Items
          </Link>
        </li>
        <li>
          <Link to="/about" id="items_about" className="nav-link">
            About
          </Link>
        </li>
      </ul>
    );
  }
}

export default Header;
