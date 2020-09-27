ALTER TABLE items ADD COLUMN IF NOT EXISTS guid uuid NULL DEFAULT MD5(random()::text)::uuid;
UPDATE items SET guid = MD5(random()::text)::uuid;
ALTER TABLE items ALTER COLUMN guid SET NOT NULL;
CREATE INDEX ix_items_guid ON items  USING btree (guid);
