CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS public.characters (
  id uuid UNIQUE NOT NULL DEFAULT uuid_generate_v4(),
  nickname VARCHAR(15) UNIQUE NOT NULL,
  character_level INT NOT NULL,
  hp INT NOT NULL,
  mana INT NOT NULL,
  FOREIGN KEY (id) REFERENCES users (id) ON DELETE CASCADE,
  PRIMARY KEY (id)
);