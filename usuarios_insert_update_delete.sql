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

-- Recibe un booleano si se cambió el nombre o el email (o ambos)
create or replace PROCEDURE update_usuario(
    or_email usuarios.email%TYPE,
    us_name usuarios.user_name%TYPE,
    us_email usuarios.email%TYPE,
    name_bool NUMBER,
    email_bool NUMBER
)
IS
    p_user_id usuarios.user_id%TYPE;
    opSql VARCHAR(255);
BEGIN
    SELECT user_id INTO p_user_id
    FROM usuarios
    WHERE email = or_email;

    IF(name_bool = 1) THEN
        opSql := 'UPDATE usuarios SET user_name = :us_name WHERE user_id = :us_id';
        EXECUTE IMMEDIATE opSql USING us_name, p_user_id;
    END IF;
    
    IF(email_bool = 1) THEN
        opSql := 'UPDATE usuarios SET email = :email WHERE user_id = :us_id';
        EXECUTE IMMEDIATE opSql USING us_email, p_user_id;
    END IF;
    COMMIT;
END;

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
