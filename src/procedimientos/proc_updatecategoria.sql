CREATE OR REPLACE PROCEDURE update_categoria(
    or_category_name categorias.category_name%TYPE,
    category_name categorias.category_name%TYPE,
    purl categorias.url_cat%TYPE
)
IS
    opSql VARCHAR(255);
BEGIN
    opSql := 'UPDATE categorias SET category_name = :category_name, url_cat = :purl_cat WHERE category_name = :or_categoria_name';
    EXECUTE IMMEDIATE opSql USING category_name, purl, or_category_name;
    COMMIT;
END;
/