DROP TABLE CATEGORIAS CASCADE CONSTRAINTS;
DROP SEQUENCE categorias_seq;

CREATE TABLE CATEGORIAS(
    categoria_id      NUMBER        CONSTRAINT category_id_pk PRIMARY KEY,
    category_name     VARCHAR2(50)  CONSTRAINT ca_name_nn NOT NULL,
    url_cat           VARCHAR2(100) CONSTRAINT ca_url_nn NOT NULL
);
ALTER TABLE CATEGORIAS
ADD CONSTRAINT categoria_nm_un UNIQUE(category_name);

CREATE SEQUENCE categorias_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

ALTER TABLE categorias
MODIFY categoria_id DEFAULT categorias_seq.NEXTVAL;
/