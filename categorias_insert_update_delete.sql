CREATE OR REPLACE PROCEDURE insert_categoria(
    categoria_id categorias.categoria_id%TYPE,
    category_name categorias.category_name%TYPE,
    url_cat categorias.url_cat%TYPE
)
IS
    opSql VARCHAR(255);
BEGIN
    opSql := 'INSERT INTO categorias VALUES :categoria_id, :category_name, :url_cat';
    EXECUTE IMMEDIATE opSql USING categoria_id, category_name, url_cat;
END;

-- Sólo se permite cambiar el nombre de la categoria.
CREATE OR REPLACE PROCEDURE update_categoria(
    categoria_id categorias.categoria_id%TYPE,
    category_name categorias.category_name%TYPE
)
IS
    opSql VARCHAR(255);
BEGIN
    opSql := 'UPDATE categorias SET category_name = :category_name WHERE categoria_id = :categoria_id';
    EXECUTE IMMEDIATE opSql USING categoria_id, category_name;
END;

CREATE OR REPLACE PROCEDURE delete_categoria(
    categoria_id categorias.categoria_id%TYPE
)
IS
    opSql VARCHAR(255);
BEGIN
    opSql := 'DELETE FROM categorias WHERE categoria_id = :categoria_id';
    EXECUTE IMMEDIATE opSql USING categoria_id;
END;