// Funciones comunes para todas las páginas

// Función para mostrar mensajes al usuario
function showMessage(message, type = 'info') {
    // Crear elemento de mensaje
    const messageEl = document.createElement('div');
    messageEl.className = `message message-${type}`;
    messageEl.textContent = message;
    
    // Estilos para el mensaje
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
    
    // Colores según el tipo
    if (type === 'success') {
        messageEl.style.backgroundColor = '#28a745';
    } else if (type === 'error') {
        messageEl.style.backgroundColor = '#dc3545';
    } else {
        messageEl.style.backgroundColor = '#17a2b8';
    }
    
    // Agregar al documento
    document.body.appendChild(messageEl);
    
    // Remover después de 3 segundos
    setTimeout(() => {
        messageEl.remove();
    }, 3000);
}

// Función para cargar datos de ejemplo en las tablas
function loadSampleData() {
    // Esta función simularía la carga de datos desde el backend
    // En una implementación real, aquí harías una petición a tu API
    
    // Artículos de ejemplo
    if (document.getElementById('articles-table')) {
        const tbody = document.querySelector('#articles-table tbody');
        tbody.innerHTML = `
            <tr>
                <td>1</td>
                <td>5</td>
                <td>Introducción a las Bases de Datos Oracle</td>
                <td class="action-buttons">
                    <button class="btn btn-primary btn-sm" onclick="editArticle(1, 5, 'Introducción a las Bases de Datos Oracle', 'En este artículo exploraremos los conceptos básicos...')">Editar</button>
                    <button class="btn btn-danger btn-sm" onclick="deleteArticle(1)">Eliminar</button>
                </td>
            </tr>
            <tr>
                <td>2</td>
                <td>3</td>
                <td>Mejores prácticas en desarrollo web</td>
                <td class="action-buttons">
                    <button class="btn btn-primary btn-sm" onclick="editArticle(2, 3, 'Mejores prácticas en desarrollo web', 'El desarrollo web moderno requiere seguir ciertas prácticas...')">Editar</button>
                    <button class="btn btn-danger btn-sm" onclick="deleteArticle(2)">Eliminar</button>
                </td>
            </tr>
        `;
    }
    
    // Categorías de ejemplo
    if (document.getElementById('categories-table')) {
        const tbody = document.querySelector('#categories-table tbody');
        tbody.innerHTML = `
            <tr>
                <td>Tecnología</td>
                <td>www.blog.com/categoria/tecnologia</td>
                <td class="action-buttons">
                    <button class="btn btn-primary btn-sm" onclick="editCategory('Tecnología', 'www.blog.com/categoria/tecnologia')">Editar</button>
                    <button class="btn btn-danger btn-sm" onclick="deleteCategory('Tecnología')">Eliminar</button>
                </td>
            </tr>
            <tr>
                <td>Programación</td>
                <td>www.blog.com/categoria/programacion</td>
                <td class="action-buttons">
                    <button class="btn btn-primary btn-sm" onclick="editCategory('Programación', 'www.blog.com/categoria/programacion')">Editar</button>
                    <button class="btn btn-danger btn-sm" onclick="deleteCategory('Programación')">Eliminar</button>
                </td>
            </tr>
        `;
    }
    
    // Comentarios de ejemplo
    if (document.getElementById('comments-table')) {
        const tbody = document.querySelector('#comments-table tbody');
        tbody.innerHTML = `
            <tr>
                <td>1</td>
                <td>1</td>
                <td>5</td>
                <td>Excelente artículo, muy informativo</td>
                <td class="action-buttons">
                    <button class="btn btn-primary btn-sm" onclick="editComment(1, 1, 5, 'Excelente artículo, muy informativo')">Editar</button>
                    <button class="btn btn-danger btn-sm" onclick="deleteComment(1)">Eliminar</button>
                </td>
            </tr>
        `;
    }
    
    // Tags de ejemplo
    if (document.getElementById('tags-table')) {
        const tbody = document.querySelector('#tags-table tbody');
        tbody.innerHTML = `
            <tr>
                <td>Oracle</td>
                <td>www.blog.com/tag/oracle</td>
                <td class="action-buttons">
                    <button class="btn btn-primary btn-sm" onclick="editTag('Oracle', 'www.blog.com/tag/oracle')">Editar</button>
                    <button class="btn btn-danger btn-sm" onclick="deleteTag('Oracle')">Eliminar</button>
                </td>
            </tr>
            <tr>
                <td>Base de Datos</td>
                <td>www.blog.com/tag/base-de-datos</td>
                <td class="action-buttons">
                    <button class="btn btn-primary btn-sm" onclick="editTag('Base de Datos', 'www.blog.com/tag/base-de-datos')">Editar</button>
                    <button class="btn btn-danger btn-sm" onclick="deleteTag('Base de Datos')">Eliminar</button>
                </td>
            </tr>
        `;
    }
    
    // Usuarios de ejemplo
    if (document.getElementById('users-table')) {
        const tbody = document.querySelector('#users-table tbody');
        tbody.innerHTML = `
            <tr>
                <td>1</td>
                <td>Juan Pérez</td>
                <td>juan@example.com</td>
                <td class="action-buttons">
                    <button class="btn btn-primary btn-sm" onclick="editUser('juan@example.com', 'Juan Pérez', 'juan@example.com')">Editar</button>
                    <button class="btn btn-danger btn-sm" onclick="deleteUser('juan@example.com')">Eliminar</button>
                </td>
            </tr>
            <tr>
                <td>2</td>
                <td>María García</td>
                <td>maria@example.com</td>
                <td class="action-buttons">
                    <button class="btn btn-primary btn-sm" onclick="editUser('maria@example.com', 'María García', 'maria@example.com')">Editar</button>
                    <button class="btn btn-danger btn-sm" onclick="deleteUser('maria@example.com')">Eliminar</button>
                </td>
            </tr>
        `;
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

function deleteArticle(id) {
    if (confirm('¿Estás seguro de que deseas eliminar este artículo?')) {
        // Aquí iría la llamada al backend para eliminar
        showMessage('Artículo eliminado correctamente', 'success');
        // Recargar datos
        setTimeout(loadSampleData, 1000);
    }
}

// Funciones para Categorías
function editCategory(name, url) {
    document.getElementById('original-name').value = name;
    document.getElementById('category-name').value = name;
    document.getElementById('url-cat').value = url;
    document.getElementById('form-title').textContent = 'Editar Categoría';
}

function deleteCategory(name) {
    if (confirm('¿Estás seguro de que deseas eliminar esta categoría?')) {
        // Aquí iría la llamada al backend para eliminar
        showMessage('Categoría eliminada correctamente', 'success');
        // Recargar datos
        setTimeout(loadSampleData, 1000);
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

function deleteComment(id) {
    if (confirm('¿Estás seguro de que deseas eliminar este comentario?')) {
        // Aquí iría la llamada al backend para eliminar
        showMessage('Comentario eliminado correctamente', 'success');
        // Recargar datos
        setTimeout(loadSampleData, 1000);
    }
}

// Funciones para Tags
function editTag(name, url) {
    document.getElementById('original-tag-name').value = name;
    document.getElementById('tag-name').value = name;
    document.getElementById('url-tag').value = url;
    document.getElementById('form-title').textContent = 'Editar Tag';
}

function deleteTag(name) {
    if (confirm('¿Estás seguro de que deseas eliminar este tag?')) {
        // Aquí iría la llamada al backend para eliminar
        showMessage('Tag eliminado correctamente', 'success');
        // Recargar datos
        setTimeout(loadSampleData, 1000);
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

function deleteUser(email) {
    if (confirm('¿Estás seguro de que deseas eliminar este usuario?')) {
        // Aquí iría la llamada al backend para eliminar
        showMessage('Usuario eliminado correctamente', 'success');
        // Recargar datos
        setTimeout(loadSampleData, 1000);
    }
}

// Configuración de formularios
document.addEventListener('DOMContentLoaded', function() {
    // Cargar datos de ejemplo
    loadSampleData();
    
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
        form.addEventListener('submit', function(e) {
            e.preventDefault();
            
            // Aquí iría la llamada al backend para guardar los datos
            // Por ahora, solo mostramos un mensaje de éxito
            
            const formTitle = document.getElementById('form-title');
            if (formTitle && formTitle.textContent.includes('Editar')) {
                showMessage('Registro actualizado correctamente', 'success');
            } else {
                showMessage('Registro creado correctamente', 'success');
            }
            
            // Limpiar formulario
            this.reset();
            
            if (formTitle) {
                formTitle.textContent = formTitle.textContent.replace('Editar', 'Agregar Nuevo');
            }
            
            // Recargar datos (en una implementación real, esto vendría del backend)
            setTimeout(loadSampleData, 1000);
        });
    });
});