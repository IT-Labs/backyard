import { Component, useEffect, useState } from "react";
import ComingSoon from "../common/comingSoon";
import { handleLog } from "../common/Helpers";

const Home: React.FunctionComponent = () => {
  const [data, setData] = useState([]);

  const [loading, setLoading] = useState(true);
  const [message, setMessage] = useState("");
  useEffect(() => {
    setData([]);
    setLoading(false);
    setMessage("");
  }, []);
  return (
    <div className="App">
      <p> Demo page</p>
      <ComingSoon />
    </div>
  );
};

export default Home;
