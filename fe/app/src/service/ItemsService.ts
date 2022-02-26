import axios from "axios";
import { EditItemModel } from "../item/Items";
import { appConfig } from "./config";
export const ItemsService = {
  get,
  getPublic,
  saveItem,
  deleteById,
  getById,
};

const instance = axios.create({
  baseURL: appConfig.urlApi,
});

function saveItem(id: string|undefined, data: EditItemModel, token: string) {
  let action = id
    ? instance.put("items/" + id, data, {
        headers: {
          Accept: "application/json",
          "Content-Type": "application/json",
          Authorization: "bearer " + token,
        },
      })
    : instance.post("items", data, {
        headers: {
          Accept: "application/json",
          "Content-Type": "application/json",
          Authorization: "bearer " + token,
        },
      });
  return action;
}

function getById(id: string, token: string) {
  return instance.get(`/items/${id}`, {
    headers: { Authorization: "bearer " + token },
  });
}
function deleteById(id: string, token: string) {
  return instance.delete(`/items/${id}`, {
    headers: {
      Authorization: "bearer " + token,
    },
  });
}

function get(
  token: string,
  page: number,
  query: Map<string, string>,
  sort: string,
  size:number
) {
  let q = "";
  if (query) { 
    query.forEach((v, k) => {
      q = `${q}&${k}=${v.trim()}`;
    });
  }
  let s = "&sort=created,desc";

  if (sort) {
    s = `&sort=${sort}`;
  }

  return instance.get(`/items?page=${page}&size=${size}${s}${q}`, {
    headers: {
      Authorization: "bearer " + token,
    },
  });
}
function getPublic() {
  return instance.get("/home/items");
}
instance.interceptors.response.use(
  (response) => {
    return response;
  },
  function (error) {
    if (error.response && error.response.status === 404) {
      return { status: error.response.status };
    }
    return Promise.reject(error.response);
  }
);

export default {};
