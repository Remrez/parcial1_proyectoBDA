-- Crear tabla USERS
CREATE TABLE users (
    user_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    email VARCHAR2(150) NOT NULL UNIQUE
);

-- Crear tabla ARTICLES
CREATE TABLE articles (
    article_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title VARCHAR2(200) NOT NULL,
    date_created DATE DEFAULT SYSDATE NOT NULL,
    text CLOB NOT NULL,
    user_id NUMBER NOT NULL,
    CONSTRAINT fk_articles_user FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Crear tabla COMMENTS
CREATE TABLE comments (
    comment_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    url VARCHAR2(200),
    article_id NUMBER NOT NULL,
    user_id NUMBER NOT NULL,
    CONSTRAINT fk_comments_article FOREIGN KEY (article_id) REFERENCES articles(article_id),
    CONSTRAINT fk_comments_user FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Crear tabla TAGS
CREATE TABLE tags (
    tag_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR2(50) NOT NULL UNIQUE,
    url VARCHAR2(200)
);

-- Crear tabla CATEGORIES
CREATE TABLE categories (
    category_id NUMBER GENERALLY ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR2(50) NOT NULL UNIQUE,
    url VARCHAR2(200)
);

-- Crear tabla intermedia para relación N-to-N entre ARTICLES y TAGS
CREATE TABLE articles_tags (
    article_id NUMBER NOT NULL,
    tag_id NUMBER NOT NULL,
    CONSTRAINT pk_articles_tags PRIMARY KEY (article_id, tag_id),
    CONSTRAINT fk_at_article FOREIGN KEY (article_id) REFERENCES articles(article_id) ON DELETE CASCADE,
    CONSTRAINT fk_at_tag FOREIGN KEY (tag_id) REFERENCES tags(tag_id) ON DELETE CASCADE
);

-- Crear tabla intermedia para relación N-to-N entre ARTICLES y CATEGORIES
CREATE TABLE articles_categories (
    article_id NUMBER NOT NULL,
    category_id NUMBER NOT NULL,
    CONSTRAINT pk_articles_categories PRIMARY KEY (article_id, category_id),
    CONSTRAINT fk_ac_article FOREIGN KEY (article_id) REFERENCES articles(article_id) ON DELETE CASCADE,
    CONSTRAINT fk_ac_category FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE CASCADE
);

-- Crear índices para mejorar el rendimiento en las claves foráneas
CREATE INDEX idx_articles_user_id ON articles(user_id);
CREATE INDEX idx_comments_article_id ON comments(article_id);
CREATE INDEX idx_comments_user_id ON comments(user_id);
CREATE INDEX idx_articles_tags_article_id ON articles_tags(article_id);
CREATE INDEX idx_articles_tags_tag_id ON articles_tags(tag_id);
CREATE INDEX idx_articles_categories_article_id ON articles_categories(article_id);
CREATE INDEX idx_articles_categories_category_id ON articles_categories(category_id);

-- Insertar datos de ejemplo
INSERT INTO users (name, email) VALUES ('Juan Pérez', 'juan.perez@email.com');
INSERT INTO users (name, email) VALUES ('María García', 'maria.garcia@email.com');
INSERT INTO users (name, email) VALUES ('Carlos López', 'carlos.lopez@email.com');

INSERT INTO categories (name, url) VALUES ('Tecnología', '/categoria/tecnologia');
INSERT INTO categories (name, url) VALUES ('Programación', '/categoria/programacion');
INSERT INTO categories (name, url) VALUES ('Bases de Datos', '/categoria/bases-datos');

INSERT INTO tags (name, url) VALUES ('Python', '/tag/python');
INSERT INTO tags (name, url) VALUES ('Oracle', '/tag/oracle');
INSERT INTO tags (name, url) VALUES ('PL/SQL', '/tag/plsql');
INSERT INTO tags (name, url) VALUES ('Bases de Datos', '/tag/bases-datos');

COMMIT;