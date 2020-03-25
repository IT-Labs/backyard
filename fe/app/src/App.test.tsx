import React from "react";
import { render } from "@testing-library/react";
import App from "./App";

test("renders it labs link", () => {
  const { getByTestId } = render(<App />);
  const linkElement = getByTestId(/itLabs/i);
  expect(linkElement).toBeInTheDocument();
});
