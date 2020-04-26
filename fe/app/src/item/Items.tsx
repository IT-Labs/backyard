import React from "react";
import "./Item.css";
import Table from "react-bootstrap/Table";
import { Route, Link, Switch } from "react-router-dom";
import ViewItem from "./ViewItem";
import ItemsService from "../service/ItemService";

class Items extends React.Component {
  state = {
    items: [],
    loading: true,
  };
  itemsService = new ItemsService();
  async componentDidMount() {
    const data = await this.itemsService.get();
    this.setState({ items: data.content, loading: false });
  }

  renderTableData(items: Array<any>) {
    return items.map((item, index) => {
      return (
        <tr key={item.id}>
          <td>
            {" "}
            <Link to={{ pathname: `/items/${item.id}` }}>{item.id}</Link>{" "}
          </td>
          <td>{item.name}</td>
          <td>{item.status}</td>
          <td>{item.description}</td>
        </tr>
      );
    });
  }
  render() {
    const { items, loading } = this.state;

    if (loading) {
      return <div>Loading Items</div>;
    }
    return (
      <div className="item">
        <header className="item-header">Items</header>
        <div>
          <Table
            striped
            bordered
            hover
            variant="dark"
            id="items_table"
            data-testid="items_table"
          >
            <thead>
              <tr>
                <th>#</th>
                <th> Name</th>
                <th>Status</th>
                <th>Description</th>
              </tr>
            </thead>
            <tbody>{this.renderTableData(items)}</tbody>
          </Table>
        </div>
        <Switch>
          <Route path="/items/:id" exact component={ViewItem} />
        </Switch>
      </div>
    );
  }
}

export default Items;
