
CREATE TABLE IF NOT EXISTS public.items(
    id uuid UNIQUE NOT NULL DEFAULT uuid_generate_v4(),
    item_name VARCHAR (20) UNIQUE NOT NULL,
    limited SMALLINT,
    expire_time TIMESTAMP,
    PRIMARY KEY (id)
    );