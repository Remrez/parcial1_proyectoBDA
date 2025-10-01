CREATE OR REPLACE PROCEDURE insert_articulo(
    user_id articulos.user_id%TYPE,
    titulo articulos.titulo%TYPE,
    article_text articulos.article_text%TYPE
)
IS
    opSql VARCHAR(255);
BEGIN
    opSql := 'INSERT INTO articulos(user_id, titulo, article_text) VALUES (:user_id, :titulo, :article_text)';
    EXECUTE IMMEDIATE opSql USING user_id, titulo, article_text;
    COMMIT;
END;
/