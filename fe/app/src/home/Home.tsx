import React, { useEffect, useState } from "react";
import { Container } from "semantic-ui-react";
import { ItemsService } from "../service/ItemsService";
import { Item } from "../service/Item";
import ItemsList from "./ItemsList";
import ReactLoading from "react-loading";
import { toast } from "react-toastify";

function Home()  {
  const [data, setData] = useState<Item[]>([]);

  const [loading, setLoading] = useState(true);
 
  useEffect(() => {
    const getItems = async () => {
      try {
         ItemsService.getPublic().then((response) => {
          setData(response.data);
          setLoading(false);
        });
      } catch (error:any) {
        setData([]);
        setLoading(false);
        toast(error.message);
       
      }
    };
    getItems();
  }, []);

  if (loading) {
    return <ReactLoading color={"red"} height={"20%"} width={"20%"} />;
  }
 

  return (
    <Container id="items_container">
      <ItemsList  items={data} />
    </Container>
  );
};

export default Home;
