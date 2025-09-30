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

-- Sólo se permite cambiar el nombre de la categoria.
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