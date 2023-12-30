
-- В цьому файлі створюється таблиця medal_audit, 
-- в яку 3 тригерами записується будь-яка зміна в таблиці medal

-- створення таблиці
DROP TABLE IF EXISTS medal_audit; 
CREATE TABLE medal_audit( 
	id SERIAL PRIMARY KEY, 
	updated TIMESTAMP, 
	user_name varchar(50) NOT NULL,
	operation varchar(10) 
); 
 
--  створення тригеру на UPDATE
CREATE OR REPLACE FUNCTION update_medal() RETURNS trigger  
LANGUAGE 'plpgsql' 
AS $$ 
BEGIN 
 	INSERT INTO medal_audit(updated, user_name, operation) 
		VALUES(NOW(), user, 'UPDATE'); 
	RETURN NULL; 
END; 
$$ ; 
 
CREATE TRIGGER medal_update_details  
AFTER UPDATE ON medal 
FOR EACH ROW EXECUTE FUNCTION update_medal();

--  створення тригеру на INSERT
CREATE OR REPLACE FUNCTION INSERT_medal() RETURNS trigger  
LANGUAGE 'plpgsql' 
AS $$ 
BEGIN 
 	INSERT INTO medal_audit(updated, user_name, operation) 
		VALUES(NOW(), user, 'INSERT'); 
	RETURN NULL; 
END; 
$$ ; 
 
CREATE TRIGGER medal_INSERT_details  
AFTER INSERT ON medal
FOR EACH ROW EXECUTE FUNCTION INSERT_medal();

--  створення тригеру на DELETE
CREATE OR REPLACE FUNCTION DELETE_medal() RETURNS trigger  
LANGUAGE 'plpgsql' 
AS $$ 
BEGIN 
 	INSERT INTO medal_audit(updated, user_name, operation) 
		VALUES(NOW(), user, 'DELETE'); 
	RETURN NULL; 
END; 
$$ ; 

CREATE TRIGGER medal_DELETE_details  
AFTER DELETE ON medal 
FOR EACH ROW EXECUTE FUNCTION DELETE_medal();


-- DROP TRIGGER IF EXISTS medal_update_details ON medal;
-- DROP FUNCTION IF EXISTS UPDATE_medal;
-- DROP TRIGGER IF EXISTS medal_INSERT_details ON medal;
-- DROP FUNCTION IF EXISTS INSERT_medal;
-- DROP TRIGGER IF EXISTS medal_DELETE_details ON medal;
-- DROP FUNCTION IF EXISTS DELETE_medal;