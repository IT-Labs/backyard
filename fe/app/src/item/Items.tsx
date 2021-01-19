import React, { CSSProperties } from "react";
import { useState, useEffect } from "react";
import "./Item.css";

import { Link } from "react-router-dom";

import { Item } from "../service/Item";
import { useKeycloak } from "@react-keycloak/web";
import {
  Button,
  Image,
  Table,
  Pagination,
  PaginationProps,
  Dropdown,
  DropdownItemProps,
  Input,
  Divider,
} from "semantic-ui-react";
import { ItemsService } from "../service/ItemsService";

import ConfirmationModal, { IModalProps } from "../common/ConfirmationModal";
import { errorToast, handleLog, successToast } from "../common/Helpers";

export interface EditItemModel {
  nameError: boolean;
  descriptionError: boolean;
  statusError: boolean;  
  publiclyAvailable: boolean;
  id: string;
  name: string;
  description: string;
  status: string;
}

const ItemStatuses: DropdownItemProps[] = [
  { text: "", value: "" },
  { text: "Draft", value: "DRAFT" },
  { text: "Done", value: "DONE" },
  { text: "In Progress", value: "IN_PROGRESS" },
  { text: "Cancel", value: "CANCEL" },
];
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
  const [activePage, setaActivePage] = useState(1);
  const [totalPage, setTotalPages] = useState(0);
  const [loading, setLoading] = useState(true);
  const [message, setMessage] = useState("");
  const [searchByName, setSearchByName] = useState("");
  const [searchByStatus, setSearchByStatus] = useState("");
  const defaultSort = "created,asc";
  const [sort, setSort] = useState(defaultSort);
  const { keycloak } = useKeycloak();
  const getItems = async () => {
    try {
      let filter = new Map();
      if (searchByName) {
        filter.set("name", searchByName);
      }
      if (searchByStatus) {
        filter.set("status", searchByStatus);
      }
      ItemsService.get(
        keycloak.token ? keycloak.token : "token is missing ",
        activePage - 1,
        filter,
        sort
      ).then((response) => {
        setData(response.data.content);
        setLoading(false);
        setTotalPages(response.data.totalPages);
      });
    } catch (error) {
      setData([]);
      setLoading(false);
      setMessage(error.message);
      handleLog(error.message);
    }
  };
  useEffect(() => {
    getItems();
  }, [keycloak, activePage, searchByName, searchByStatus, sort]);

  if (loading) {
    return <div>Loading Items</div>;
  }
  if (message) {
    return <div>{message}</div>;
  }

  const handleDeleteItem = (id: string) => {
    ItemsService.deleteById(id, keycloak.token ? keycloak.token : "")
      .then((response) => {
        successToast(`Item with ${id} deleted`);
        getItems();
      })
      .catch((error) => {
        errorToast("error deleting item");
        handleLog(error.message);
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
  const onPaginationChange = (e: any, pageInfo: PaginationProps) => {
    let newLocal = pageInfo.activePage
      ? parseInt(pageInfo.activePage.toString(), 10)
      : 1;
    setaActivePage(newLocal);
  };
  const itemsList =
    items &&
    items.map((item) => {
      return (
        <Table.Row key={item.id}>
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
              src={`https://picsum.photos/seed/${item.id}/30/30`}
              rounded
            />
          </Table.Cell>
          <Table.Cell collapsing>
            <Button
              circular
              color="red"
              size="small"
              icon="trash"
              onClick={() => onDeleteItem(item)}
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
    clear: "both",
  };
  const addStyle: CSSProperties = {
    float: "right",
  };
  const handleStatusChange = (event: any, data: any) => {
    const { value } = data;
    setSearchByStatus(value);
    resetPaging();
  };
  const handleNameChange = (event: any, data: any) => {
    const { value } = data;
    setSearchByName(value);
    resetPaging();
  };
  const requestSort = (key: string) => {
    let asc = "asc";
    let desc = "desc";
    let sorting = `${key},${asc}`;
    if (sort.indexOf(key) !== -1 && sorting === sort) {
      sorting = `${key},${desc}`;
    }
    setSort(sorting);
  };
  const resetPaging = () => {
    setaActivePage(1);
    setSort(defaultSort);
  };
  const resetSearch = () => {
    setaActivePage(1);
    setSort(defaultSort);
    setSearchByName("");
    setSearchByStatus("");
  };
  const showSorting = (key: string) => {
    let icon =
      sort.split(",")[0] === key
        ? sort.split(",")[1] === "asc"
          ? "sort up"
          : "sort down"
        : "sort";
    return <Button icon={icon} onClick={() => requestSort(key)}></Button>;
  };
  const search = () => {
    return (
      <div>
        {" "}
        <Input
          label="Name"
          id="name"
          onChange={handleNameChange}
          value={searchByName}
        />
        <Dropdown
          label="Status"
          id="status"
          selection
          placeholder="select item status"
          onChange={handleStatusChange}
          options={ItemStatuses}
          value={searchByStatus}
        />
        <Button onClick={() => resetSearch()}>Reset</Button>
      </div>
    );
  };
  const pagination = () => {
    return (
      <Pagination
        boundaryRange={0}
        activePage={activePage}
        onPageChange={onPaginationChange}
        totalPages={totalPage}
        ellipsisItem={null}
      />
    );
  };
  return (
    <div>
      {search()}
      <Divider />
      <div style={addStyle}>
        <Link to={{ pathname: `/item/` }}>Add</Link>
      </div>
      <div style={tableStyle}>
        {pagination()}
        <Table compact striped>
          <Table.Header>
            <Table.Row>
              <Table.HeaderCell width={2}>
                Name
                {showSorting("name")}
              </Table.HeaderCell>
              <Table.HeaderCell width={4}>Description</Table.HeaderCell>
              <Table.HeaderCell width={1}>
                Published
                {showSorting("published")}
              </Table.HeaderCell>
              <Table.HeaderCell width={1}>
                Status
                {showSorting("status")}
              </Table.HeaderCell>
              <Table.HeaderCell width={1}>
                Is public
                {showSorting("isPublic")}
              </Table.HeaderCell>
              <Table.HeaderCell width={1}>Poster</Table.HeaderCell>
              <Table.HeaderCell width={1} />
            </Table.Row>
          </Table.Header>
          <Table.Body>{itemsList}</Table.Body>
        </Table>
      </div>
      {pagination()}
      <ConfirmationModal props={modalData} />
    </div>
  );
};

export default Items;
