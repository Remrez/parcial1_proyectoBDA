DROP TABLE ARTICULO_CATEGORIAS CASCADE CONSTRAINTS;


CREATE TABLE ARTICULO_CATEGORIAS(
    articulo_id       NUMBER CONSTRAINT artcat_art_id_nn NOT NULL,
    categoria_id      NUMBER CONSTRAINT artcat_cat_id_nn NOT NULL,
    
    CONSTRAINT art_cat_pk PRIMARY KEY (articulo_id, categoria_id),
    CONSTRAINT artcat_articulo_id_fk FOREIGN KEY (articulo_id) REFERENCES articulos(articulo_id) ON DELETE CASCADE, 
    CONSTRAINT artcat_categoria_id_fk FOREIGN KEY (categoria_id) REFERENCES categorias(categoria_id) ON DELETE CASCADE
);
/