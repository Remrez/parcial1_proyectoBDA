/*
Procedimientos necesarios:
Se van a manejar la inserción, actualización y elmininación en
un solo procedimiento por tabla c:
NOTA:  CLOB es un tipo de dato de texto de gran capacidad

Users:
    CAMPOS:
        user_id(Number), user_name(Varchar2(50)), email(Varchar2(100))

Articulos:
    CAMPOS:
        articulo_id(Number), user_id(Number), titulo(varchar(50)), 
        fecha_publicación(date), article_text(clob)


COMENTARIOS:
    CAMPOS:
        comentario_id(Number), articulo_id(number),
        user_id(number), texto_com(CLOB)

TAGS:
    CAMPOS:
        tag_id(Number), tag_name(varchar2(50))

CATEGORIAS:
    CAMPOS:
        categoria_id(Number),category_name(Varchar2(50))

ARTICULO_TAGS:
    CAMPOS:
        articulo_id(NUMBER), tag_id(Number)

ARTICULO_CATEGORIAS:
    CAMPOS:
        articulo_id(Number), categoria_id(Number)


FUNCIONES NECESARIAS:
Usuarios:
    Que consulte los datos del usuario con user_name

Articulo:
    Al consultar un titulo, que despliegue los datos del artículo 
    y también los comentarios asociados a ese artículo

Tags:
    Al consultar un nombre de tag, que haga una consulta hacia ARTICULO_TAGS, 
    que tome el artículo_id y con eso, consultar artículos y desplegar todos los
    títulos de artículos con ese tag

Categoría:
    Al consultar category_name que use categoria_id en ARTICULO_CATEGORIAS
    para consultar todos los articulo_id asociados a esa categoría
    y despliegue los titulos
/*