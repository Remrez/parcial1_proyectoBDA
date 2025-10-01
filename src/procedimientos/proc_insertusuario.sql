create or replace PROCEDURE insert_usuario(
    us_name usuarios.user_name%TYPE,
    us_email usuarios.email%TYPE
)
IS
    opSql VARCHAR(255);
BEGIN
    opSql := 'INSERT INTO usuarios (user_name, email) VALUES (:name, :email)';
    EXECUTE IMMEDIATE opSql USING us_name, us_email;
    COMMIT;
END;
/