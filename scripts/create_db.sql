create table if not exists hudl_users (
  id              INTEGER(9) AUTO_INCREMENT,
  username        VARCHAR(50), 
  hashed_password VARCHAR(50), 
  password_salt   VARCHAR(50),
  email           VARCHAR(255),
  phone_number    VARCHAR(15), 
  PRIMARY KEY(id),
  UNIQUE INDEX user_indx(username)
);


-- Generate a pseudo random salt with rand() and md5()
-- Create 10 user accounts with password + n as the password


DROP PROCEDURE IF EXISTS ADD_USERS;
DELIMITER $$

CREATE PROCEDURE ADD_USERS()
BEGIN
declare user varchar(50);
declare salt varchar(50);
declare pass varchar(50);
declare email varchar(255);
declare n integer(1);
declare nc varchar(4);

SET @n := 0;

user_loop: LOOP

  SET @n := @n + 1;
  SET @nc := cast(@n as char);
  SET @user := concat("USER", @nc);
  SET @salt := md5(rand());
  SET @pass := concat("password", @nc);
  SET @email := concat("user", @nc, "@hudl.com");

  select @n, @user, @salt, @pass, @email;

  REPLACE INTO hudl_users(id, username, password_salt, hashed_password, email, phone_number) VALUES(null, @user, @salt, sha2(concat(@pass, @salt), 256), @email, "001 101 101101");

  IF @n < 10 THEN
   ITERATE user_loop;
  END IF;
  LEAVE user_loop;

END LOOP user_loop;
commit;

END$$

call add_users();

