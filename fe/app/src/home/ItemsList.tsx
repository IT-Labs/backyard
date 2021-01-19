import { useKeycloak } from '@react-keycloak/web';
import React from 'react'
import { Card, Header, Segment } from 'semantic-ui-react'
import { Item } from "../service/Item";
import ItemCard from "./ItemCard";
interface ItemsListProps {
  items: Array<Item>;
}
function ItemsList(props: ItemsListProps) {
   const { keycloak } = useKeycloak();
  const items = props.items.map((i) => (
    <ItemCard key={i.id} item={i} link={!!keycloak.authenticated} />
  ));

  return props.items.length > 0 ? (
    <Card.Group doubling centered>
      {items}
    </Card.Group>
  ) : (
    <Segment padded color="blue">
      <Header id={`card_no_item_header`} textAlign="center" as="h4">
        No items available
      </Header>
    </Segment>
  );
}

export default ItemsList;