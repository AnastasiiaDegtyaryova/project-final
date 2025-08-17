-- src/test/resources/db/data-test.sql

---------------------------
-- Очистка перед вставками
---------------------------
SET MODE PostgreSQL;
SET REFERENTIAL_INTEGRITY FALSE;

TRUNCATE TABLE ACTIVITY;
TRUNCATE TABLE ATTACHMENT;
TRUNCATE TABLE CONTACT;
TRUNCATE TABLE MAIL_CASE;
TRUNCATE TABLE PROFILE;
TRUNCATE TABLE PROJECT;
TRUNCATE TABLE REFERENCE;
TRUNCATE TABLE SPRINT;
TRUNCATE TABLE TASK_TAG;
TRUNCATE TABLE TASK;
TRUNCATE TABLE USER_BELONG;
TRUNCATE TABLE USER_ROLE;
TRUNCATE TABLE USERS;

SET REFERENTIAL_INTEGRITY TRUE;

---------------------------
-- Базові дані для тестів
---------------------------

-- USERS з явними ID (IDENTITY дозволяє явні значення)
INSERT INTO USERS (ID, DISPLAY_NAME, EMAIL, FIRST_NAME, LAST_NAME, PASSWORD, STARTPOINT)
VALUES
  (1, 'userDisplay',  'user@gmail.com',  'UserFirst',  'UserLast',  '{noop}password', CURRENT_TIMESTAMP),
  (2, 'adminDisplay', 'admin@gmail.com', 'AdminFirst', 'AdminLast', '{noop}admin',    CURRENT_TIMESTAMP);

-- Ролі користувачів (у тестовій схемі FK на USERS немає — безпечніше для ініціалізації)
INSERT INTO USER_ROLE (USER_ID, ROLE) VALUES (2, 1);

-- PROFILE: PK=FK на USERS.ID
INSERT INTO PROFILE (ID, LAST_LOGIN, LAST_FAILED_LOGIN, MAIL_NOTIFICATIONS)
VALUES
  (1, NULL, NULL, 0),
  (2, NULL, NULL, 0);

-- CONTACT: PK (ID, CODE)
INSERT INTO CONTACT (ID, CODE, VALUE)
VALUES
  (1, 'EMAIL', 'user@gmail.com'),
  (2, 'EMAIL', 'admin@gmail.com');

-- REFERENCE: мінімальний набір довідників (ordinal ref_type = 0)
INSERT INTO REFERENCE (CODE, TITLE, REF_TYPE, STARTPOINT, ENDPOINT, AUX) VALUES
  ('priority', 'Priority', 0, CURRENT_TIMESTAMP, NULL, NULL),
  ('status',   'Status',   0, CURRENT_TIMESTAMP, NULL, NULL),
  ('type',     'Task type',0, CURRENT_TIMESTAMP, NULL, NULL);
