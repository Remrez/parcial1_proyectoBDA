/*Categoría:
    Al consultar category_name que use categoria_id en ARTICULO_CATEGORIAS
    para consultar todos los articulo_id asociados a esa categoría
    y despliegue los titulos
*/

CREATE OR REPLACE PROCEDURE sp_buscar_articulos_por_categoria(
    pcategory_name IN VARCHAR2,
    titulosDeArticulos_cursor OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN titulosDeArticulos_cursor FOR
        SELECT articulo_id, titulo
        FROM categorias
            JOIN articulo_categorias USING(categoria_id)
            JOIN articulos USING (articulo_id)
        WHERE category_name = pcategory_name;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20000, 'ERROR: No se pudo encontrar la categoría con el nombre proporcionado: ' || pcategory_name);
END;
/
