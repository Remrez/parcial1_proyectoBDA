CREATE OR REPLACE PROCEDURE delete_articulos(
    articulo_id articulos.articulo_id%TYPE
)
IS
    opSql VARCHAR(255);
BEGIN
    opSql := 'DELETE FROM articulos WHERE articulo_id = :articulo_id';
    EXECUTE IMMEDIATE opSql USING articulo_id;
    COMMIT;
END;
/