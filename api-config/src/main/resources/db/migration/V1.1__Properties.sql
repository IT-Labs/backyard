CREATE TABLE IF NOT EXISTS properties
(
  id serial primary key,
  key character varying(255) NOT NULL,
  value text NOT NULL,
  application character varying(100) NOT NULL DEFAULT 'application',
  label character varying(100) NOT NULL DEFAULT 'master',
  profile character varying(100)  NOT NULL DEFAULT 'default',
  updated timestamp without time zone NOT NULL DEFAULT now(),
  created timestamp without time zone NOT NULL DEFAULT now(),
  guid uuid NOT NULL DEFAULT MD5(random()::text)::uuid

);
ALTER TABLE properties DROP CONSTRAINT IF EXISTS UC_properties_application_label_profile_key;
ALTER TABLE properties ADD CONSTRAINT UC_properties_application_label_profile_key UNIQUE (key, application, profile, label);
