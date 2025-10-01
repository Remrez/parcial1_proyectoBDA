CREATE OR REPLACE PROCEDURE update_art_tag(
    p_articulo_id articulo_tags.articulo_id%TYPE,
    p_tag_id articulo_tags.tag_id%TYPE,
    art_act NUMBER,
    tag_act NUMBER
)
IS
    opSql VARCHAR(255);
BEGIN
    IF(art_act = 1) THEN
        opSql := 'UPDATE articulo_tags SET articulo_id = :p_articulo_id WHERE articulo_id = :p_articulo_id';
        EXECUTE IMMEDIATE opSql USING p_articulo_id;
    END IF;
    
    IF(tag_act = 1) THEN
        opSql := 'UPDATE articulo_tags SET tag_id = :p_tag_id WHERE tag_id = :p_tag_id';
        EXECUTE IMMEDIATE opSql USING p_tag_id;
    END IF;
    COMMIT;
END;
/