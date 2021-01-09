import React from 'react'
import { Button, Modal } from 'semantic-ui-react'
export interface IModalProps{
  isOpen:boolean;
 header:any;
  content:any;
   onClose:any; onAction:any
}
function ConfirmationModal(modal :IModalProps) {
 
  return (
    <Modal size="tiny" open={modal.isOpen} onClose={modal.onClose}>
      <Modal.Header>{modal.header}</Modal.Header>
      <Modal.Content>
        <p>{modal.content}</p>
      </Modal.Content>
      <Modal.Actions>
        <Button
          negative
          icon="thumbs down"
          content="No"
          onClick={() => modal.onAction(false)}
        />
        <Button
          positive
          icon="thumbs up"
          labelPosition="right"
          content="Yes"
          onClick={() => modal.onAction(true)}
        />
      </Modal.Actions>
    </Modal>
  );
}

export default ConfirmationModal