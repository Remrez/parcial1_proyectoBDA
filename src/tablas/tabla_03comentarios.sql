DROP TABLE COMENTARIOS CASCADE CONSTRAINTS;
DROP SEQUENCE comentarios_seq;


CREATE TABLE COMENTARIOS(
    comentario_id   NUMBER        CONSTRAINT comentario_id_pk PRIMARY KEY,
    articulo_id     NUMBER        CONSTRAINT co_art_id_nn NOT NULL,--FK
    user_id         NUMBER        CONSTRAINT co_user_id_nn NOT NULL,--FK
    texto_com       CLOB          CONSTRAINT co_texto_nn NOT NULL,
    
    CONSTRAINT co_articulo_id_fk FOREIGN KEY (articulo_id) REFERENCES articulos(articulo_id) ON DELETE CASCADE,
    CONSTRAINT co_user_id_fk FOREIGN KEY (user_id) REFERENCES usuarios(user_id) ON DELETE CASCADE
);

CREATE SEQUENCE comentarios_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE;
ALTER TABLE comentarios
MODIFY comentario_id DEFAULT comentarios_seq.NEXTVAL;
/