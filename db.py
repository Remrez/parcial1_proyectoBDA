import oracledb

# --- Módulo para gestionar la conexión a la base de datos ---

pool = None

def init_db_pool():
    """
    Inicializa el pool de conexiones a la base de datos.
    Esta función se llama una sola vez al iniciar la aplicación.
    """
    global pool
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
    """
    Obtiene una conexión del pool.
    """
    if not pool:
        print("Error: El pool de conexiones no está inicializado.")
        return None
    try:
        # Adquiere una conexión del pool para ser usada por un endpoint
        return pool.acquire()
    except oracledb.Error as e:
        print(f"Error al obtener conexión del pool: {e}")
        return None

# Inicializamos el pool al cargar este módulo
init_db_pool()
