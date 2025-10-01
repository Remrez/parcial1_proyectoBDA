--Usuarios:
--    Que consulte los datos del usuario con user_name

CREATE OR REPLACE PROCEDURE sp_buscar_usuario_por_nombre (
    puser_name IN OUT VARCHAR2,
    puser_id OUT NUMBER,
    pemail OUT VARCHAR2
    )
IS
BEGIN
    SELECT u.user_id, u.email INTO puser_name, puser_id
    FROM usuarios u
    WHERE u.user_name = puser_name;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20000, 'ERROR: No se pudo encontrar el usuario con el nombre proporcionado: ' || puser_name);
END;
/