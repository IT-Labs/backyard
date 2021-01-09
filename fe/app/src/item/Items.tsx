import React from "react";
import { useState, useEffect } from "react";
import "./Item.css";

import { Route, Link, Switch } from "react-router-dom";
import ViewItem from "./ViewItem";
import ItemsService, { Item } from "../service/ItemsService";
import { useKeycloak } from "@react-keycloak/web";
import { Button, Checkbox, Image, Table } from "semantic-ui-react";
export interface EditItemModel {
  public: boolean;
  id: string;
  name: string;
  description: string;
  status: string;
}
const Items: React.FunctionComponent = () => {
  const [items, setData] = useState<Item[]>([]);
  const [loading, setLoading] = useState(true);
  const [message, setMessage] = useState("");
  const { keycloak } = useKeycloak();
  useEffect(() => {
    const getItems = async () => {
      try {
        let itemsService = new ItemsService();
        const data = await itemsService.get(
          keycloak.token ? keycloak.token : "token is missing "
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

  // const renderTableData = (items: Array<any>) => {
  //   return items.map((item, index) => {
  //     return (
  //       <tr key={item.id}>

  //         <td>
  //           {" "}
  //           <Link to={{ pathname: `/items/${item.id}` }}>{item.id}</Link>{" "}
  //         </td>
  //         <td>{item.name}</td>
  //         <td>{item.status}</td>
  //         <td>{item.description}</td>
  //       </tr>
  //     );
  //   });
  // };

  if (loading) {
    return <div>Loading Items</div>;
  }
  if (message) {
    return <div>{message}</div>;
  }

  //  return (
  //     <div className="item">
  //       <header className="item-header">Items</header>
  //       <div>
  //         <Table
  //           striped
  //           bordered
  //           hover
  //           variant="dark"
  //           id="items_table"
  //           data-testid="items_table"
  //         >
  //           <thead>
  //             <tr>
  //               <th>#</th>
  //               <th> Name</th>
  //               <th>Status</th>
  //               <th>Description</th>
  //             </tr>
  //           </thead>
  //           <tbody>{renderTableData(items)}</tbody>
  //         </Table>
  //       </div>
  //       <Switch>
  //         <Route path="/items/:id" exact component={ViewItem} />
  //       </Switch>
  //     </div>
  //  );
const handleDeleteItem =(item:Item)=>{

}

const handleEditItem = (item: Item) => {
  
};
  const height = window.innerHeight - 100;
  const style = {
    height: height,
    maxHeight: height,
    overflowY: "auto",
    overflowX: "hidden",
  };

  const itemsList =
    items &&
    items.map((item) => {
      return (
        <Table.Row key={item.id}>
          <Table.Cell collapsing>
            <Button
              circular
              color="red"
              size="small"
              icon="trash"
                 onClick={() => handleDeleteItem(item)}
            />
            <Button
              circular
              color="orange"
              size="small"
              icon="edit"
                onClick={() => handleEditItem(item)}
            />
          </Table.Cell>
          <Table.Cell>{item.id}</Table.Cell>
          <Table.Cell>{item.name}</Table.Cell>
          <Table.Cell>{item.description}</Table.Cell>
          <Table.Cell>
            {item.published
              ? new Date(item.published).toLocaleDateString()
              : "NA"}
          </Table.Cell>
          <Table.Cell>{item.status}</Table.Cell>
          <Table.Cell>{item.public?"True":"False"}</Table.Cell>
          <Table.Cell>
            <Image
              size="tiny"
              src={`https://picsum.photos/seed/${item.id}/50/80`}
              rounded
            />
          </Table.Cell>
        </Table.Row>
      );
    });

  return (
    <div //style={style}
    >
      <Table compact striped>
        <Table.Header>
          <Table.Row>
            <Table.HeaderCell width={2} />
            <Table.HeaderCell width={2}>ID</Table.HeaderCell>
            <Table.HeaderCell width={4}>Name</Table.HeaderCell>
            <Table.HeaderCell width={3}>Description</Table.HeaderCell>
            <Table.HeaderCell width={2}>Published</Table.HeaderCell>
            <Table.HeaderCell width={1}>Status</Table.HeaderCell>
            <Table.HeaderCell width={1}>Is public</Table.HeaderCell>
            <Table.HeaderCell width={1}>Poster</Table.HeaderCell>
          </Table.Row>
        </Table.Header>
        <Table.Body>{itemsList}</Table.Body>
      </Table>
    </div>
  );
};

export default Items;
