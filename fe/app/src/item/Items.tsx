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
  Segment,
} from "semantic-ui-react";
import { ItemsService } from "../service/ItemsService";

import ConfirmationModal, { IModalProps } from "../common/ConfirmationModal";
import { errorToast, handleLog, successToast } from "../common/Helpers";
import { setSyntheticLeadingComments } from "typescript";

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
const PageSizes: DropdownItemProps[] = [
  { text: "10", value: "10" },
  { text: "25", value: "25" },
  { text: "50", value: "50" },
  { text: "100", value: "100" },
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
  const defaultSort = "created,desc";
  const [sort, setSort] = useState(defaultSort);
  const [pageSize, setPageSize] = useState(10);
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
        sort,
        pageSize
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
  }, [keycloak, activePage, searchByName, searchByStatus, sort, pageSize]);

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
        <Table.Row id={item.id} key={item.id}>
          <Table.Cell>
            <Link id={`link_${item.id}`} to={{ pathname: `/item/${item.id}` }}>
              {item.name}{" "}
            </Link>
          </Table.Cell>
          <Table.Cell id={`description_${item.id}`}>
            {item.description}
          </Table.Cell>
          <Table.Cell id={`published_${item.id}`}>
            {item.published
              ? new Date(item.published).toLocaleDateString()
              : "NA"}
          </Table.Cell>
          <Table.Cell id={`status_${item.id}`}>{item.status}</Table.Cell>
          <Table.Cell id={`isPublic_${item.id}`}>
            {item.publiclyAvailable ? "True" : "False"}
          </Table.Cell>
          <Table.Cell id={`poster_${item.id}`}>
            <Image
              size="tiny"
              src={`https://picsum.photos/seed/${item.id}/30/30`}
              rounded
            />
          </Table.Cell>
          <Table.Cell collapsing>
            <Button
              id={`delete_${item.id}`}
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
  const height = window.innerHeight - 200;
  const tableStyle: CSSProperties = {
    height: height,
    maxHeight: height,
    // overflowY: "auto",
    // overflowX: "hidden",
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
  const handlePageSizeChange = (event: any, data: any) => {
    const { value } = data;
    setPageSize(value);
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
    return (
      <Button
        icon={icon}
        id={`sort_${key}`}
        onClick={() => requestSort(key)}
      ></Button>
    );
  };
  const search = () => {
    return (
      <div>
        <Segment>
          <Input
            placeholder="search by Name"
            id="search_name"
            onChange={handleNameChange}
            value={searchByName}
          />
          {"&"}
          <Dropdown
            id="search_status"
            selection
            placeholder="search by status"
            onChange={handleStatusChange}
            options={ItemStatuses}
            value={searchByStatus}
          />
          <Button id="search_reset" onClick={() => resetSearch()}>
            Reset
          </Button>
        </Segment>
      </div>
    );
  };
  const pagination = () => {
    return (
      <Segment>
        <Pagination
          id="items_pagination"
          boundaryRange={1}
          siblingRange={1}
          activePage={activePage}
          onPageChange={onPaginationChange}
          totalPages={totalPage}
          showEllipsis={true}
        />
        <div style={addStyle}>
          <span> Items per page</span>
          <Dropdown
            id="pageSize"
            selection
            onChange={handlePageSizeChange}
            options={PageSizes}
            value={`${pageSize}`}
          />
        </div>
      </Segment>
    );
  };
  return (
    <div>
      {search()}
      <Divider />
      <div style={addStyle}>
        <Link id="link_add_item" to={{ pathname: `/item/` }}>
          <Button label="create a new item">Add</Button>
        </Link>
      </div>
      <div style={tableStyle}>
        {pagination()}        
        <Table id="items_table" compact striped>
          <Table.Header>
            <Table.Row>
              <Table.HeaderCell id="header_name" width={2}>
                Name
                {showSorting("name")}
              </Table.HeaderCell>
              <Table.HeaderCell id="header_description" width={4}>
                Description
              </Table.HeaderCell>
              <Table.HeaderCell id="header_published" width={1}>
                Published
                {showSorting("published")}
              </Table.HeaderCell>
              <Table.HeaderCell id="header_status" width={1}>
                Status
                {showSorting("status")}
              </Table.HeaderCell>
              <Table.HeaderCell id="header_isPublic" width={1}>
                Is public
                {showSorting("isPublic")}
              </Table.HeaderCell>
              <Table.HeaderCell id="header_poster" width={1}>
                Poster
              </Table.HeaderCell>
              <Table.HeaderCell width={1} />
            </Table.Row>
          </Table.Header>
          <Table.Body>{itemsList}</Table.Body>
        </Table>
      </div>
     
      <ConfirmationModal props={modalData} />
    </div>
  );
};

export default Items;
