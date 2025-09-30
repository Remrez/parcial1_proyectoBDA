CREATE OR REPLACE PROCEDURE insert_tag(
    tag_id tags.tag_id%TYPE,
    tag_name tags.tag_name%TYPE,
    url_tag tags.url_tag%TYPE
)
IS
    opSql VARCHAR(255);
BEGIN
    opSql := 'INSERT INTO tags VALUES :tag_id, :tag_name, :usrl_tag';
    EXECUTE IMMEDIATE opSql USING tag_id, tag_name, url_tag;
END;

-- Sólo se permite cambiar el nombre de la tag, no la URL para evitar problemas.
CREATE OR REPLACE PROCEDURE update_tag(
    tag_id tags.tag_id%TYPE,
    tag_name tags.tag_name%TYPE
)
IS
    opSql VARCHAR(255);
BEGIN
    opSql := 'UPDATE tags SET tag_name = :tag_name WHERE tag_id = :tag_id';
    EXECUTE IMMEDIATE opSql USING tag_name, tag_id;
END;

CREATE OR REPLACE PROCEDURE delete_tag(
    tag_id tags.tag_id%TYPE
)
IS
    opSql VARCHAR(255);
BEGIN
    opSql := 'DELETE FROM tags WHERE tag_id = :tag_id';
    EXECUTE IMMEDIATE opSql USING tag_id;
END;