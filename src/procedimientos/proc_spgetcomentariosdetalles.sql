CREATE OR REPLACE PROCEDURE sp_get_comentarios_detalle (
    p_datos_cursor OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_datos_cursor FOR
        SELECT c.comentario_id, c.articulo_id, c.user_id, c.texto_com,
               a.titulo AS titulo_articulo, u.user_name
        FROM comentarios c
        JOIN articulos a ON c.articulo_id = a.articulo_id
        JOIN usuarios u ON c.user_id = u.user_id
        ORDER BY c.comentario_id;
END sp_get_comentarios_detalle;
/