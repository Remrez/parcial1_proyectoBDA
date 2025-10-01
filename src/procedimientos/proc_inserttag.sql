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
/