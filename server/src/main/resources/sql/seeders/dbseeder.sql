INSERT INTO user_roles (role_name) VALUES
('user'),
('admin');

INSERT INTO users (username, password, time_created, role_id) VALUES
('vladislavl2a', '123456', '2016-06-22 19:10:25-07', 1),
('vladislavl3', '123456', '2017-06-22 19:10:25-07', 1);

INSERT INTO public.character (nickname, character_level, hp, mana) VALUES
('K3llingSpree', 1, 100, 50);

INSERT INTO public.characters (user_id, character_id) VALUES
('10d9e3cc-91d2-42fb-a9dc-eeb5117b3ff4', 'da0c3bec-1403-4934-b2ce-9ae3a04c22fe');