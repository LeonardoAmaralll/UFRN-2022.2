DROP DATABASE IF EXISTS NETFLIX;
SHOW DATABASES;
CREATE DATABASE NETFLIX;
USE NETFLIX;
SHOW TABLES;

/* Questao 1 */

CREATE TABLE IF NOT EXISTS USUARIO (
  cpf INT PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  email VARCHAR(255),
  senha INT NOT NULL
); 

CREATE TABLE IF NOT EXISTS PAGAMENTO (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  valor FLOAT NOT NULL,
  data_pg DATE NOT NULL,
  mes_ref INT NOT NULL,
  ano_ref INT NOT NULL,
  u_cpf INT,
  FOREIGN KEY (u_cpf) REFERENCES USUARIO(cpf)
);

CREATE TABLE IF NOT EXISTS CARTAO (
  numero INT PRIMARY KEY,
  cv INT NOT NULL,
  bandeira VARCHAR(150),
  u_cpf INT,
  FOREIGN KEY (u_cpf) REFERENCES USUARIO(cpf)
);

CREATE TABLE IF NOT EXISTS VIDEO (
  id INT AUTO_INCREMENT PRIMARY KEY, 
  titulo VARCHAR(255) NOT NULL,
  duracao FLOAT NOT NULL,
  ano INT,
  cont INT
);

CREATE TABLE IF NOT EXISTS USUARIO_VIDEO (
  u_cpf INT,
  v_id INT,
  nota INT,
  PRIMARY KEY (u_cpf,v_id),
  FOREIGN KEY (u_cpf) REFERENCES USUARIO(cpf),   
  FOREIGN KEY (v_id) REFERENCES VIDEO(id)
);

CREATE TABLE IF NOT EXISTS ARTISTA (
  cpf INT PRIMARY KEY,
  nome VARCHAR(255) NOT NULL ,
  dt_nsc DATE,
  loc_nsc VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS ARTISTA_VIDEO (
  v_id INT,
  a_cpf INT,
  PRIMARY KEY (v_id,a_cpf),
  FOREIGN KEY (v_id) REFERENCES VIDEO(id),  
  FOREIGN KEY (a_cpf) REFERENCES ARTISTA(cpf)   
);

CREATE TABLE IF NOT EXISTS FILME (
  id INT PRIMARY KEY,
  genero VARCHAR(140),
  descricao VARCHAR(255),
  v_id INT,
  FOREIGN KEY (v_id) REFERENCES VIDEO(id)
);

CREATE TABLE IF NOT EXISTS EPSODIO (
  id INT PRIMARY KEY,
  temp VARCHAR(255),
  num INT,
  prox INT,
  v_id INT,
  s_id INT,
  FOREIGN KEY (prox) REFERENCES EPSODIO(id),
  FOREIGN KEY (v_id) REFERENCES VIDEO(id)
);

CREATE TABLE IF NOT EXISTS SERIE (
  id INT AUTO_INCREMENT PRIMARY KEY,
  genero VARCHAR(255),
  titulo VARCHAR(255) NOT NULL,
  descricao TEXT NOT NULL 
);

ALTER TABLE EPSODIO ADD CONSTRAINT FOREIGN KEY (s_id) REFERENCES SERIE(id); 


----------------------------------------------------------------
/*
SELECT * FROM FILME;
SELECT * FROM VIDEO;
SELECT * FROM SERIE;
SELECT * FROM EPSODIO;
SELECT * FROM USUARIO_VIDEO;
SELECT * FROM ARTISTA;
SELECT * FROM ARTISTA_VIDEO;
DROP DATABASE NETFLIX;
*/

/* Questao 2a */
INSERT INTO USUARIO VALUES (1,'PAULO','paulo@exemplo.com','123');
INSERT INTO USUARIO VALUES (2,'Jose','jose@exemplo.com','123');
INSERT INTO USUARIO VALUES (3,'Maria','maria@exemplo.com','123');
INSERT INTO CARTAO VALUES (1,701,'Visa',1);
INSERT INTO CARTAO VALUES (2,702,'Visa',2); 
INSERT INTO CARTAO VALUES (3,703,'Visa',3);

/*

CREATE TABLE IF NOT EXISTS PAGAMENTO (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  valor FLOAT NOT NULL,
  data_pg DATE NOT NULL,
  mes_ref INT NOT NULL,
  ano_ref INT NOT NULL,
  u_cpf INT,
  FOREIGN KEY (u_cpf) REFERENCES USUARIO(cpf)
);
*/



/* Questao 2b */
INSERT INTO VIDEO VALUES (1,'Homem Aranha',120,2001,1);
INSERT INTO VIDEO VALUES (2,'Homem de Ferro',120,2002,1); 
INSERT INTO VIDEO VALUES (3,'Huck',120,2003,1); 
INSERT INTO FILME (id,genero,descricao,v_id) 
  VALUES (1,'Aventura','filme do homem aranha',1); 
INSERT INTO FILME (id,genero,descricao,v_id) 
  VALUES (2,'Aventura','filme do homem ferro',2);   
INSERT INTO FILME (id,genero,descricao,v_id) 
  VALUES (3,'Aventura','Huck, o filme',3);   
  
INSERT INTO VIDEO VALUES (4,'Aniversario da Wandinha',60,2022,1);
INSERT INTO VIDEO VALUES (5,'Escola da Wandinha',60,2022,1);
INSERT INTO SERIE VALUES (1,'DRAMA','Wandinha','Familia Addams');
INSERT INTO EPSODIO VALUES (2,1,1,NULL,5,1);
INSERT INTO EPSODIO VALUES (1,1,1,2,4,1);
INSERT INTO USUARIO_VIDEO VALUES (1,1,9);
INSERT INTO USUARIO_VIDEO VALUES (2,2,8);
INSERT INTO USUARIO_VIDEO VALUES (3,3,8);

/* Questao 2c */
INSERT INTO ARTISTA VALUES (100,'Michael','1990-01-01','New York');
INSERT INTO ARTISTA VALUES (101,'Smith','1991-02-02','Chicago');
INSERT INTO ARTISTA VALUES (102,'Jonh','1992-03-03','Miami');
INSERT INTO ARTISTA_VIDEO VALUES (1,100);
INSERT INTO ARTISTA_VIDEO VALUES (2,101);
INSERT INTO ARTISTA_VIDEO VALUES (2,102);

/* Questao 3b */
SELECT a.nome, v.titulo, f.descricao FROM ARTISTA AS a
INNER JOIN ARTISTA_VIDEO AS av ON av.a_cpf = a.cpf 
INNER JOIN VIDEO AS v ON v.id = av.v_id 
INNER JOIN FILME AS f ON f.v_id = v.id; 

/* Questao 3c */
SELECT f.genero, AVG(uv.nota) AS media
FROM FILME AS f 
INNER JOIN VIDEO AS v ON v.id = f.v_id
INNER JOIN USUARIO_VIDEO AS uv ON uv.v_id = v.id 
GROUP BY f.genero;

