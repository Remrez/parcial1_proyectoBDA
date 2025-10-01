create or replace PROCEDURE delete_usuario(
    us_email usuarios.email%TYPE
)
IS
    opSql VARCHAR(255);
BEGIN
    opSql := 'DELETE FROM usuarios WHERE email = :us_email';
    EXECUTE IMMEDIATE opSql USING us_email;
    COMMIT;
END;
/