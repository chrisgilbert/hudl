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

DELIMITER §

CREATE PROCEDURE ADD_USERS()
BEGIN
declare user varchar(50);
declare salt varchar(50);
declare pass varchar(50);
declare email varchar(255);
declare n integer(1);

SET n = 0;

user_loop: LOOP

  SET n = n + 1;
  SET user = 'USER' +n;
  SET salt = md5(rand());
  SET pass = 'password' + n;
  SET email = 'user' + n +'@hudl.com';

  INSERT INTO hudl_users(id, username, password_salt, hashed_password, email, phone_number)
  VALUES(null, @user, @salt, sha2(@pass + @salt, 256), @email, '001 101 101101');

  IF n < 10 THEN
   ITERATE user_loop;
  END IF;
  LEAVE user_loop;

END LOOP user_loop;

END§;

