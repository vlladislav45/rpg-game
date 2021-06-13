CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS public.user_roles(
    id SERIAL UNIQUE NOT NULL,
    role_name VARCHAR(15) UNIQUE NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.users (
    id UUID UNIQUE NOT NULL DEFAULT uuid_generate_v4(),
    email VARCHAR(50) UNIQUE,
    username VARCHAR(15) UNIQUE NOT NULL,
    password VARCHAR NOT NULL,
    time_created timestamp NOT NULL,
    role_id SMALLINT REFERENCES user_roles(id) ON DELETE NO ACTION NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.character (
    id UUID UNIQUE NOT NULL DEFAULT uuid_generate_v4(),
    nickname VARCHAR(15) UNIQUE NOT NULL,
    character_level INT NOT NULL,
    hp INT NOT NULL,
    mana INT NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.skills(
    id          UUID UNIQUE NOT NULL DEFAULT uuid_generate_v4(),
    skill_name  VARCHAR     NOT NULL,
    reuse_delay INT         NOT NULL,
    mp_consume  INT         NOT NULL,
    cast_range  INT         NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.character_skills(
    skill_id UUID REFERENCES skills(id) ON UPDATE NO ACTION ON DELETE NO ACTION,
    character_id UUID REFERENCES character(id) ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS public.characters (
    user_id UUID REFERENCES users(id) ON UPDATE NO ACTION ON DELETE NO ACTION,
    character_id UUID REFERENCES character(id) ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS public.items(
    id uuid UNIQUE NOT NULL DEFAULT uuid_generate_v4(),
    item_name VARCHAR (20) UNIQUE NOT NULL,
    limited SMALLINT,
    expire_time TIMESTAMP,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.characters_items(
    item_id UUID REFERENCES items(id) ON UPDATE NO ACTION ON DELETE NO ACTION,
    character_id UUID REFERENCES character(id) ON UPDATE NO ACTION ON DELETE NO ACTION
);