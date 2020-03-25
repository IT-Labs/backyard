import React from "react";
import { Link } from "react-router-dom";
export class ViewItem extends React.Component {
  render() {
    console.log(this.props);
    return (
      <div className="item">
        <header className="item-header">Item</header>
        <div>
          <Link to="/items">Back</Link>
        </div>
        <div>
          <input></input>
        </div>
      </div>
    );
  }
}
export default ViewItem;
