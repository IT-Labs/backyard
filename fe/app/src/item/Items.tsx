import React, { CSSProperties } from "react";
import { useState, useEffect } from "react";
import "./Item.css";

import { Link } from "react-router-dom";

import { Item } from "../service/Item";
import { useKeycloak } from "@react-keycloak/web";
import { Button, Image, Table } from "semantic-ui-react";
import { ItemsService } from "../service/ItemsService";
import { toast } from "react-toastify";
import ConfirmationModal, { IModalProps } from "../common/ConfirmationModal";
export interface EditItemModel {
  nameError: string;
  descriptionError: string;
  statusError: string;
  publicError: string;
  publiclyAvailable: boolean;
  id: string;
  name: string;
  description: string;
  status: string;
}
const Items: React.FunctionComponent = () => {
  const [modalData, setModal] = useState<IModalProps>({
    isOpen: false,
    header: "",
    content: "",
    onAction: null,
    onClose: null,
    id: "",
  });
  const [items, setData] = useState<Item[]>([]);

  const [loading, setLoading] = useState(true);
  const [message, setMessage] = useState("");
  const { keycloak } = useKeycloak();
  const getItems = async () => {
    try {
      ItemsService.get(
        keycloak.token ? keycloak.token : "token is missing "
      ).then((response) => {
        setData(response.data.content);
        setLoading(false);
      });
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

  const handleDeleteItem = (id: string) => {
    ItemsService.deleteById(id, keycloak.token ? keycloak.token : "")
      .then((response) => {
        toast("Item deleted");
        getItems();
      })
      .catch((error) => {
        toast("error deleting item");
      });
  };
  const handleCloseModal = () => {
    const modal: IModalProps = {
      id: "",
      isOpen: false,
      header: "",
      content: "",
      onAction: null,
      onClose: null,
    };
    setModal(modal);
  };
  const onDeleteItem = (item: Item) => {
    const modal: IModalProps = {
      id: item.id,
      isOpen: true,
      header: "Delete Item",
      content: `Would you like to delete item: '${item.name}'?`,
      onAction: handleDeleteItem,
      onClose: handleCloseModal,
    };
    setModal(modal);
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
              onClick={() => onDeleteItem(item)}
            />
          </Table.Cell>
          <Table.Cell>
            <Link to={{ pathname: `/item/${item.id}` }}>{item.name} </Link>
          </Table.Cell>
          <Table.Cell>{item.description}</Table.Cell>
          <Table.Cell>
            {item.published
              ? new Date(item.published).toLocaleDateString()
              : "NA"}
          </Table.Cell>
          <Table.Cell>{item.status}</Table.Cell>
          <Table.Cell>{item.publiclyAvailable ? "True" : "False"}</Table.Cell>
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
  const height = window.innerHeight - 100;
  const tableStyle: CSSProperties = {
    height: height,
    maxHeight: height,
    overflowY: "auto",
    overflowX: "hidden",
    clear:"both"
  };
 const addStyle: CSSProperties = {
  float:"right"
 };
  return (
    <div>     
      <div style={addStyle}>
        <Link to={{ pathname: `/item/` }}>Add</Link>
        <ConfirmationModal props={modalData} />
      </div>
      <div style={tableStyle}>
        <Table compact striped>
          <Table.Header>
            <Table.Row>
              <Table.HeaderCell width={2} />
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
    </div>
  );
};

export default Items;
