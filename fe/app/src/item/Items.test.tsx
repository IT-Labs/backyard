import React from "react";
import { render, getByTestId } from "@testing-library/react";
import Items from "./Items";

test("renders items table", () => {
  const table = getByTestId(/items_table/i);
  expect(table).toBeInTheDocument();
});
