CREATE TABLE sampleInfo (
	sampleid INTEGER AUTO_INCREMENT PRIMARY KEY,
	date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	length INTEGER,
	location VARCHAR(50)
);