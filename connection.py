from flask import Flask, request, jsonify
from flask_cors import CORS
import oracledb
import os

app = Flask(__name__)
CORS(app)

# --- Configuración del Pool de Conexiones ---
try:
    pool = oracledb.create_pool(
        user="blog", password="blog", dsn="localhost:1521/xepdb1",
        min=2, max=5, increment=1
    )
    print("Pool de conexiones creado exitosamente.")
except oracledb.Error as e:
    print(f"Error al crear el pool de conexiones: {e}")
    pool = None

def get_db_connection():
    if not pool: return None
    try:
        return pool.acquire()
    except oracledb.Error as e:
        print(f"Error al obtener conexión del pool: {e}")
        return None

# --- Endpoints para Usuarios ---
@app.route('/api/usuarios', methods=['GET'])
def get_usuarios():
    conn = get_db_connection()
    if not conn: return jsonify({"error": "Error de conexión"}), 500
    try:
        with conn.cursor() as cur:
            cur.execute("SELECT user_id, user_name, email FROM usuarios")
            rows = cur.fetchall()
            return jsonify([{'user_id': r[0], 'user_name': r[1], 'email': r[2]} for r in rows])
    except oracledb.Error as e:
        return jsonify({"error": str(e)}), 500
    finally:
        if conn: pool.release(conn)

@app.route('/api/usuarios', methods=['POST'])
def create_usuario():
    data = request.json
    conn = get_db_connection()
    if not conn: return jsonify({"error": "Error de conexión"}), 500
    try:
        with conn.cursor() as cur:
            cur.callproc('INSERT_USUARIO', [data['user_name'], data['email']])
            conn.commit()
            return jsonify({"message": "Usuario creado correctamente"}), 201
    except oracledb.Error as e:
        conn.rollback()
        return jsonify({"error": str(e)}), 500
    finally:
        if conn: pool.release(conn)

@app.route('/api/usuarios/<email>', methods=['PUT'])
def update_usuario(email):
    data = request.json
    conn = get_db_connection()
    if not conn: return jsonify({"error": "Error de conexión"}), 500
    try:
        with conn.cursor() as cur:
            cur.callproc('UPDATE_USUARIO', [email, data['user_name'], data['email'], data.get('name_bool', 1), data.get('email_bool', 1)])
            conn.commit()
            return jsonify({"message": "Usuario actualizado correctamente"})
    except oracledb.Error as e:
        conn.rollback()
        return jsonify({"error": str(e)}), 500
    finally:
        if conn: pool.release(conn)

@app.route('/api/usuarios/<email>', methods=['DELETE'])
def delete_usuario(email):
    conn = get_db_connection()
    if not conn: return jsonify({"error": "Error de conexión"}), 500
    try:
        with conn.cursor() as cur:
            cur.callproc('DELETE_USUARIO', [email])
            conn.commit()
            return jsonify({"message": "Usuario eliminado correctamente"})
    except oracledb.Error as e:
        conn.rollback()
        return jsonify({"error": str(e)}), 500
    finally:
        if conn: pool.release(conn)

# --- Endpoints para Artículos ---
@app.route('/api/articulos', methods=['GET'])
def get_articulos():
    conn = get_db_connection()
    if not conn: return jsonify({"error": "Error de conexión"}), 500
    try:
        with conn.cursor() as cur:
            cur.execute("""
                SELECT a.articulo_id, a.user_id, a.titulo, a.article_text, u.user_name
                FROM articulos a
                JOIN usuarios u ON a.user_id = u.user_id
            """)
            rows = cur.fetchall()
            articulos = []
            for row in rows:
                article_text_lob = row[3]
                article_text_str = article_text_lob.read() if article_text_lob else ""
                articulos.append({
                    'articulo_id': row[0], 'user_id': row[1], 'titulo': row[2],
                    'article_text': article_text_str, 'user_name': row[4]
                })
            return jsonify(articulos)
    except oracledb.Error as e:
        return jsonify({"error": str(e)}), 500
    finally:
        if conn: pool.release(conn)

@app.route('/api/articulos', methods=['POST'])
def create_articulo():
    data = request.json
    conn = get_db_connection()
    if not conn: return jsonify({"error": "Error de conexión"}), 500
    try:
        with conn.cursor() as cur:
            cur.callproc('INSERT_ARTICULO', [data['user_id'], data['titulo'], data['article_text']])
            conn.commit()
            return jsonify({"message": "Artículo creado correctamente"}), 201
    except oracledb.Error as e:
        conn.rollback()
        return jsonify({"error": str(e)}), 500
    finally:
        if conn: pool.release(conn)

