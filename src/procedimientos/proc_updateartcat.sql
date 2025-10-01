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