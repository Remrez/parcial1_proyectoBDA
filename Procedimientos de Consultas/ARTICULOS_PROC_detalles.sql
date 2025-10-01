CREATE OR REPLACE PROCEDURE sp_get_articulos_detalle (
    p_datos_cursor OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_datos_cursor FOR
        SELECT a.articulo_id, a.user_id, a.titulo, a.article_text, u.user_name
        FROM articulos a
        JOIN usuarios u ON a.user_id = u.user_id
        ORDER BY a.articulo_id;
END sp_get_articulos_detalle;
/