DROP TABLE ARTICULO_CATEGORIAS CASCADE CONSTRAINTS;
DROP TABLE ARTICULO_TAGS CASCADE CONSTRAINTS;
DROP TABLE COMENTARIOS CASCADE CONSTRAINTS;
DROP TABLE ARTICULOS CASCADE CONSTRAINTS;
DROP TABLE CATEGORIAS CASCADE CONSTRAINTS;
DROP TABLE TAGS CASCADE CONSTRAINTS;
DROP TABLE USUARIOS CASCADE CONSTRAINTS;


CREATE TABLE USUARIOS(
  user_id       NUMBER        CONSTRAINT user_id_pk PRIMARY KEY,
  user_name     VARCHAR2(50)  CONSTRAINT user_name_nn NOT NULL, 
  email         VARCHAR2(100) CONSTRAINT email_nn NOT NULL
);

CREATE TABLE ARTICULOS(
  articulo_id       NUMBER       CONSTRAINT artiuclo_id_pk PRIMARY KEY,
  user_id           NUMBER       CONSTRAINT a_user_id_nn NOT NULL,--FK
  titulo            VARCHAR2(50) CONSTRAINT a_titulo_nn NOT NULL,
  fecha_publicacion DATE DEFAULT SYSDATE, 
  article_text      CLOB         CONSTRAINT a_text_nn NOT NULL,
  
  CONSTRAINT art_user_id_fk FOREIGN KEY (user_id) REFERENCES usuarios(user_id)
);

CREATE TABLE COMENTARIOS(
  comentario_id   NUMBER        CONSTRAINT comentario_id_pk PRIMARY KEY,
  articulo_id     NUMBER        CONSTRAINT co_art_id_nn NOT NULL,--FK
  user_id         NUMBER        CONSTRAINT co_user_id_nn NOT NULL,--FK
  texto_com       CLOB          CONSTRAINT co_texto_nn NOT NULL,
  --url_profile     VARCHAR2(100) CONSTRAINT co_url_nn NOT NULL,

  CONSTRAINT co_articulo_id_fk FOREIGN KEY (articulo_id) REFERENCES articulos(articulo_id),
  CONSTRAINT co_user_id_fk FOREIGN KEY (user_id) REFERENCES usuarios(user_id)
);

CREATE TABLE TAGS(
  tag_id        NUMBER       CONSTRAINT tag_name_pk PRIMARY KEY,
  tag_name      VARCHAR2(50) CONSTRAINT t_name_nn NOT NULL,
  url_tag      VARCHAR2(100) CONSTRAINT t_url_nn NOT NULL
);

CREATE TABLE CATEGORIAS(
  categoria_id      NUMBER        CONSTRAINT category_id_pk PRIMARY KEY,
  category_name     VARCHAR2(50)  CONSTRAINT ca_name_nn NOT NULL,
  url_cat           VARCHAR2(100) CONSTRAINT ca_url_nn NOT NULL
);

CREATE TABLE ARTICULO_TAGS(
  articulo_id    NUMBER CONSTRAINT artag_art_id_nn NOT NULL,
  tag_id         NUMBER CONSTRAINT artag_tag_id_nn NOT NULL,
  
  CONSTRAINT art_tag_pk PRIMARY KEY (articulo_id, tag_id),
  CONSTRAINT artag_articulo_id_fk FOREIGN KEY (articulo_id) REFERENCES articulos(articulo_id),
  CONSTRAINT artag_tag_id_fk FOREIGN KEY (tag_id) REFERENCES tags(tag_id)
);

CREATE TABLE ARTICULO_CATEGORIAS(
  articulo_id       NUMBER CONSTRAINT artcat_art_id_nn NOT NULL,
  categoria_id      NUMBER CONSTRAINT artcat_cat_id_nn NOT NULL,
  
  CONSTRAINT art_cat_pk PRIMARY KEY (articulo_id, categoria_id),
  CONSTRAINT artcat_articulo_id_fk FOREIGN KEY (articulo_id) REFERENCES articulos(articulo_id),
  CONSTRAINT artcat_categoria_id_fk FOREIGN KEY (categoria_id) REFERENCES categorias(categoria_id)
);

