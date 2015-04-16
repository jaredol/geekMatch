CREATE DATABASE geek_match;

  CREATE TABLE profiles(
      id SERIAL4 PRIMARY KEY,
      username VARCHAR(200),
      gender VARCHAR(200),
      email VARCHAR(200),
      full_name VARCHAR(200) NOT NULL,
      profile_desc VARCHAR(200),
      age INTEGER,
      image_url VARCHAR(200)
  );

 #image_url VARCHAR(200)

DROP TABLE profiles;

ALTER TABLE posts ADD gender;

INSERT INTO profiles (gender, fullname, age, image_url)
VALUES ('Male', 'Barry Obama', 53, 'http://upload.wikimedia.org/wikipedia/commons/8/8d/President_Barack_Obama.jpg');

INSERT INTO profiles (gender, fullname, age, image_url)
VALUES ('Female', 'The Queen', 93, 'http://i.dailymail.co.uk/i/pix/2009/10/07/article-0-02AE1F68000005DC-390_224x314.jpg');

# add column
ALTER TABLE profiles ADD age_range
VARCHAR;


INSERT INTO users (email, password_digest)
VALUES ('jared@mail.com', 'password');


