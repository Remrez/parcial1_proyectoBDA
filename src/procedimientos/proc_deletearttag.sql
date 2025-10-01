CREATE OR REPLACE PROCEDURE delete_art_tag(
    p_articulo_id articulo_tags.articulo_id%TYPE,
    p_tag_id articulo_tags.tag_id%TYPE
)
IS
    opSql VARCHAR(255);
BEGIN
    opSql := 'DELETE FROM articulo_tags WHERE articulo_id = :p_articulo_id OR tag_id = :p_tag_id';
    EXECUTE IMMEDIATE opSql USING p_articulo_id, p_tag_id;
    COMMIT;
END;
/