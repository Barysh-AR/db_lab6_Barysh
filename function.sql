
-- Функція get_new_id() шукає новий id, який не повторюєьться, 
-- для однієї з таблиць 'athlete', 'sport', 'medal'.
-- Необхідно вести назву таблиці для якої треба шукати id
-- ПРИЛАД: select get_new_id('medal');


DROP FUNCTION IF EXISTS get_new_id(tabl varchar);

CREATE OR REPLACE FUNCTION get_new_id(tabl varchar) RETURNS int
LANGUAGE plpgsql
AS $$
	Declare new_index int := 1;
BEGIN 
	IF    tabl = 'athlete' THEN
		LOOP
			EXIT When (select athlete_id from athlete where athlete_id = new_index) is null;
			new_index:= new_index+1;
		END LOOP;
-- 	ELSIF tabl = 'olympics' THEN
-- 		new_index:= 2012;
-- 		LOOP
-- 			EXIT When (select olymp_year from olympics where olymp_year = new_index) is null;
-- 			new_index:= new_index+4;
-- 		END LOOP;
	ELSIF tabl = 'sport' THEN
		LOOP
			EXIT When (select sport_id from sport where sport_id = new_index) is null;
			new_index:= new_index+1;
		END LOOP;
	ELSIF tabl = 'medal' THEN
    	LOOP
			EXIT When (select medal_id from medal where medal_id = new_index) is null;
			new_index:= new_index+1;
		END LOOP;
    END IF;
	
	RETURN new_index;
END;
$$;




