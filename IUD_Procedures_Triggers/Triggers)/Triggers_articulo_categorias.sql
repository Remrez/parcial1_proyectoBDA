/*Triggers articulo_categoria*/
--Articulo
CREATE OR REPLACE TRIGGER articulosCat_IUD 
AFTER INSERT OR UPDATE OF articulo_id OR DELETE ON articulos
FOR EACH ROW
BEGIN
    if INSERTING THEN
        INSERT INTO articulo_categorias
        values (NEW.articulo_id);
        
    elsif UPDATING THEN
        UPDATE articulo_categorias
        SET articulo_id =: NEW.articulo_id
        where articulo_id =: OLD.articulo_id;
        
    elsif DELETING THEN
        DELETE FROM articulo_categoria
        where articulo_id =: old.articulo_id;
        
    else
        Raise_application_Error(-20999, 'No se pudo realizar ninguna operacion');
    
    END IF;
END;

--Categoria
CREATE OR REPLACE TRIGGER categoria_IUD
AFTER INSERT OR UPDATE OF categoria_id OR DELETE ON categorias
FOR EACH ROW
BEGIN

    if INSERTING THEN
        INSERT INTO articulo_categorias
        values (NEW.categoria_id);
        
    elsif UPDATING THEN
        UPDATE articulo_categorias
        SET categoria_id =: NEW.categoria_id
        where categoria_id =: OLD.categoria_id;
        
    elsif DELETING THEN
        DELETE FROM articulo_categoria
        where categoria_id =: old.categoria_id;
        
    else
        Raise_application_Error(-20999, 'No se pudo realizar ninguna operacion');
    
    END IF;
    
END;

