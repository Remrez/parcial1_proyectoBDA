/*
Tags:
    Al consultar un nombre de tag, que haga una consulta hacia ARTICULO_TAGS, 
    que tome el artículo_id y con eso, consultar artículos y desplegar todos los
    títulos de artículos con ese tag*/

CREATE OR REPLACE PROCEDURE sp_buscar_articulos_por_tagname(
    ptag_name IN VARCHAR2,
    particulos_cursor OUT SYS_REFCURSOR
    )
IS
BEGIN
    OPEN particulos_cursor FOR
        SELECT articulo_id, user_id, titulo, fecha_publicacion, article_text
        FROM tags
            JOIN articulo_tags USING (tag_id)
            JOIN articulos USING(articulo_id)
        WHERE tag_name = ptag_name;
        
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20000, 'ERROR: No se pudo encontrar el tag con el nombre proporcionado: ' || ptag_name);
END;
/
