/*Trigger articulo_tags*/
--TAGS
CREATE OR REPLACE TRIGGER TAGS_IUD
AFTER INSERT OR UPDATE OF tag_id OR DELETE ON tags
FOR EACH ROW
BEGIN

    if INSERTING THEN
        INSERT INTO articulo_tags
        values (NEW.tag_id);
        
    elsif UPDATING THEN
        UPDATE articulo_tags
        SET tag_id =: NEW.tag_id
        where tag_id =: OLD.tag_id;
        
    elsif DELETING THEN
        DELETE FROM articulo_tags
        where tag_id =: old.tag_id;
        
    else
        Raise_application_Error(-20999, 'No se pudo realizar ninguna operacion');
    
    END IF;
    
END;
--Articulo
CREATE OR REPLACE TRIGGER articuloTAG_IUD
AFTER INSERT OR UPDATE OF articulo_id OR DELETE ON articulos
FOR EACH ROW
BEGIN

    if INSERTING THEN
        INSERT INTO articulo_tags
        values (NEW.articulo_id);
        
    elsif UPDATING THEN
        UPDATE articulo_tags
        SET articulo_id =: NEW.articulo_id
        where articulo_id =: OLD.articulo_id;
        
    elsif DELETING THEN
        DELETE FROM articulo_tags
        where articulo_id =: old.articulo_id;
        
    else
        Raise_application_Error(-20999, 'No se pudo realizar ninguna operacion');
    
    END IF;
    
END;