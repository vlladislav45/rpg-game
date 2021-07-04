INSERT INTO user_roles (role_name) VALUES
('user'),
('admin');

INSERT INTO users (id, username, password, time_created, role_id) VALUES
('8d1b9544-6483-4248-99cc-ee4e40083e0c','vladislavl2a', '123456', '2016-06-22 19:10:25-07', 1);

INSERT INTO public.character (id, nickname, character_level, hp, mana, exp) VALUES
('25688036-3baf-4cc5-8fdb-6a886929de04', 'K3llingSpree', 1, 100, 50, 125);

INSERT INTO public.characters (user_id, character_id) VALUES
('8d1b9544-6483-4248-99cc-ee4e40083e0c', '25688036-3baf-4cc5-8fdb-6a886929de04');