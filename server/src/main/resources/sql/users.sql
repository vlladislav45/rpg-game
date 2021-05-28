CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS public.users (
  id uuid UNIQUE NOT NULL DEFAULT uuid_generate_v4(),
  email VARCHAR(50) UNIQUE,
  username VARCHAR(15) UNIQUE NOT NULL,
  password VARCHAR NOT NULL,
  time_created timestamp NOT NULL,
  PRIMARY KEY (id)
);