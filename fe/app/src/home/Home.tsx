import React, { useEffect, useState } from "react";
import { Container } from "semantic-ui-react";
import { ItemsService } from "../service/ItemsService";
import { Item } from "../service/Item";
import ItemsList from "./ItemsList";
import { toast } from "react-toastify";

const Home: React.FunctionComponent = () => {
  const [data, setData] = useState<Item[]>([]);

  const [loading, setLoading] = useState(true);
 
  useEffect(() => {
    const getItems = async () => {
      try {
         ItemsService.getPublic().then((response) => {
          setData(response.data);
          setLoading(false);
        });
      } catch (error) {
        setData([]);
        setLoading(false);
        toast(error.message);
       
      }
    };
    getItems();
  }, []);

  if (loading) {
    return <div>Loading Items</div>;
  }
 

  return (
    <Container id="items_container">
      <ItemsList  items={data} />
    </Container>
  );
};

export default Home;
