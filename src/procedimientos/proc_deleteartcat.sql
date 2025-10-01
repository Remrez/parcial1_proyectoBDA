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