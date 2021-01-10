import { useKeycloak } from "@react-keycloak/web";
import React, { useEffect, useState } from "react";
import { RouteComponentProps, useHistory } from "react-router-dom";
import { toast } from "react-toastify";
import { Button, Form } from "semantic-ui-react";
import { ItemsService } from "../service/ItemsService";
import { EditItemModel } from "./Items";
interface IFormProps extends RouteComponentProps<{ id: string }> {}
const ItemForm: React.FunctionComponent<IFormProps> = ({
  match: {
    params: { id },
  },
}) => {
  const [item, setData] = useState<EditItemModel>({
    nameError: "",
    descriptionError: "",
    statusError: "",
    publicError: "",
    publiclyAvailable: false,
    id: "",
    name: "",
    description: "",
    status: "DRAFT",
  });
  const history = useHistory();
  const { keycloak } = useKeycloak();
  useEffect(() => {
    const newLocal = Object.assign({});
    newLocal.status = "DRAFT";
    const getItem = async () => {
      try {
        id
          ? await ItemsService.getById(
              id,
              keycloak.token ? keycloak.token : "token is missing "
            ).then((response) => setData(response.data)).catch(error=>{
                toast("error loading item");
            })
          : setData(newLocal);       
      } catch (error) {
        setData(newLocal);
         toast(error.message);
       
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

  const handleSave = (item: EditItemModel) => {
    ItemsService.saveItem(id, item, keycloak.token ? keycloak.token : "")
      .then((response) => {
        toast("Success save");

        history.goBack();
      })
      .catch((error) => {
        toast("error saving item");
      });
  };
  return (
    <Form>
      <Form.Input
        label="Name *"
        id="name"
        onChange={handleChange}
        value={item.name}
        error={item.nameError}
      />
      <Form.Input
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
        options={[
          { text: "Draft", value: "DRAFT" },
          { text: "Done", value: "DONE" },
          { text: "In Progress", value: "IN_PROGRESS" },
        ]}
        value={item.status}
        error={item.statusError}
      />
      <Form.Checkbox
        label="IsPublic"
        id="publiclyAvailable"
        onChange={handleCheckBoxChange}
        checked={item.publiclyAvailable}
        error={item.publicError}
      />
      <Button.Group>
        <Button
          onClick={() => {
            history.goBack();
          }}
        >
          Cancel
        </Button>
        <Button.Or />
        <Button positive onClick={() => handleSave(item)}>
          Save
        </Button>
      </Button.Group>
    </Form>
  );
};

export default ItemForm;
