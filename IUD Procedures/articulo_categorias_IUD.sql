--Procedimiento IUD de articulo_categorias
CREATE OR REPLACE PROCEDURE insert_art_cat(
    p_articulo_id articulo_categorias.articulo_id%TYPE,
    p_categoria_id articulo_categorias.categoria_id%TYPE
)
IS
    opSql VARCHAR(255);
BEGIN
    opSql := 'INSERT INTO articulo_categorias(articulo_id, categoria_id) VALUES (:p_articulo_id, :p_categoria_id)';
    EXECUTE IMMEDIATE opSql USING p_articulo_id, p_categoria_id;
    COMMIT;
END;
/

-- Recibe un booleano si se cambió el título o texto del artículo (o ambos)
CREATE OR REPLACE PROCEDURE update_art_cat(
    p_articulo_id articulo_categorias.articulo_id%TYPE,
    p_categoria_id articulo_categorias.categoria_id%TYPE,
    art_act NUMBER,
    cat_act NUMBER
)
IS
    opSql VARCHAR(255);
BEGIN
    IF(art_act = 1) THEN
        opSql := 'UPDATE articulo_categorias SET articulo_id = :p_articulo_id WHERE articulo_id = :p_articulo_id';
        EXECUTE IMMEDIATE opSql USING p_articulo_id;
    END IF;
    
    IF(cat_act = 1) THEN
        opSql := 'UPDATE articulo_categorias SET categoria_id = :p_categoria_id WHERE categoria_id = :p_categoria_id';
        EXECUTE IMMEDIATE opSql USING p_categoria_id;
    END IF;
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE delete_art_cat(
    p_articulo_id articulo_categorias.articulo_id%TYPE,
    p_categoria_id articulo_categorias.categoria_id%TYPE
)
IS
    opSql VARCHAR(255);
BEGIN
    opSql := 'DELETE FROM articulo_categorias WHERE articulo_id = :p_articulo_id OR categoria_id =:p_categoria_id';
    EXECUTE IMMEDIATE opSql USING p_articulo_id, p_categoria_id;
    COMMIT;
END;
/
