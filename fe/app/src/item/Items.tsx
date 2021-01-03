import React from "react";
import { useState, useEffect } from "react";
import "./Item.css";
import Table from "react-bootstrap/Table";
import { Route, Link, Switch } from "react-router-dom";
import ViewItem from "./ViewItem";
import ItemsService from "../service/ItemsService";
import { useKeycloak } from "@react-keycloak/web";

const Items: React.FunctionComponent = () => {
  const [items, setData] = useState([]);
  const [loading, setLoading] = useState(true);
  const [message, setMessage] = useState("");
  const { keycloak } = useKeycloak();
  useEffect(() => {
    const getItems = async () => {
      try {
        let itemsService = new ItemsService();
        const data = await itemsService.get(
          keycloak.token ? keycloak.token : "token missing "
        );
        setData(data.content);
        setLoading(false);
      } catch (error) {
        setData([]);
        setLoading(false);
        setMessage(error.message);
      }
    };
    getItems();
  }, [keycloak]);  

  const renderTableData = (items: Array<any>) => {
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
  };

  if (loading) {
    return <div>Loading Items</div>;
  }
  if (message) {
    return <div>{message}</div>;
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
          <tbody>{renderTableData(items)}</tbody>
        </Table>
      </div>
      <Switch>
        <Route path="/items/:id" exact component={ViewItem} />
      </Switch>
    </div>
  );
};

export default Items;
