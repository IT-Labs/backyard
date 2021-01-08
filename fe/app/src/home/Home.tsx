import React, { useEffect, useState } from "react";
import { Container } from "semantic-ui-react";
import ItemsService, { Item } from "../service/ItemsService";
import ItemsList from "./ItemsList";

const Home: React.FunctionComponent = () => {
  const [data, setData] = useState<Item[]>([]);

  const [loading, setLoading] = useState(true);
  const [message, setMessage] = useState("");
  useEffect(() => {
    const getItems = async () => {
      try {
        let itemsService = new ItemsService();
        const data = await itemsService.getPublic();
        setData(data);
        setLoading(false);
      } catch (error) {
        setData([]);
        setLoading(false);
        setMessage(error.message);
      }
    };
    getItems();
  }, []);

  if (loading) {
    return <div>Loading Items</div>;
  }
  if (message) {
    return <div>{message}</div>;
  }

  return (
    <Container>
      <ItemsList items={data} />
    </Container>
  );
};

export default Home;
