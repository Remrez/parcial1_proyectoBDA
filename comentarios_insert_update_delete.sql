CREATE OR REPLACE PROCEDURE insert_comentario(
    comentario_id comentarios.comentario_id%TYPE,
    articulo_id comentarios.articulo_id%TYPE,
    user_id comentarios.user_id%TYPE,
    texto_com comentarios.texto_com%TYPE
)
IS
    opSql VARCHAR(255);
BEGIN
    opSql := 'INSERT INTO comentarios VALUES :comentario_id, :articulo_id, :user_id, :texto_com';
    EXECUTE IMMEDIATE opSql USING comentario_id, articulo_id, user_id, texto_com;
END;

-- Sólo se permite cambiar el texto del comentario.
CREATE OR REPLACE PROCEDURE update_comentario(
    comentario_id comentarios.comentario_id%TYPE,
    texto_com comentarios.texto_com%TYPE
)
IS
    opSql VARCHAR(255);
BEGIN
    opSql := 'UPDATE comentarios SET texto_com = :texto_com WHERE comentario_id = :comentario_id';
    EXECUTE IMMEDIATE opSql USING texto_com, comentario_id;
END;

CREATE OR REPLACE PROCEDURE delete_comentario(
    comentario_id comentarios.comentario_id%TYPE
)
IS
    opSql VARCHAR(255);
BEGIN
    opSql := 'DELETE FROM comentarios WHERE comentario_id = :comentario_id';
    EXECUTE IMMEDIATE opSql USING comentario_id;
END;