
CREATE TABLE mytable(
   id     INTEGER  NOT NULL PRIMARY KEY,
   name   VARCHAR(29) NOT NULL,
   amount NUMERIC(6,2) NOT NULL,
   Remark VARCHAR(45)
);
INSERT INTO mytable(id,name,amount,Remark) VALUES (1,'Johnson, Smith, and Jones Co.',345.33,'Pays on time');
INSERT INTO mytable(id,name,amount,Remark) VALUES (2,'Sam "Mad Dog" Smith',993.44,NULL);
INSERT INTO mytable(id,name,amount,Remark) VALUES (3,'Barney & Company',0,'Great to work with
and always pays with cash.');
INSERT INTO mytable(id,name,amount,Remark) VALUES (4,'Johnson''s Automotive',2344,NULL);