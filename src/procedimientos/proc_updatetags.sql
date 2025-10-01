CREATE OR REPLACE PROCEDURE update_tag(
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
/