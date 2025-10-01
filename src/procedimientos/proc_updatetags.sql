CREATE OR REPLACE PROCEDURE update_tag(
    or_tag_name tags.tag_name%TYPE,
    tag_name tags.tag_name%TYPE
)
IS
    opSql VARCHAR(255);
BEGIN
    opSql := 'UPDATE tags SET tag_name = :tag_name WHERE tag_name = :or_tag_name';
    EXECUTE IMMEDIATE opSql USING tag_name, or_tag_name;
    COMMIT;
END;
/