--Articulo:
--    Al consultar un titulo, que despliegue los datos del artículo 
--    y también los comentarios asociados a ese artículo

CREATE OR REPLACE PROCEDURE sp_buscar_articulo_por_titulo (
    p_titulo IN VARCHAR2,
    p_cursor OUT SYS_REFCURSOR -- Parámetro de SALIDA para el cursor
)
IS
BEGIN
    OPEN p_cursor FOR
        SELECT a.articulo_id, a.user_id, a.titulo, a.fecha_publicacion, a.article_text,
               c.user_id, c.texto_com
        FROM articulos a
        JOIN comentarios c ON a.articulo_id = c.articulo_id
        WHERE a.titulo = p_titulo;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20000, 'ERROR: No se pudo encontrar el articulo con el titulo proporcionado: ' || p_titulo);
END sp_buscar_articulo_por_titulo;
/