
-- Тестування функції get_new_id()
-- вона повертає перший вільний індекс в таблиці, починаючи з 1

select * from get_new_id('athlete');
select * from get_new_id('sport');
select * from get_new_id('medal');

-- Тестування процедури add_row() яка використовує функцію get_new_id()
-- Процедура отримує рядкок значень, в томуж порядку
-- як і в початкової таблиці на kaggle 
-- і правильно додає нові значення до всіх таблиць.


-- після виконання прикладу буде додано:
-- 8 нових значень до таблиці medal
-- 4 нових значень до таблиці athlete
-- 3 нових значень до таблиці olympics
-- 4 нових значень до таблиці sport

CALL add_row (1,'City 1','Sport 1','Discipline 1','TestName 1','UKR','MAN','Event 1','Medal');
CALL add_row (1,'City 1','Sport 1','Discipline 1','TestName 1','UKR','MAN','Event 1','Medal');

CALL add_row (1,'City 1','Sport 1','Discipline 2','TestName 1','UKR','MAN','Event 2','Medal');

CALL add_row (1,'City 1','Sport 1','Discipline 2','TestName 1','UKR','MAN','Event 1','Medal');

CALL add_row (1,'City 1','Sport 1','Discipline 1','TestName 2','UKR','MAN','Event 1','Medal');

CALL add_row (1,'City 1','Sport 1','Discipline 1','TestName 2','USA','MAN','Event 1','Medal');

CALL add_row (2,'City 2','Sport 1','Discipline 1','TestName 1','UKR','MAN','Event 1','Medal');

CALL add_row (3,'City 3','Sport 3','Discipline 3','TestName 3','FRA','Women','Event 3','Medal');

select * from medal;
select * from athlete;
select * from olympics;
select * from sport;

-- Тестування тригеру
-- Тригер записує всі зміни в таблиці medal в таблицю medal_audit

-- DELETE FROM medal;

select * from medal_audit;





-- DELETE FROM medal;
-- DELETE FROM athlete;
-- DELETE FROM olympics;
-- DELETE FROM sport;