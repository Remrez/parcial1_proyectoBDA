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