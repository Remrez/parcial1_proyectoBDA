-- =====================================================================
-- SCRIPT MAESTRO DE INSTALACIÓN - PROYECTO BLOG
-- ---------------------------------------------------------------------
-- único archivo para crear o recrear toda la base de datos.
-- =====================================================================

-- mensajes en la consola para ver el progreso.
PROMPT *** INICIANDO LA CREACIÓN DEL ESQUEMA DEL BLOG ***

-- ---------------------------------------------------------------------
-- PASO 1: CREACIÓN DE TABLAS Y SECUENCIAS
-- ---------------------------------------------------------------------
-- Se ejecutan los scripts de la carpeta /src/tablas en orden.
-- ---------------------------------------------------------------------

PROMPT ... 1. Creando esquemas (tablas y secuencias)...
@@src/tablas/tabla_01usuario.sql
@@src/tablas/tabla_02articulos.sql
@@src/tablas/tabla_03comentarios.sql
@@src/tablas/tabla_04tags.sql
@@src/tablas/tabla_05categorias.sql
@@src/tablas/tabla_07arts_categorias.sql
@@src/tablas/tabla_06arts_tags.sql


-- ---------------------------------------------------------------------
-- PASO 2: CREACIÓN DE PROCEDIMIENTOS ALMACENADOS
-- ---------------------------------------------------------------------
-- Ahora que las tablas existen, se crean los procedimientos.
-- ---------------------------------------------------------------------

PROMPT ... 2. Creando todos los procedimientos almacenados...

-- Procedimientos Genéricos (GET)
PROMPT ...... Creando procedimientos GET...
@@src/procedimientos/proc_spdatostablas.sql
@@src/procedimientos/proc_spgetarticulosdetalles.sql
@@src/procedimientos/proc_spgetcomentariosdetalles.sql

-- Procedimientos de Inserción (INSERT)
PROMPT ...... Creando procedimientos INSERT...
@@src/procedimientos/proc_insertusuario.sql
@@src/procedimientos/proc_insertarticulos.sql
@@src/procedimientos/proc_insertcategoria.sql
@@src/procedimientos/proc_insertcomentario.sql
@@src/procedimientos/proc_inserttag.sql
@@src/procedimientos/proc_insertarttag.sql
@@src/procedimientos/proc_insertartcat.sql

-- Procedimientos de Actualización (UPDATE)
PROMPT ...... Creando procedimientos UPDATE...
@@src/procedimientos/proc_updateusuario.sql
@@src/procedimientos/proc_updatecategoria.sql
@@src/procedimientos/proc_updatetags.sql
@@src/procedimientos/proc_updateartcat.sql
@@src/procedimientos/proc_updatearttag.sql

-- Procedimientos de Eliminación (DELETE)
PROMPT ...... Creando procedimientos DELETE...
@@src/procedimientos/proc_deleteusuario.sql
@@src/procedimientos/proc_deletearticulos.sql
@@src/procedimientos/proc_deletecategoria.sql
@@src/procedimientos/proc_deletecomentario.sql
@@src/procedimientos/proc_deletetags.sql
@@src/procedimientos/proc_deleteartcat.sql
@@src/procedimientos/proc_deletearttag.sql



PROMPT *** INSTALACIÓN DEL ESQUEMA FINALIZADA CORRECTAMENTE ***
