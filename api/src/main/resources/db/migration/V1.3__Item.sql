ALTER TABLE items ADD COLUMN IF NOT EXISTS created_by uuid NULL;
ALTER TABLE items ADD COLUMN IF NOT EXISTS updated_by uuid NULL;
UPDATE items SET created_by = '5caab7e1-4e26-4fc7-8c7a-cb1105d0480b',updated_by='5caab7e1-4e26-4fc7-8c7a-cb1105d0480b';
ALTER TABLE items ALTER COLUMN created_by SET NOT NULL;
ALTER TABLE items ALTER COLUMN updated_by SET NOT NULL;

ALTER TABLE items ADD COLUMN IF NOT EXISTS published timestamp without time zone NULL ;
ALTER TABLE items ADD COLUMN IF NOT EXISTS is_public boolean DEFAULT false  NULL ;
UPDATE items SET is_public = false where is_public is null ;
ALTER TABLE items ALTER COLUMN is_public SET NOT NULL;
DROP INDEX IF  EXISTS ix_items_published;
CREATE INDEX ix_items_published ON items  USING btree (published);
