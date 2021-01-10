import { useKeycloak } from "@react-keycloak/web";
import React, { useEffect, useMemo, useState } from "react";
import { RouteComponentProps, useHistory } from "react-router-dom";
import { Button, Form } from "semantic-ui-react";
import ItemsService from "../service/ItemsService";
import { EditItemModel } from "./Items";
interface IFormProps extends RouteComponentProps<{ id: string }> {}
const ItemForm: React.FunctionComponent<IFormProps> = ({
  match: {
    params: { id },
  },
}) => {
  const [item, setData] = useState<EditItemModel>({nameError: '',
  descriptionError:'',
  statusError:'',
  publicError:'',
  public: false,
  id:'',
  name: '',
  description: '',
  status: 'DRAFT',});
  const history = useHistory();
  const { keycloak } = useKeycloak();
  const itemsService = useMemo<ItemsService>(() => new ItemsService(), []);
  useEffect(() => {
    const newLocal = Object.assign({});
    newLocal.status = "DRAFT";
    const getItem = async () => {
      try {
        
        const data = id
          ? await itemsService.getById(
              id,
              keycloak.token ? keycloak.token : "token is missing "
            )
          : newLocal;
        setData(data);
        //   setLoading(false);
      } catch (error) {
        setData(newLocal);
        //   setLoading(false);
        //   setMessage(error.message);
      }
    };
    getItem();
  }, [keycloak,itemsService, id]);
  const handleCheckBoxChange = (event: any, data: any) => {
    const { id, checked } = event.target;   
    item.public = checked;
    setData(item);
  };
  const handleChange = (event: any, data: any) => {
    const { id, value } = event.target;
    const form = { ...data };
    form[id] = value; 

    if (id === 'name') {
      item.name = value;
    } else if (id === 'description') {
      item.description = value;
    } else if (id === 'status') {
      item.status = value;
    }  
    setData(item);
  };

  const handleSave = (item:EditItemModel) => {    
    itemsService.saveItem(id, item, keycloak.token ? keycloak.token : "");
    history.goBack();
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
        id="public"
        onChange={handleCheckBoxChange}
        checked={item.public}
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
        <Button positive onClick={()=>handleSave(item)}>
          Save
        </Button>
      </Button.Group>
    </Form>
  );
};

export default ItemForm;
