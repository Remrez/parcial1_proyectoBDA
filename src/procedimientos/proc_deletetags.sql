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
/