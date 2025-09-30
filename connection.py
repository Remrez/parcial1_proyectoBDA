import cx_Oracle

try:
    conn = cx_Oracle.connect("blog", "blog", "localhost:1521/xepdb1")
except Exception as err:
    print('excepcion ocurrida durante la conexion', err)
else:
    try:
        cur = conn.cursor()
        #cur.callproc('INSERT_USUARIO','pepitas', 'hola@gmail.com'))
        #cur.callproc('UPDATE_USUARIO',('hola@gmail.com','peps', 'hElOO@gmail.com', 1, 1))
        #cur.callproc('DELETE_USUARIO',['hElOO@gmail.com'])
        #cur.callproc('INSERT_TAG',('reglas', 'www.futbol/reglas.com'))
        #cur.callproc('UPDATE_TAG',('reglas', 'rules'))
        #cur.callproc('DELETE_TAG',['rules'])
        #cur.callproc('INSERT_ARTICULO',(6, 'Introducción a las Bases de Datos Oracle', 'En este artículo exploraremos los conceptos básicos...'))
        #cur.callproc('UPDATE_ARTICULO',(1, 'Introducción', 'En este artículo exploraremos...', 1, 1))
        #cur.callproc('DELETE_ARTICULOS',[1])
        #cur.callproc('INSERT_CATEGORIA',('Futbol', 'www.futbol.com'))
        #cur.callproc('UPDATE_CATEGORIA',('Futbol', 'fusho'))
        #cur.callproc('DELETE_CATEGORIA',['fusho'])
    except Exception as err:
        print('error en la insercion', err)
    else:
        print('Procedimiento ejecutado')
    finally:
        cur.close()
# finally: 
#     conn.close()