@app.route('/api/articulos/<int:articulo_id>', methods=['PUT'])
def update_articulo(articulo_id):
    data = request.json
    conn = get_db_connection()
    if not conn: return jsonify({"error": "Error de conexión"}), 500
    try:
        with conn.cursor() as cur:
            cur.callproc('UPDATE_ARTICULO', [
                articulo_id, data['titulo'], data['article_text'],
                data.get('titulo_bool', 1), data.get('text_bool', 1)
            ])
            conn.commit()
            return jsonify({"message": "Artículo actualizado correctamente"})
    except oracledb.Error as e:
        conn.rollback()
        return jsonify({"error": str(e)}), 500
    finally:
        if conn: pool.release(conn)

@app.route('/api/articulos/<int:articulo_id>', methods=['DELETE'])
def delete_articulo(articulo_id):
    conn = get_db_connection()
    if not conn: return jsonify({"error": "Error de conexión"}), 500
    try:
        with conn.cursor() as cur:
            cur.callproc('DELETE_ARTICULOS', [articulo_id])
            conn.commit()
            return jsonify({"message": "Artículo eliminado correctamente"})
    except oracledb.Error as e:
        conn.rollback()
        return jsonify({"error": str(e)}), 500
    finally:
        if conn: pool.release(conn)

# --- Endpoints para Categorías ---
@app.route('/api/categorias', methods=['GET'])
def get_categorias():
    conn = get_db_connection()
    if not conn: return jsonify({"error": "Error de conexión"}), 500
    try:
        with conn.cursor() as cur:
            cur.execute("SELECT category_name, url_cat FROM categorias")
            rows = cur.fetchall()
            return jsonify([{'category_name': r[0], 'url_cat': r[1]} for r in rows])
    except oracledb.Error as e:
        return jsonify({"error": str(e)}), 500
    finally:
        if conn: pool.release(conn)

@app.route('/api/categorias', methods=['POST'])
def create_categoria():
    data = request.json
    conn = get_db_connection()
    if not conn: return jsonify({"error": "Error de conexión"}), 500
    try:
        with conn.cursor() as cur:
            cur.callproc('INSERT_CATEGORIA', [data['category_name'], data['url_cat']])
            conn.commit()
            return jsonify({"message": "Categoría creada correctamente"}), 201
    except oracledb.Error as e:
        conn.rollback()
        return jsonify({"error": str(e)}), 500
    finally:
        if conn: pool.release(conn)

@app.route('/api/categorias/<category_name>', methods=['PUT'])
def update_categoria(category_name):
    data = request.json
    conn = get_db_connection()
    if not conn: return jsonify({"error": "Error de conexión"}), 500
    try:
        with conn.cursor() as cur:
            cur.callproc('UPDATE_CATEGORIA', [category_name, data['category_name']])
            conn.commit()
            return jsonify({"message": "Categoría actualizada correctamente"})
    except oracledb.Error as e:
        conn.rollback()
        return jsonify({"error": str(e)}), 500
    finally:
        if conn: pool.release(conn)

@app.route('/api/categorias/<category_name>', methods=['DELETE'])
def delete_categoria(category_name):
    conn = get_db_connection()
    if not conn: return jsonify({"error": "Error de conexión"}), 500
    try:
        with conn.cursor() as cur:
            cur.callproc('DELETE_CATEGORIA', [category_name])
            conn.commit()
            return jsonify({"message": "Categoría eliminada correctamente"})
    except oracledb.Error as e:
        conn.rollback()
        return jsonify({"error": str(e)}), 500
    finally:
        if conn: pool.release(conn)

# --- Endpoints para Comentarios ---
@app.route('/api/comentarios', methods=['GET'])
def get_comentarios():
    conn = get_db_connection()
    if not conn: return jsonify({"error": "Error de conexión"}), 500
    try:
        with conn.cursor() as cur:
            cur.execute("""
                SELECT c.comentario_id, c.articulo_id, c.user_id, c.texto_com,
                       a.titulo, u.user_name
                FROM comentarios c
                JOIN articulos a ON c.articulo_id = a.articulo_id
                JOIN usuarios u ON c.user_id = u.user_id
            """)
            rows = cur.fetchall()
            comentarios = []
            for row in rows:
                texto_com_lob = row[3]
                texto_com_str = texto_com_lob.read() if texto_com_lob else ""
                comentarios.append({
                    'comentario_id': row[0], 'articulo_id': row[1], 'user_id': row[2],
                    'texto_com': texto_com_str, 'titulo_articulo': row[4], 'user_name': row[5]
                })
            return jsonify(comentarios)
    except oracledb.Error as e:
        return jsonify({"error": str(e)}), 500
    finally:
        if conn: pool.release(conn)

