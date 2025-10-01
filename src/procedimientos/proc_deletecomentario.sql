CREATE OR REPLACE PROCEDURE delete_comentario(
    comentario_id comentarios.comentario_id%TYPE
)
IS
    opSql VARCHAR(255);
BEGIN
    opSql := 'DELETE FROM comentarios WHERE comentario_id = :comentario_id';
    EXECUTE IMMEDIATE opSql USING comentario_id;
    COMMIT;
END;
/