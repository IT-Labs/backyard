import React from 'react'
import { Button, Form } from 'semantic-ui-react'
import { EditItemModel } from './Items';

function ItemForm(
  form: EditItemModel,
  handleChange: any,
  handleSave: any,
  clearForm: any
) {
  return (
    <Form>
      <Form.Input
        fluid
        label="Name *"
        id="name"
        onChange={handleChange}
        value={form.name}
        error="name error"
      />
      <Form.Input
        fluid
        label="Description"
        id="description"
        onChange={handleChange}
        value={form.description}
        error="description error"
      />
      <Form.Dropdown
        fluid
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
        value={form.status}
        error="status error"
      />
      <Form.Checkbox
        fluid
        label="IsPublic"
        id="public"
        onChange={handleChange}
        checked={form.public}
        error="is public error"
      />
      <Button.Group fluid>
        <Button onClick={clearForm}>Cancel</Button>
        <Button.Or />
        <Button positive onClick={handleSave}>
          Save
        </Button>
      </Button.Group>
    </Form>
  );
}

export default ItemForm