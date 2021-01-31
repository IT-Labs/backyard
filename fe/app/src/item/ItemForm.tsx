import { useKeycloak } from "@react-keycloak/web";
import React, { useEffect, useState } from "react";
import { RouteComponentProps, useHistory } from "react-router-dom";
import { Button, DropdownItemProps, Form, Segment } from "semantic-ui-react";
import { errorToast, successToast, warnToast } from "../common/Helpers";
import { ItemsService } from "../service/ItemsService";
import { EditItemModel } from "./Items";
const ItemStatuses: DropdownItemProps[] = [
  { text: "Draft", value: "DRAFT" },
  { text: "Done", value: "DONE" },
  { text: "In Progress", value: "IN_PROGRESS" },
  { text: "Cancel", value: "CANCEL" },
];
interface IFormProps extends RouteComponentProps<{ id: string }> {}
const ItemForm: React.FunctionComponent<IFormProps> = ({
  match: {
    params: { id },
  },
}) => {
  const newItem = {
    nameError: false,
    descriptionError: false,
    statusError: false,
    publiclyAvailable: false,
    id: "",
    name: "",
    description: "",
    status: "DRAFT",
  };
  const [item, setData] = useState<EditItemModel>(newItem);

  const history = useHistory();
  const { keycloak } = useKeycloak();
  useEffect(() => {
    const getItem = async () => {
      try {
        id
          ? await ItemsService.getById(
              id,
              keycloak.token ? keycloak.token : "token is missing "
            )
              .then((response) => setData(response.data))
              .catch((error) => {
                errorToast(`error loading item with id ${id}`);
              })
          : setData(newItem);
      } catch (error) {
        setData(newItem);
        errorToast(error.message);
      }
    };
    getItem();
  }, [keycloak, id]);
  const handleCheckBoxChange = (event: any) => {
    const { id, checked } = event.target;
    setData({ ...item, [id]: checked });
  };
  const handleChange = (event: any, data: any) => {
    const { id, value } = data;
    setData({ ...item, [id]: value });
  };
  const iaValidItem = (item: EditItemModel) => {
    const nameHasAValue = item.name.trim() === "";
    item.nameError = nameHasAValue;
    setData(item);
    return nameHasAValue || item.descriptionError || item.statusError
      ? false
      : true;
  };
  const handleSave = (item: EditItemModel) => {
    if (!iaValidItem(item)) {
      warnToast("invalid form! Please check required fields");
      return;
    }

    ItemsService.saveItem(id, item, keycloak.token ? keycloak.token : "")
      .then((response) => {
        successToast(
          `Item Successfully ${id ? "updated item with " + id : "created"}`
        );

        history.goBack();
      })
      .catch((error) => {
        errorToast("error saving item");
      });
  };
  return (
    <Segment>
      <Form id="item">
        <Form.Input
          label="Name *"
          id="name"
          onChange={handleChange}
          value={item.name}
          error={item.nameError}
        />
        <Form.TextArea
          label="Description"
          id="description"
          onChange={handleChange}
          value={item.description}
          error={item.descriptionError}
        />
        <Form.Dropdown
          label="Status *"
          id="status"
          selection
          placeholder="select item status"
          onChange={handleChange}
          options={ItemStatuses}
          value={item.status}
          error={item.statusError}
        />
        <Form.Checkbox
          label="IsPublic"
          id="publiclyAvailable"
          onChange={handleCheckBoxChange}
          checked={item.publiclyAvailable}
          error={false}
        />
        <Button.Group>
          <Button  id="back"
            onClick={() => {
              history.goBack();
            }}
          >
            Cancel
          </Button>
          <Button.Or />
          <Button  id="save"positive onClick={() => handleSave(item)}>
            Save
          </Button>
        </Button.Group>
      </Form>
    </Segment>
  );
};

export default ItemForm;
