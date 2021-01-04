import { useEffect, useState } from "react";
import ComingSoon from "../common/comingSoon";

const Home: React.FunctionComponent = () => {
  const [, setData] = useState([]);

  const [, setLoading] = useState(true);
  const [, setMessage] = useState("");
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
