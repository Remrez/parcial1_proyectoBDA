CREATE OR REPLACE PROCEDURE insert_categoria(
    category_name categorias.category_name%TYPE,
    url_cat categorias.url_cat%TYPE
)
IS
    opSql VARCHAR(255);
BEGIN
    opSql := 'INSERT INTO categorias(category_name, url_cat) VALUES (:category_name, :url_cat)';
    EXECUTE IMMEDIATE opSql USING category_name, url_cat;
    COMMIT;
END;
/