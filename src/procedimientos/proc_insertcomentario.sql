CREATE OR REPLACE PROCEDURE insert_comentario(
    articulo_id comentarios.articulo_id%TYPE,
    user_id comentarios.user_id%TYPE,
    texto_com comentarios.texto_com%TYPE
)
IS
    opSql VARCHAR(255);
BEGIN
    opSql := 'INSERT INTO comentarios (articulo_id, user_id, texto_com) VALUES (:articulo_id, :user_id, :texto_com)';
    EXECUTE IMMEDIATE opSql USING articulo_id, user_id, texto_com;
    COMMIT;
END;
/