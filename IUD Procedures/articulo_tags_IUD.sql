--Procedimiento IUD de articulo_tags
CREATE OR REPLACE PROCEDURE insert_art_tag(
    p_articulo_id articulo_tags.articulo_id%TYPE,
    p_tag_id articulo_tags.tag_id%TYPE
)
IS
    opSql VARCHAR(255);
BEGIN
    opSql := 'INSERT INTO articulo_tags(articulo_id, tag_id) VALUES (:p_articulo_id, :p_tag_id)';
    EXECUTE IMMEDIATE opSql USING p_articulo_id, p_tag_id;
    COMMIT;
END;
/

-- Recibe un booleano si se cambió el título o texto del artículo (o ambos)
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