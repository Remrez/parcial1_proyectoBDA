CREATE OR REPLACE PROCEDURE insert_articulo(
    articulo_id articulos.articulo_id%TYPE,
    user_id articulos.user_id%TYPE,
    titulo articulos.titulo%TYPE,
    fecha_publicacion articulos.fecha_publicacion%TYPE,
    article_text articulos.article_text%TYPE
)
IS
    opSql VARCHAR(255);
BEGIN
    opSql := 'INSERT INTO articulos VALUES :articulo_id, :user_id, :titulo, :fecha_publicacion, :article_text';
    EXECUTE IMMEDIATE opSql USING articulo_id, user_id, titulo, fecha_publicacion, article_text;
END;

-- Recibe un booleano si se cambió el título o texto del artículo (o ambos)
CREATE OR REPLACE PROCEDURE update_articulo(
    articulo_id articulos.articulo_id%TYPE,
    titulo articulos.titulo%TYPE,
    article_text articulos.article_text%TYPE,
    titulo_bool BOOLEAN,
    text_bool BOOLEAN
)
IS
    opSql VARCHAR(255);
BEGIN
    IF(titulo_bool) THEN
        opSql := 'UPDATE articulos SET titulo = :titulo WHERE articulo_id = :articulo_id';
        EXECUTE IMMEDIATE opSql USING titulo, articulo_id;
    END IF;
    
    IF(text_bool) THEN
        opSql := 'UPDATE articulos SET article_text = :article_text WHERE articulo_id = :articulo_id';
        EXECUTE IMMEDIATE opSql USING article_text, articulo_id;
    END IF;
END;

CREATE OR REPLACE PROCEDURE delete_articulos(
    articulo_id articulos.articulo_id%TYPE
)
IS
    opSql VARCHAR(255);
BEGIN
    opSql := 'DELETE FROM articulos WHERE articulo_id = :articulo_id';
    EXECUTE IMMEDIATE opSql USING articulo_id;
END;