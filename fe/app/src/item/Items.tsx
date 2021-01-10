import React, { useMemo } from "react";
import { useState, useEffect } from "react";
import "./Item.css";

import { Link } from "react-router-dom";
import ItemsService, { Item } from "../service/ItemsService";
import { useKeycloak } from "@react-keycloak/web";
import { Button, Image, Table } from "semantic-ui-react";
export interface EditItemModel {
  nameError: string;
  descriptionError: string;
  statusError: string;
  publicError: string;
  public: boolean;
  id: string;
  name: string;
  description: string;
  status: string;
}
const Items: React.FunctionComponent = () => {
  const itemsService = useMemo<ItemsService>(() => new ItemsService(), []);
  const [items, setData] = useState<Item[]>([]);
  const [loading, setLoading] = useState(true);
  const [message, setMessage] = useState("");
  const { keycloak } = useKeycloak();
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
  useEffect(() => {   
    getItems();
  }, [keycloak]);


  if (loading) {
    return <div>Loading Items</div>;
  }
  if (message) {
    return <div>{message}</div>;
  }

  
  
const handleDeleteItem =(item:Item)=>{
itemsService.deleteById(item.id,keycloak.token?keycloak.token:"");
getItems();
}


  const height = window.innerHeight - 100;

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
            <Link to={{ pathname: `/item/${item.id}` }}>{item.id}</Link>           
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
          <Table.Cell>{item.public ? "True" : "False"}</Table.Cell>
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
      <Link to={{ pathname: `/item/` }}>Add</Link>
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
