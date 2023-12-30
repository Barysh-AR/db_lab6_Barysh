
-- Процедура отримує рядкок значень, в томуж порядку
-- як і в початкової таблиці на kaggle 
-- і правильно додає нові значення до всіх таблиць.
-- Для нових данних, за допомогою функції get_new_id() з файлу function.sql
-- створюються нові індекси.

CREATE OR REPLACE PROCEDURE add_row
(yer int, cit varchar,
 spt varchar, dis varchar,
 nam varchar, cnt varchar, gen varchar,
 evt varchar,
 med varchar)
LANGUAGE plpgsql
AS $$
Declare 
	row_olymp_year int;
	row_athlete_id int;
	row_sport_id int;
	row_medal_id int;
BEGIN
	row_olymp_year := yer;
	row_athlete_id := (select athlete_id from athlete 
			where athlete_name = nam and country = cnt and gender = gen);
	row_sport_id := (select Sport_id from Sport
			where Sport = spt and discipline = dis and sport_event = evt);

-- перевіряємо наявність olympics
	IF (select olymp_year from olympics where olymp_year = row_olymp_year) is null THEN
		INSERT INTO Olympics(Olymp_year, city) VALUES (row_olymp_year, cit);
	END IF;
-- 	перевіряємо наявність athlete
	IF row_athlete_id is null THEN
		row_athlete_id := get_new_id('athlete');
		INSERT INTO Athlete(Athlete_name, country, gender, Athlete_id)
		VALUES (nam, cnt, gen, row_athlete_id);
	END IF;
-- 	перевіряємо наявність Sport
	IF row_sport_id is null THEN
		row_sport_id := get_new_id('sport');
		INSERT INTO Sport(Sport, discipline, sport_event, sport_id)
		VALUES (spt, dis, evt, row_sport_id);
	END IF;
-- 	додаємо в таблицю medal
	row_medal_id := get_new_id('medal');
	INSERT INTO Medal (medal_type, medal_id, sport_id, olymp_year, athlete_id)
	VALUES (med, row_medal_id,  row_sport_id, row_olymp_year, row_athlete_id);
END;
$$;