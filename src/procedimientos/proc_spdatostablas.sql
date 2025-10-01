CREATE OR REPLACE PROCEDURE sp_datos_tablas (
    p_tabla        IN  VARCHAR2,
    p_datos_cursor OUT SYS_REFCURSOR
)
IS
    v_sql VARCHAR2(1000);
BEGIN
    v_sql := 'SELECT * FROM ' || UPPER(p_tabla);

    OPEN p_datos_cursor FOR v_sql;

EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20000,
            'ERROR: No se pudo recuperar datos de la tabla ' || p_tabla || 
            '. Detalle: ' || SQLERRM);
END;
/