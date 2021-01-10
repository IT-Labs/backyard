import React from 'react'
import { Card, Header, Segment } from 'semantic-ui-react'
import { Item } from "../service/Item";
import ItemCard from "./ItemCard";
interface ItemsListProps {
  items: Array<Item>;
}
function ItemsList(props: ItemsListProps) {
  const items = props.items.map((i) => (
    <ItemCard key={i.id} item={i} link={false} />
  ));

  return props.items.length > 0 ? (
    <Card.Group doubling centered>
      {items}
    </Card.Group>
  ) : (
    <Segment padded color="blue">
      <Header textAlign="center" as="h4">
        No items available
      </Header>
    </Segment>
  );
}

export default ItemsList;