DROP TABLE ARTICULOS CASCADE CONSTRAINTS;
DROP SEQUENCE articulos_seq;


CREATE TABLE ARTICULOS(
    articulo_id       NUMBER       CONSTRAINT artiuclo_id_pk PRIMARY KEY,
    user_id           NUMBER       CONSTRAINT a_user_id_nn NOT NULL,--FK
    titulo            VARCHAR2(50) CONSTRAINT a_titulo_nn NOT NULL,
    fecha_publicacion DATE DEFAULT SYSDATE, 
    article_text      CLOB         CONSTRAINT a_text_nn NOT NULL,
    
    CONSTRAINT art_user_id_fk FOREIGN KEY (user_id) REFERENCES usuarios(user_id) ON DELETE CASCADE
);
CREATE SEQUENCE articulos_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

ALTER TABLE articulos
MODIFY articulo_id DEFAULT articulos_seq.NEXTVAL;
/