CREATE OR REPLACE PROCEDURE insert_tag(
    tag_name tags.tag_name%TYPE,
    url_tag tags.url_tag%TYPE
)
IS
    opSql VARCHAR(255);
BEGIN
    opSql := 'INSERT INTO tags (tag_name, url_tag) VALUES (:tag_name, :usrl_tag)';
    EXECUTE IMMEDIATE opSql USING tag_name, url_tag;
    COMMIT;
END;

-- Sólo se permite cambiar el nombre de la tag, no la URL para evitar problemas.
create or replace PROCEDURE update_tag(
    or_tag_name tags.tag_name%TYPE,
    tag_name tags.tag_name%TYPE,
    purl_tag tags.url_tag%TYPE
)
IS
    opSql VARCHAR(255);
BEGIN
    opSql := 'UPDATE tags SET url_tag = :purl_tag, tag_name = :tag_name WHERE tag_name = :or_tag_name';
    EXECUTE IMMEDIATE opSql USING purl_tag, tag_name, or_tag_name;
    COMMIT;
END;

CREATE OR REPLACE PROCEDURE delete_tag(
    tag_nm tags.tag_name%TYPE
)
IS
    opSql VARCHAR(255);
BEGIN
    opSql := 'DELETE FROM tags WHERE tag_name = :tag_name';
    EXECUTE IMMEDIATE opSql USING tag_nm;
    COMMIT;
END;