@app.route('/api/comentarios', methods=['POST'])
def create_comentario():
    data = request.json
    conn = get_db_connection()
    if not conn: return jsonify({"error": "Error de conexión"}), 500
    try:
        with conn.cursor() as cur:
            cur.callproc('INSERT_COMENTARIO', [data['articulo_id'], data['user_id'], data['texto_com']])
            conn.commit()
            return jsonify({"message": "Comentario creado correctamente"}), 201
    except oracledb.Error as e:
        conn.rollback()
        return jsonify({"error": str(e)}), 500
    finally:
        if conn: pool.release(conn)

@app.route('/api/comentarios/<int:comentario_id>', methods=['PUT'])
def update_comentario(comentario_id):
    data = request.json
    conn = get_db_connection()
    if not conn: return jsonify({"error": "Error de conexión"}), 500
    try:
        with conn.cursor() as cur:
            cur.callproc('UPDATE_COMENTARIO', [comentario_id, data['texto_com']])
            conn.commit()
            return jsonify({"message": "Comentario actualizado correctamente"})
    except oracledb.Error as e:
        conn.rollback()
        return jsonify({"error": str(e)}), 500
    finally:
        if conn: pool.release(conn)

@app.route('/api/comentarios/<int:comentario_id>', methods=['DELETE'])
def delete_comentario(comentario_id):
    conn = get_db_connection()
    if not conn: return jsonify({"error": "Error de conexión"}), 500
    try:
        with conn.cursor() as cur:
            cur.callproc('DELETE_COMENTARIO', [comentario_id])
            conn.commit()
            return jsonify({"message": "Comentario eliminado correctamente"})
    except oracledb.Error as e:
        conn.rollback()
        return jsonify({"error": str(e)}), 500
    finally:
        if conn: pool.release(conn)

# --- Endpoints para Tags ---
@app.route('/api/tags', methods=['GET'])
def get_tags():
    conn = get_db_connection()
    if not conn: return jsonify({"error": "Error de conexión"}), 500
    try:
        with conn.cursor() as cur:
            cur.execute("SELECT tag_name, url_tag FROM tags")
            rows = cur.fetchall()
            return jsonify([{'tag_name': r[0], 'url_tag': r[1]} for r in rows])
    except oracledb.Error as e:
        return jsonify({"error": str(e)}), 500
    finally:
        if conn: pool.release(conn)

@app.route('/api/tags', methods=['POST'])
def create_tag():
    data = request.json
    conn = get_db_connection()
    if not conn: return jsonify({"error": "Error de conexión"}), 500
    try:
        with conn.cursor() as cur:
            cur.callproc('INSERT_TAG', [data['tag_name'], data['url_tag']])
            conn.commit()
            return jsonify({"message": "Tag creado correctamente"}), 201
    except oracledb.Error as e:
        conn.rollback()
        return jsonify({"error": str(e)}), 500
    finally:
        if conn: pool.release(conn)

@app.route('/api/tags/<tag_name>', methods=['PUT'])
def update_tag(tag_name):
    data = request.json
    conn = get_db_connection()
    if not conn: return jsonify({"error": "Error de conexión"}), 500
    try:
        with conn.cursor() as cur:
            cur.callproc('UPDATE_TAG', [tag_name, data['tag_name']])
            conn.commit()
            return jsonify({"message": "Tag actualizado correctamente"})
    except oracledb.Error as e:
        conn.rollback()
        return jsonify({"error": str(e)}), 500
    finally:
        if conn: pool.release(conn)

@app.route('/api/tags/<tag_name>', methods=['DELETE'])
def delete_tag(tag_name):
    conn = get_db_connection()
    if not conn: return jsonify({"error": "Error de conexión"}), 500
    try:
        with conn.cursor() as cur:
            cur.callproc('DELETE_TAG', [tag_name])
            conn.commit()
            return jsonify({"message": "Tag eliminado correctamente"})
    except oracledb.Error as e:
        conn.rollback()
        return jsonify({"error": str(e)}), 500
    finally:
        if conn: pool.release(conn)

if __name__ == '__main__':
    app.run(debug=True, port=5000)