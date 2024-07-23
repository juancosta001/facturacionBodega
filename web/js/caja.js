function mostrarModal(action) {
    event.preventDefault();
    var modal = document.getElementById('miModal');
    var modalTitle = document.getElementById('modalTitle');
    if (action === 'abrir') {
        modalTitle.textContent = '¿DESEA ABRIR CAJA?';
    } else if (action === 'cerrar') {
        modalTitle.textContent = '¿DESEA CERRAR CAJA?';
    }
    modal.style.display = 'block';
}

function cerrarModal() {
    var modal = document.getElementById('miModal');
    modal.style.display = 'none';
}

function confirmarAccion(action) {
    if (action === 'abrir') {
        document.getElementById('formApertura').submit();
    } else if (action === 'cerrar') {
        document.getElementById('formCierre').submit();
    }
}
