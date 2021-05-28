
CREATE TABLE IF NOT EXISTS public.character_skills(
    id uuid UNIQUE NOT NULL DEFAULT uuid_generate_v4(),
    skill_name VARCHAR NOT NULL,
    reuse_delay INT NOT NULL,
    mp_consume INT NOT NULL,
    cast_range INT NOT NULL,
    PRIMARY KEY (id)
);