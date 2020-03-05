import {
  setDefaultTimeout,
  After,
  AfterAll,
  BeforeAll,
  Before
} from "cucumber";
import { createSession, closeSession } from "nightwatch-api";

setDefaultTimeout(120000);

console.log("nw env", process.env.test_nw_environment);

Before(() => {
  return createSession(process.env.test_nw_environment || "default");
});

After(() => {
  return closeSession();
});

process.on("SIGINT", () => {
  console.log("killing session");
  closeSession()
    .then(() => process.exit(1))
    .catch(() => process.exit(1));
});
