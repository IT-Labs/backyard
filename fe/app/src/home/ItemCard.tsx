import React from 'react'
import { Card, Image } from 'semantic-ui-react'
import { Link } from 'react-router-dom'
import { Item } from "../service/Item";
interface ItemProps {
  item: Item;
  link:boolean;
}
function ItemCard(props: ItemProps) {
  const content = (
    <>
      <Image
        src={`https://picsum.photos/seed/${props.item.id}/100/100`}
        wrapped
        ui={false}
      />
      <Card.Content textAlign="center">
        <Card.Header>{props.item.name}</Card.Header>
      </Card.Content>
      <Card.Content>
        <Card.Description>
          Description: <strong>{props.item.description}</strong>
        </Card.Description>
        <Card.Description>
          Published at:{" "}
          <strong>
            {new Date(props.item.published).toLocaleDateString()}
          </strong>
        </Card.Description>
      </Card.Content>
    </>
  );
  return !props.link ? (
    <Card>{content}</Card>
  ) : (
    <Card as={Link} to={`/item/${props.item.id}`}>
      {content}
    </Card>
  );
}

export default ItemCard;