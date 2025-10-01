CREATE OR REPLACE PROCEDURE update_categoria(
    or_category_name categorias.category_name%TYPE,
    category_name categorias.category_name%TYPE
)
IS
    opSql VARCHAR(255);
BEGIN
    opSql := 'UPDATE categorias SET category_name = :category_name WHERE category_name = :or_categoria_name';
    EXECUTE IMMEDIATE opSql USING category_name, or_category_name;
    COMMIT;
END;
/