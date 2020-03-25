import React from "react";
import "./Item.css";
import { Route, Link, Switch } from "react-router-dom";

class EditItem extends React.Component {
  render() {
    console.log(this.props);
    return (
      <div className="item">
        <header className="item-header">Item</header>
        <div><Link to="/items">Back</Link></div>
        <div>
          <input></input>
        </div>
      </div>
    );
  }
}

export  default EditItem;

