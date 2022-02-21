/* Setup priveleges and database*/
CREATE DATABASE rd;
GRANT ALL PRIVILEGES ON rd.* to 'rd'@'127.0.0.1' IDENTIFIED BY 'rd';
GRANT ALL PRIVILEGES ON rd.* to 'rd'@'localhost' IDENTIFIED BY 'rd';
FLUSH PRIVILEGES;