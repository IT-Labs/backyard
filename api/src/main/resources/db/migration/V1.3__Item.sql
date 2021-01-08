ALTER TABLE items ADD COLUMN IF NOT EXISTS published timestamp without time zone NULL ;
ALTER TABLE items ADD COLUMN IF NOT EXISTS is_public boolean DEFAULT false  NULL ;
UPDATE items SET is_public = false;
ALTER TABLE items ALTER COLUMN is_public SET NOT NULL;
CREATE INDEX ix_items_published ON items  USING btree (published);
