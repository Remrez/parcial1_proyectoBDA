// Configuración de la API
const API_BASE_URL = 'http://localhost:5000/api';

// Función para mostrar mensajes al usuario
function showMessage(message, type = 'info') {
    const messageEl = document.createElement('div');
    messageEl.className = `message message-${type}`;
    messageEl.textContent = message;
    
    messageEl.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        padding: 15px 20px;
        border-radius: 4px;
        color: white;
        z-index: 1000;
        max-width: 300px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.2);
    `;
    
    if (type === 'success') {
        messageEl.style.backgroundColor = '#28a745';
    } else if (type === 'error') {
        messageEl.style.backgroundColor = '#dc3545';
    } else {
        messageEl.style.backgroundColor = '#17a2b8';
    }
    
    document.body.appendChild(messageEl);
    
    setTimeout(() => {
        messageEl.remove();
    }, 3000);
}

// Función para hacer peticiones a la API
async function apiCall(endpoint, options = {}) {
    try {
        const response = await fetch(`${API_BASE_URL}${endpoint}`, {
            headers: {
                'Content-Type': 'application/json',
                ...options.headers
            },
            ...options
        });
        
        if (!response.ok) {
            const errorData = await response.json();
            throw new Error(errorData.error || 'Error en la petición');
        }
        
        return await response.json();
    } catch (error) {
        console.error('Error en API call:', error);
        showMessage(error.message, 'error');
        throw error;
    }
}

// Función para cargar datos reales desde la API
async function loadRealData() {
    try {
        // Cargar artículos
        if (document.getElementById('articles-table')) {
            const articulos = await apiCall('/articulos');
            const tbody = document.querySelector('#articles-table tbody');
            tbody.innerHTML = '';
            
            articulos.forEach(articulo => {
                const tr = document.createElement('tr');
                tr.innerHTML = `
                    <td>${articulo.articulo_id}</td>
                    <td>${articulo.user_name} (ID: ${articulo.user_id})</td>
                    <td>${articulo.titulo}</td>
                    <td class="action-buttons">
                        <button class="btn btn-primary btn-sm" onclick="editArticle(${articulo.articulo_id}, ${articulo.user_id}, '${articulo.titulo.replace(/'/g, "\\'")}', '${articulo.article_text.replace(/'/g, "\\'")}')">Editar</button>
                        <button class="btn btn-danger btn-sm" onclick="deleteArticle(${articulo.articulo_id})">Eliminar</button>
                    </td>
                `;
                tbody.appendChild(tr);
            });
        }
        
        // Cargar categorías
        if (document.getElementById('categories-table')) {
            const categorias = await apiCall('/categorias');
            const tbody = document.querySelector('#categories-table tbody');
            tbody.innerHTML = '';
            
            categorias.forEach(categoria => {
                const tr = document.createElement('tr');
                tr.innerHTML = `
                    <td>${categoria.category_name}</td>
                    <td>${categoria.url_cat}</td>
                    <td class="action-buttons">
                        <button class="btn btn-primary btn-sm" onclick="editCategory('${categoria.category_name.replace(/'/g, "\\'")}', '${categoria.url_cat.replace(/'/g, "\\'")}')">Editar</button>
                        <button class="btn btn-danger btn-sm" onclick="deleteCategory('${categoria.category_name.replace(/'/g, "\\'")}')">Eliminar</button>
                    </td>
                `;
                tbody.appendChild(tr);
            });
        }
        
        // Cargar comentarios
        if (document.getElementById('comments-table')) {
            const comentarios = await apiCall('/comentarios');
            const tbody = document.querySelector('#comments-table tbody');
            tbody.innerHTML = '';
            
            comentarios.forEach(comentario => {
                const tr = document.createElement('tr');
                tr.innerHTML = `
                    <td>${comentario.comentario_id}</td>
                    <td>${comentario.titulo_articulo} (ID: ${comentario.articulo_id})</td>
                    <td>${comentario.user_name} (ID: ${comentario.user_id})</td>
                    <td>${comentario.texto_com}</td>
                    <td class="action-buttons">
                        <button class="btn btn-primary btn-sm" onclick="editComment(${comentario.comentario_id}, ${comentario.articulo_id}, ${comentario.user_id}, '${comentario.texto_com.replace(/'/g, "\\'")}')">Editar</button>
                        <button class="btn btn-danger btn-sm" onclick="deleteComment(${comentario.comentario_id})">Eliminar</button>
                    </td>
                `;
                tbody.appendChild(tr);
            });
        }
        
        // Cargar tags
        if (document.getElementById('tags-table')) {
            const tags = await apiCall('/tags');
            const tbody = document.querySelector('#tags-table tbody');
            tbody.innerHTML = '';
            
            tags.forEach(tag => {
                const tr = document.createElement('tr');
                tr.innerHTML = `
                    <td>${tag.tag_name}</td>
                    <td>${tag.url_tag}</td>
                    <td class="action-buttons">
                        <button class="btn btn-primary btn-sm" onclick="editTag('${tag.tag_name.replace(/'/g, "\\'")}', '${tag.url_tag.replace(/'/g, "\\'")}')">Editar</button>
                        <button class="btn btn-danger btn-sm" onclick="deleteTag('${tag.tag_name.replace(/'/g, "\\'")}')">Eliminar</button>
                    </td>
                `;
                tbody.appendChild(tr);
            });
        }
        
        // Cargar usuarios
        if (document.getElementById('users-table')) {
            const usuarios = await apiCall('/usuarios');
            const tbody = document.querySelector('#users-table tbody');
            tbody.innerHTML = '';
            
            usuarios.forEach(usuario => {
                const tr = document.createElement('tr');
                tr.innerHTML = `
                    <td>${usuario.user_id}</td>
                    <td>${usuario.user_name}</td>
                    <td>${usuario.email}</td>
                    <td class="action-buttons">
                        <button class="btn btn-primary btn-sm" onclick="editUser('${usuario.email.replace(/'/g, "\\'")}', '${usuario.user_name.replace(/'/g, "\\'")}', '${usuario.email.replace(/'/g, "\\'")}')">Editar</button>
                        <button class="btn btn-danger btn-sm" onclick="deleteUser('${usuario.email.replace(/'/g, "\\'")}')">Eliminar</button>
                    </td>
                `;
                tbody.appendChild(tr);
            });
        }
    } catch (error) {
        console.error('Error cargando datos:', error);
    }
}

// Funciones para Artículos
function editArticle(id, userId, title, text) {
    document.getElementById('article-id').value = id;
    document.getElementById('user-id').value = userId;
    document.getElementById('titulo').value = title;
    document.getElementById('article-text').value = text;
    document.getElementById('form-title').textContent = 'Editar Artículo';
    document.getElementById('update-title').checked = true;
    document.getElementById('update-text').checked = true;
}

async function deleteArticle(id) {
    if (confirm('¿Estás seguro de que deseas eliminar este artículo?')) {
        try {
            await apiCall(`/articulos/${id}`, { method: 'DELETE' });
            showMessage('Artículo eliminado correctamente', 'success');
            loadRealData();
        } catch (error) {
            // El error ya se maneja en apiCall
        }
    }
}

// Funciones para Categorías
function editCategory(name, url) {
    document.getElementById('original-name').value = name;
    document.getElementById('category-name').value = name;
    document.getElementById('url-cat').value = url;
    document.getElementById('form-title').textContent = 'Editar Categoría';
}

async function deleteCategory(name) {
    if (confirm('¿Estás seguro de que deseas eliminar esta categoría?')) {
        try {
            await apiCall(`/categorias/${encodeURIComponent(name)}`, { method: 'DELETE' });
            showMessage('Categoría eliminada correctamente', 'success');
            loadRealData();
        } catch (error) {
            // El error ya se maneja en apiCall
        }
    }
}

// Funciones para Comentarios
function editComment(id, articleId, userId, text) {
    document.getElementById('comment-id').value = id;
    document.getElementById('article-id-comment').value = articleId;
    document.getElementById('user-id-comment').value = userId;
    document.getElementById('texto-com').value = text;
    document.getElementById('form-title').textContent = 'Editar Comentario';
}

async function deleteComment(id) {
    if (confirm('¿Estás seguro de que deseas eliminar este comentario?')) {
        try {
            await apiCall(`/comentarios/${id}`, { method: 'DELETE' });
            showMessage('Comentario eliminado correctamente', 'success');
            loadRealData();
        } catch (error) {
            // El error ya se maneja en apiCall
        }
    }
}

// Funciones para Tags
function editTag(name, url) {
    document.getElementById('original-tag-name').value = name;
    document.getElementById('tag-name').value = name;
    document.getElementById('url-tag').value = url;
    document.getElementById('form-title').textContent = 'Editar Tag';
}

async function deleteTag(name) {
    if (confirm('¿Estás seguro de que deseas eliminar este tag?')) {
        try {
            await apiCall(`/tags/${encodeURIComponent(name)}`, { method: 'DELETE' });
            showMessage('Tag eliminado correctamente', 'success');
            loadRealData();
        } catch (error) {
            // El error ya se maneja en apiCall
        }
    }
}

// Funciones para Usuarios
function editUser(email, name, newEmail) {
    document.getElementById('original-email').value = email;
    document.getElementById('user-name').value = name;
    document.getElementById('user-email').value = newEmail;
    document.getElementById('form-title').textContent = 'Editar Usuario';
    document.getElementById('update-name').checked = true;
    document.getElementById('update-email').checked = true;
}

async function deleteUser(email) {
    if (confirm('¿Estás seguro de que deseas eliminar este usuario?')) {
        try {
            await apiCall(`/usuarios/${encodeURIComponent(email)}`, { method: 'DELETE' });
            showMessage('Usuario eliminado correctamente', 'success');
            loadRealData();
        } catch (error) {
            // El error ya se maneja en apiCall
        }
    }
}

// Configuración de formularios
document.addEventListener('DOMContentLoaded', function() {
    // Cargar datos reales
    loadRealData();
    
    // Configurar botones de cancelar
    const cancelButtons = document.querySelectorAll('#cancel-edit');
    cancelButtons.forEach(button => {
        button.addEventListener('click', function() {
            const form = this.closest('form');
            form.reset();
            const formTitle = document.getElementById('form-title');
            if (formTitle) {
                formTitle.textContent = formTitle.textContent.replace('Editar', 'Agregar Nuevo');
            }
        });
    });
    
    // Configurar envío de formularios
    const forms = document.querySelectorAll('form');
    forms.forEach(form => {
        form.addEventListener('submit', async function(e) {
            e.preventDefault();
            
            const formTitle = document.getElementById('form-title');
            const isEdit = formTitle && formTitle.textContent.includes('Editar');
            
            try {
                if (form.id === 'article-form') {
                    const data = {
                        user_id: parseInt(document.getElementById('user-id').value),
                        titulo: document.getElementById('titulo').value,
                        article_text: document.getElementById('article-text').value
                    };
                    
                    if (isEdit) {
                        data.titulo_bool = document.getElementById('update-title').checked ? 1 : 0;
                        data.text_bool = document.getElementById('update-text').checked ? 1 : 0;
                        const articleId = document.getElementById('article-id').value;
                        await apiCall(`/articulos/${articleId}`, {
                            method: 'PUT',
                            body: JSON.stringify(data)
                        });
                    } else {
                        await apiCall('/articulos', {
                            method: 'POST',
                            body: JSON.stringify(data)
                        });
                    }
                }
                else if (form.id === 'category-form') {
                    const data = {
                        category_name: document.getElementById('category-name').value,
                        url_cat: document.getElementById('url-cat').value
                    };
                    
                    if (isEdit) {
                        const originalName = document.getElementById('original-name').value;
                        await apiCall(`/categorias/${encodeURIComponent(originalName)}`, {
                            method: 'PUT',
                            body: JSON.stringify({ category_name: data.category_name })
                        });
                    } else {
                        await apiCall('/categorias', {
                            method: 'POST',
                            body: JSON.stringify(data)
                        });
                    }
                }
                else if (form.id === 'comment-form') {
                    const data = {
                        articulo_id: parseInt(document.getElementById('article-id-comment').value),
                        user_id: parseInt(document.getElementById('user-id-comment').value),
                        texto_com: document.getElementById('texto-com').value
                    };
                    
                    if (isEdit) {
                        const commentId = document.getElementById('comment-id').value;
                        await apiCall(`/comentarios/${commentId}`, {
                            method: 'PUT',
                            body: JSON.stringify({ texto_com: data.texto_com })
                        });
                    } else {
                        await apiCall('/comentarios', {
                            method: 'POST',
                            body: JSON.stringify(data)
                        });
                    }
                }
                else if (form.id === 'tag-form') {
                    const data = {
                        tag_name: document.getElementById('tag-name').value,
                        url_tag: document.getElementById('url-tag').value
                    };
                    
                    if (isEdit) {
                        const originalName = document.getElementById('original-tag-name').value;
                        await apiCall(`/tags/${encodeURIComponent(originalName)}`, {
                            method: 'PUT',
                            body: JSON.stringify({ tag_name: data.tag_name })
                        });
                    } else {
                        await apiCall('/tags', {
                            method: 'POST',
                            body: JSON.stringify(data)
                        });
                    }
                }
                else if (form.id === 'user-form') {
                    const data = {
                        user_name: document.getElementById('user-name').value,
                        email: document.getElementById('user-email').value
                    };
                    
                    if (isEdit) {
                        data.name_bool = document.getElementById('update-name').checked ? 1 : 0;
                        data.email_bool = document.getElementById('update-email').checked ? 1 : 0;
                        const originalEmail = document.getElementById('original-email').value;
                        await apiCall(`/usuarios/${encodeURIComponent(originalEmail)}`, {
                            method: 'PUT',
                            body: JSON.stringify(data)
                        });
                    } else {
                        await apiCall('/usuarios', {
                            method: 'POST',
                            body: JSON.stringify(data)
                        });
                    }
                }
                
                showMessage(isEdit ? 'Registro actualizado correctamente' : 'Registro creado correctamente', 'success');
                
                // Limpiar formulario
                this.reset();
                
                if (formTitle) {
                    formTitle.textContent = formTitle.textContent.replace('Editar', 'Agregar Nuevo');
                }
                
                // Recargar datos
                loadRealData();
                
            } catch (error) {
                // El error ya se maneja en apiCall
            }
        });
    });
});