CREATE TABLE IF NOT EXISTS public.user_roles(
    id uuid UNIQUE NOT NULL DEFAULT uuid_generate_v4(),
    role_name VARCHAR(15) UNIQUE NOT NULL,
    FOREIGN KEY id REFERENCES users (id),
    PRIMARY KEY (id)
);