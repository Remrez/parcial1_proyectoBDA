CREATE OR REPLACE PROCEDURE insert_usuario(
    us_id usuarios.user_id%TYPE,
    us_name usuarios.user_name%TYPE,
    us_email usuarios.email%TYPE
)
IS
    opSql VARCHAR(255);
BEGIN
    opSql := 'INSERT INTO usuarios VALUES :user_id, :user_name, :email';
    EXECUTE IMMEDIATE opSql USING us_id, us_name, us_email;
END;

-- Recibe un booleano si se cambió el nombre o el email (o ambos)
CREATE OR REPLACE PROCEDURE update_usuario(
    us_id usuarios.user_id%TYPE,
    us_name usuarios.user_name%TYPE,
    us_email usuarios.email%TYPE,
    name_bool BOOLEAN,
    email_bool BOOLEAN
)
IS
    opSql VARCHAR(255);
BEGIN
    IF(name_bool) THEN
        opSql := 'UPDATE usuarios SET user_name = :us_name WHERE user_id = :us_id';
        EXECUTE IMMEDIATE opSql USING us_name, us_id;
    END IF;
    
    IF(email_bool) THEN
        opSql := 'UPDATE usuarios SET email = :email WHERE user_id = :us_id';
        EXECUTE IMMEDIATE opSql USING us_email, us_id;
    END IF;
END;

CREATE OR REPLACE PROCEDURE delete_usuario(
    us_id usuarios.user_id%TYPE
)
IS
    opSql VARCHAR(255);
BEGIN
    opSql := 'DELETE FROM usuarios WHERE user_id = :us_id';
    EXECUTE IMMEDIATE opSql USING us_id;
END;

