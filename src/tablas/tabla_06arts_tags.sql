DROP TABLE ARTICULO_TAGS CASCADE CONSTRAINTS;


CREATE TABLE ARTICULO_TAGS(
    articulo_id    NUMBER CONSTRAINT artag_art_id_nn NOT NULL,
    tag_id         NUMBER CONSTRAINT artag_tag_id_nn NOT NULL,
    
    CONSTRAINT art_tag_pk PRIMARY KEY (articulo_id, tag_id),
    CONSTRAINT artag_articulo_id_fk FOREIGN KEY (articulo_id) REFERENCES articulos(articulo_id) ON DELETE CASCADE,
    CONSTRAINT artag_tag_id_fk FOREIGN KEY (tag_id) REFERENCES tags(tag_id) ON DELETE CASCADE
);
/