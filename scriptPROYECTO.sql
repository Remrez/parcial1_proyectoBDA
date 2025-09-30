DROP TABLE ARTICULO_CATEGORIAS CASCADE CONSTRAINTS;
DROP TABLE ARTICULO_TAGS CASCADE CONSTRAINTS;
DROP TABLE COMENTARIOS CASCADE CONSTRAINTS;
DROP TABLE ARTICULOS CASCADE CONSTRAINTS;
DROP TABLE CATEGORIAS CASCADE CONSTRAINTS;
DROP TABLE TAGS CASCADE CONSTRAINTS;
DROP TABLE USUARIOS CASCADE CONSTRAINTS;

DROP SEQUENCE usuarios_seq;
DROP SEQUENCE articulos_seq;
DROP SEQUENCE comentarios_seq;
DROP SEQUENCE tags_seq;
DROP SEQUENCE categorias_seq;


CREATE TABLE USUARIOS(
  user_id       NUMBER        CONSTRAINT user_id_pk PRIMARY KEY,
  user_name     VARCHAR2(50)  CONSTRAINT user_name_nn NOT NULL, 
  email         VARCHAR2(100) CONSTRAINT email_nn NOT NULL
);

ALTER TABLE USUARIOS 
ADD CONSTRAINT email_un UNIQUE(email);

CREATE TABLE ARTICULOS(
  articulo_id       NUMBER       CONSTRAINT artiuclo_id_pk PRIMARY KEY,
  user_id           NUMBER       CONSTRAINT a_user_id_nn NOT NULL,--FK
  titulo            VARCHAR2(50) CONSTRAINT a_titulo_nn NOT NULL,
  fecha_publicacion DATE DEFAULT SYSDATE, 
  article_text      CLOB         CONSTRAINT a_text_nn NOT NULL,
  
  CONSTRAINT art_user_id_fk FOREIGN KEY (user_id) REFERENCES usuarios(user_id) ON DELETE CASCADE
);



CREATE TABLE COMENTARIOS(
  comentario_id   NUMBER        CONSTRAINT comentario_id_pk PRIMARY KEY,
  articulo_id     NUMBER        CONSTRAINT co_art_id_nn NOT NULL,--FK
  user_id         NUMBER        CONSTRAINT co_user_id_nn NOT NULL,--FK
  texto_com       CLOB          CONSTRAINT co_texto_nn NOT NULL,
  --url_profile     VARCHAR2(100) CONSTRAINT co_url_nn NOT NULL,

  CONSTRAINT co_articulo_id_fk FOREIGN KEY (articulo_id) REFERENCES articulos(articulo_id) ON DELETE CASCADE,
  CONSTRAINT co_user_id_fk FOREIGN KEY (user_id) REFERENCES usuarios(user_id) ON DELETE CASCADE
);

CREATE TABLE TAGS(
  tag_id        NUMBER       CONSTRAINT tag_name_pk PRIMARY KEY,
  tag_name      VARCHAR2(50) CONSTRAINT t_name_nn NOT NULL,
  url_tag      VARCHAR2(100) CONSTRAINT t_url_nn NOT NULL
);

ALTER TABLE TAGS
ADD CONSTRAINT tag_nm_un UNIQUE(tag_name);

CREATE TABLE CATEGORIAS(
  categoria_id      NUMBER        CONSTRAINT category_id_pk PRIMARY KEY,
  category_name     VARCHAR2(50)  CONSTRAINT ca_name_nn NOT NULL,
  url_cat           VARCHAR2(100) CONSTRAINT ca_url_nn NOT NULL
);

ALTER TABLE CATEGORIAS
ADD CONSTRAINT categoria_nm_un UNIQUE(category_name);

CREATE TABLE ARTICULO_TAGS(
  articulo_id    NUMBER CONSTRAINT artag_art_id_nn NOT NULL,
  tag_id         NUMBER CONSTRAINT artag_tag_id_nn NOT NULL,
  
  CONSTRAINT art_tag_pk PRIMARY KEY (articulo_id, tag_id),
  CONSTRAINT artag_articulo_id_fk FOREIGN KEY (articulo_id) REFERENCES articulos(articulo_id) ON DELETE CASCADE,
  CONSTRAINT artag_tag_id_fk FOREIGN KEY (tag_id) REFERENCES tags(tag_id) ON DELETE CASCADE
);

CREATE TABLE ARTICULO_CATEGORIAS(
  articulo_id       NUMBER CONSTRAINT artcat_art_id_nn NOT NULL,
  categoria_id      NUMBER CONSTRAINT artcat_cat_id_nn NOT NULL,
  
  CONSTRAINT art_cat_pk PRIMARY KEY (articulo_id, categoria_id),
  CONSTRAINT artcat_articulo_id_fk FOREIGN KEY (articulo_id) REFERENCES articulos(articulo_id) ON DELETE CASCADE, 
  CONSTRAINT artcat_categoria_id_fk FOREIGN KEY (categoria_id) REFERENCES categorias(categoria_id) ON DELETE CASCADE
);

CREATE SEQUENCE usuarios_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE;

CREATE SEQUENCE articulos_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE;

CREATE SEQUENCE comentarios_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE;

CREATE SEQUENCE tags_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE;

CREATE SEQUENCE categorias_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE;

ALTER TABLE usuarios
MODIFY user_id DEFAULT usuarios_seq.NEXTVAL;
ALTER TABLE articulos
MODIFY articulo_id DEFAULT articulos_seq.NEXTVAL;
ALTER TABLE comentarios
MODIFY comentario_id DEFAULT comentarios_seq.NEXTVAL;
ALTER TABLE tags
MODIFY tag_id DEFAULT tags_seq.NEXTVAL;
ALTER TABLE categorias
MODIFY categoria_id DEFAULT categorias_seq.NEXTVAL;
