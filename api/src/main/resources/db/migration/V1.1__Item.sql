CREATE  SEQUENCE IF NOT EXISTS    item_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;


CREATE TABLE IF NOT EXISTS items
(
  id integer NOT NULL DEFAULT nextval('item_id_seq'::regclass),
  name character varying(255) NOT NULL,
  description text NULL,
  status character varying(100) NOT NULL,
  type character varying(100) NOT NULL,
  created timestamp without time zone NOT NULL,
  updated timestamp without time zone NOT NULL,
  CONSTRAINT items_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);