import cx_Oracle

try:
    conn = cx_Oracle.connect("blog", "blog", "localhost:1521/xepdb1")
except Exception as err:
    print('excepcion ocurrida durante la conexion', err)
else:
    try:
        cur = conn.cursor()
        usuarios = [
                ('Carlos Mendoza', 'carlos.mendoza@example.com'),
                ('María López', 'maria.lopez@example.com'),
                ('Juan Pérez', 'juan.perez@example.com'),
                ('Ana Castillo', 'ana.castillo@example.com'),
                ('Luis Hernández', 'luis.hernandez@example.com'),
                ('Paola Ramírez', 'paola.ramirez@example.com'),
                ('Andrés Torres', 'andres.torres@example.com'),
                ('Sofía Navarro', 'sofia.navarro@example.com'),
                ('Ricardo Gutiérrez', 'ricardo.gutierrez@example.com'),
                ('Elena Vargas', 'elena.vargas@example.com')
            ]
        
        tags = [
            ('tecnologia', 'www.blogtech.com/tecnologia'),
            ('ciberseguridad', 'www.seguridadonline.com/articulos'),
            ('programacion', 'www.devworld.com/tutoriales'),
            ('futbol', 'www.deportes.com/futbol'),
            ('videojuegos', 'www.gamershub.com/news'),
            ('educacion', 'www.educacionhoy.com/cursos'),
            ('noticias', 'www.mundonoticias.com/ultimas'),
            ('cocina', 'www.recetasychef.com/blog'),
            ('viajes', 'www.viajerosglobal.com/guias'),
            ('economia', 'www.finanzasfacil.com/reportes')
        ]

        categoria = [
            ('Tecnología', 'www.tecnologia.com'),
            ('Ciberseguridad', 'www.ciberseguridad.com'),
            ('Programación', 'www.programacion.com'),
            ('Ciencia', 'www.ciencia.com'),
            ('Videojuegos', 'www.videojuegos.com'),
            ('Educación', 'www.educacion.com'),
            ('Salud', 'www.salud.com'),
            ('Finanzas', 'www.finanzas.com'),
            ('Deportes', 'www.deportes.com'),
            ('Cocina', 'www.cocina.com')
        ]

        articulo = [
            (1, 'Introducción a la Programación en Python', 'En este artículo aprenderás las bases de Python, desde variables hasta estructuras de control.'),
            (2, 'Conceptos Básicos de Ciberseguridad', 'Exploramos los principios fundamentales para proteger tus sistemas y datos.'),
            (3, 'Guía de Diseño de Bases de Datos Relacionales', 'Te mostramos cómo modelar y estructurar correctamente tus datos.'),
            (4, 'Patrones de Diseño en el Desarrollo de Software', 'Un recorrido por los patrones más utilizados y sus casos de uso.'),
            (5, 'Introducción al Aprendizaje Automático', 'Descubre qué es el machine learning y cómo se aplica en la industria.'),
            (6, 'Seguridad en Redes: Buenas Prácticas', 'Aprende cómo proteger tu red con estrategias modernas de seguridad.'),
            (7, 'Optimización de Consultas SQL', 'Consejos para mejorar el rendimiento de tus bases de datos.'),
            (8, 'Inteligencia Artificial en Videojuegos', 'Exploramos cómo la IA mejora la experiencia de juego.'),
            (9, 'Guía Completa sobre APIs REST', 'Aprende a diseñar, implementar y consumir APIs de forma eficiente.'),
            (10, 'Introducción a Docker y Contenedores', 'Una guía básica para comenzar a trabajar con contenedores en entornos de desarrollo.')
        ]

        comentario = [
            (1, 5, 'Muy interesante el artículo, me ayudó a entender mejor el tema.'),
            (2, 3, 'Creo que podrías profundizar más en la parte de seguridad, pero en general está bien explicado.'),
            (3, 7, 'Excelente explicación, fue fácil de seguir y muy útil para principiantes.'),
            (4, 2, 'No había considerado ese enfoque, gracias por compartirlo.'),
            (5, 8, 'Estoy de acuerdo con tus conclusiones, aportan una perspectiva clara sobre el tema.'),
            (6, 1, 'La parte final del artículo me pareció especialmente útil para mi proyecto.'),
            (7, 4, 'Buen trabajo, aunque creo que podrías incluir algunos ejemplos más técnicos.'),
            (8, 6, 'Me gustó mucho la forma en que estructuraste el contenido, fue muy fácil de entender.'),
            (9, 10, 'Definitivamente este artículo aclara muchas dudas que tenía, gracias.'),
            (10, 9, 'Una lectura muy interesante, espero que sigas publicando artículos similares.'),
            (1, 2, 'Me encantó cómo abordaste el tema desde diferentes perspectivas.'),
            (2, 4, 'La explicación fue clara y directa, justo lo que necesitaba.'),
            (3, 5, 'Podrías agregar algunas referencias externas para complementar la información.'),
            (4, 6, 'Gracias por compartir, me resultó muy útil para mi trabajo universitario.'),
            (5, 7, 'Creo que podrías mejorar la redacción en algunas partes, pero el contenido es bueno.'),
            (6, 8, 'Muy buen artículo, se nota el esfuerzo en la investigación.'),
            (7, 9, 'No estaba familiarizado con este tema y ahora tengo una mejor comprensión.'),
            (8, 10, 'Interesante punto de vista, aunque difiero en algunos aspectos.'),
            (9, 1, 'Gracias por compartir esta información, la pondré en práctica.'),
            (10, 3, 'La sección de ejemplos fue mi parte favorita, muy bien explicada.'),
            (1, 6, 'Excelente contenido, ojalá publiques más artículos como este.'),
            (2, 7, 'Considero que podrías incluir gráficos o diagramas para facilitar la comprensión.'),
            (3, 8, 'Me pareció muy interesante la conclusión, muy bien argumentada.'),
            (4, 9, 'Aunque es un tema complejo, lograste explicarlo de forma sencilla.'),
            (5, 10, 'Este artículo responde muchas de las preguntas que tenía, gracias.'),
            (6, 2, 'La información es actual y relevante, muy buen trabajo.'),
            (7, 3, 'Tal vez podrías agregar más casos prácticos, pero en general es excelente.'),
            (8, 4, 'Me gustó la estructura del artículo, todo está bien organizado.'),
            (9, 5, 'Nunca había leído algo tan completo sobre el tema, felicidades.'),
            (10, 8, 'Muy informativo, definitivamente lo recomendaré a mis compañeros.')
        ]

        for nombre, correo in usuarios:
            cur.callproc('INSERT_USUARIO', (nombre, correo))

        for tag, url in tags:
            cur.callproc('INSERT_TAG', (tag, url))

        for cat, url in categoria:
            cur.callproc('INSERT_CATEGORIA', (cat, url))

        for IdUsr, NomArt, descripcion in articulo:
            cur.callproc('INSERT_ARTICULO', (IdUsr, NomArt, descripcion))
    
        for artId, usId, texto in comentario:
            cur.callproc('INSERT_COMENTARIO', (artId, usId, texto))

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