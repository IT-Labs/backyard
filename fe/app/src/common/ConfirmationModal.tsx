import React from "react";
import { Button, Modal } from "semantic-ui-react";
export interface IModal {
  props: IModalProps;
}
export interface IModalProps {
  id: string;
  isOpen: boolean;
  header: any;
  content: any;
  onClose: any;
  onAction: any;
}
function ConfirmationModal(modal: IModal) {
  return (
    <Modal id="modal" size="mini" open={modal.props.isOpen} onClose={modal.props.onClose}>
      <Modal.Header>{modal.props.header}</Modal.Header>
      <Modal.Content>
        <p>{modal.props.content}</p>
      </Modal.Content>
      <Modal.Actions>
        <Button
        id="modal_No"
          negative
          icon="thumbs down"
          content="No"
          onClick={modal.props.onClose}
        />
        <Button
        id="model_Yes"
          positive
          icon="thumbs up"
          labelPosition="right"
          content="Yes"
          onClick={() => {
            modal.props.onAction(modal.props.id);
            modal.props.onClose();
          }}
        />
      </Modal.Actions>
    </Modal>
  );
}

export default ConfirmationModal;
