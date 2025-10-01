CREATE OR REPLACE PROCEDURE delete_categoria(
    category_name categorias.category_name%TYPE
)
IS
    opSql VARCHAR(255);
BEGIN
    opSql := 'DELETE FROM categorias WHERE category_name = :categoria_name';
    EXECUTE IMMEDIATE opSql USING category_name;
    COMMIT;
END;
/