<%-- 
    Document   : guardarinventario
    Created on : 4 jul 2024, 1:46:45
    Author     : juana
--%>

<%@page import="modelo.modeloabrircaja"%>
<%@page import="modelo.inventariomodelo"%>
<%@page import="java.util.List"%>
<%@page import="modelo.modeloproducto"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Guardar Inventario</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

        <style>
            body {
                background-color: #f8f9fa;
                padding-top: 20px;
            }
            .container {
                background-color: #ffffff;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                margin-top: 20px;
            }
            .card-header {
                background-color: #007bff;
                color: #ffffff;
            }
            .table-responsive {
                margin-top: 20px;
            }
            .table td, .table th {
                vertical-align: middle;
            }
        </style>
    </head>
    <body>
        <%
            inventariomodelo inventarioModelo = new inventariomodelo();
            String ultimoNumeroInventario = inventarioModelo.obtenerUltimoNumeroInventario();
            int nuevoNumeroInventario = Integer.parseInt(ultimoNumeroInventario) + 1;
        %>
        <%@ include file="../plantilla.jsp" %>
        <div class="container">
            <form id="formInventario" action="inventariocontrolador" method="post" onsubmit="return validarFormulario()">
                <!-- Campo oculto para el código de sesión -->
                <input type="hidden" name="lblcodigo" value="<%= sesion.getAttribute("codigo")%>">
                <!-- Campo oculto para el ID del inventario -->
                <input type="hidden" name="idinventario" value="<%= nuevoNumeroInventario%>">
                <div class="row">
                    <div class="col-md-6">
                        <!-- Datos del inventario -->
                        <div class="card mb-3">
                            <div class="card-header">Datos del Inventario</div>
                            <div class="card-body">
                                <div class="form-group">
                                    <label for="txtidinventario">ID del Inventario</label>
                                    <input type="text" class="form-control" name="txtidinventario" value="<%= nuevoNumeroInventario%>" readonly>
                                </div>

                                <div class="form-group">
                                    <label for="txtfecha">Fecha</label>
                                    <input type="text" class="form-control" id="txtfecha" name="txtfecha" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="txtnombre">Nombre del Producto</label>
                                    <input type="text" class="form-control" id="txtnombre" name="txtnombre" readonly>
                                </div>

                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <!-- Datos del stock -->
                        <div class="card mb-3">
                            <div class="card-header">Datos del Stock</div>

                            <div class="card-body">
                                <div class="form-group">
                                    <label for="txtcodigo">Código de Producto</label>
                                    <input type="text" class="form-control" name="txtidprod[]" id="txtidprod" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="txtstock">Stock Actual</label>
                                    <input type="text" class="form-control" name="txtstock" id="txtstock" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="cmbaccion">Acción a Realizar</label>
                                    <select class="form-control" id="cmbaccion" name="cmbaccion">
                                        <option value="Aumentar">Aumentar</option>
                                        <option value="Disminuir">Disminuir</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="txtcantidad">Cantidad a Modificar</label>
                                    <input type="number" class="form-control" id="txtcantidad" name="txtcantidad" min="1">
                                </div>
                                <div class="text-center">
                                    <button type="button" class="btn btn-primary" onclick="buscarProductos()">Buscar Productos</button>
                                    <button type="button" class="btn btn-success" onclick="modificarTabla()">Modificar</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%
                        // Obtiene la última apertura de caja del usuario actual
                        modeloabrircaja mf = new modeloabrircaja();
                        mf.setIdusuario((String) sesion.getAttribute("idusuario"));
                    %>

                    <input type="hidden" name="txtaper" id="txtaper" value="<%= mf.obtenerultimapertura()%>" readonly>
                    <input type="hidden" name="txtusu" id="txtusu" value="<%= sesion.getAttribute("idusuario")%>" readonly>
                </div>

                <!-- Modal buscador de productos -->
                <div id="miModal" class="modal">
                    <div class="modal-dialog modal-xl">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Buscador de Productos</h5>
                                <button type="button" class="close" onclick="cerrarModal()">&times;</button>
                            </div>
                            <div class="modal-body">
                                <table class="table table-bordered" id="mitabla">
                                    <thead>
                                        <tr>
                                            <th>CÓDIGO</th>
                                            <th>NOMBRE</th>
                                            <th>STOCK</th>
                                            <th>ACCION</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% modeloproducto modelo = new modeloproducto();
                                            List<modeloproducto> list = modelo.listarProductos();
                                            for (modeloproducto m : list) {%>
                                        <tr>
                                            <td><span class="dato-input"><%= m.getId()%></span></td>
                                            <td><span class="dato-input"><%= m.getNombre()%></span></td>
                                            <td><span class="dato-input"><%= m.getStock()%></span></td>
                                            <td><button type="button" class="btn btn-primary" onclick="obtenerFilaProducto(this)" data-nombre="<%= m.getNombre()%>">SELECCIONAR</button></td>
                                        </tr>
                                        <% }%>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Tabla dinámica para mostrar productos -->
                <div class="card mb-3">
                    <div class="card-header">Productos a Modificar</div>
                    <div class="card-body">
                        <table class="table table-bordered" id="tablaProductos">
                            <thead>
                                <tr>
                                    <th>CÓDIGO</th>
                                    <th>NOMBRE</th>
                                    <th>STOCK ACTUAL</th>
                                    <th>CANTIDAD A MODIFICAR</th>
                                    <th>ACCIÓN</th>
                                    <th>ELIMINAR</th>
                                </tr>
                            </thead>
                            <tbody id="tablaCuerpo">
                                <!-- Cuerpo de la tabla para mostrar productos -->
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Botón para guardar cambios en inventario -->
                <div class="text-center">
                    <button type="submit" class="btn btn-success" name="accion" value="guardarInventario">GUARDAR</button>
                </div>
            </form>
        </div>

        <!-- Modales de advertencia -->
        <div class="modal fade" id="modalProducto" tabindex="-1" role="dialog" aria-labelledby="modalProductoLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalProductoLabel">Advertencia</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        Por favor, seleccione un producto antes de continuar.
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="modalCantidad" tabindex="-1" role="dialog" aria-labelledby="modalCantidadLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalCantidadLabel">Advertencia</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        Por favor, ingrese una cantidad válida mayor que cero.
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
    // Función para obtener la fecha actual y establecerla en un campo de texto
    document.addEventListener("DOMContentLoaded", function () {
        var fechaActual = new Date().toISOString().slice(0, 10);
        document.getElementById("txtfecha").value = fechaActual;
    });

    // Función para mostrar el modal de búsqueda de productos
    function buscarProductos() {
        $('#miModal').modal('show');
    }

    // Función para cerrar el modal de búsqueda de productos
    function cerrarModal() {
        $('#miModal').modal('hide');
    }

    // Función para obtener la fila seleccionada del modal y cargar datos en el formulario principal
    function obtenerFilaProducto(boton) {
        var fila = boton.closest('tr');
        var codigo = fila.cells[0].textContent.trim();
        var stock = fila.cells[2].textContent.trim();
        var nombre = fila.cells[1].textContent.trim();

        document.getElementById("txtidprod").value = codigo;
        document.getElementById("txtstock").value = stock;
        document.getElementById("txtnombre").value = nombre;

        cerrarModal(); // Cerrar modal después de seleccionar el producto
    }

    // Función para modificar la tabla dinámica con los productos seleccionados
    function modificarTabla() {
        var codigo = document.getElementById("txtidprod").value;
        var nombre = document.getElementById("txtnombre").value;
        var stockActual = document.getElementById("txtstock").value;
        var accion = document.getElementById("cmbaccion").value;
        var cantidad = document.getElementById("txtcantidad").value;

        if (codigo === "" || cantidad <= 0 || isNaN(cantidad)) {
            $('#modalCantidad').modal('show');
            return;
        }

        var tablaCuerpo = document.getElementById("tablaCuerpo");
        var fila = tablaCuerpo.insertRow();

        var celdaCodigo = fila.insertCell(0);
        var celdaNombre = fila.insertCell(1);
        var celdaStockActual = fila.insertCell(2);
        var celdaCantidad = fila.insertCell(3);
        var celdaAccion = fila.insertCell(4);
        var celdaEliminar = fila.insertCell(5);

        celdaCodigo.textContent = codigo;
        celdaNombre.textContent = nombre;
        celdaStockActual.textContent = stockActual;
        celdaCantidad.textContent = cantidad;
        celdaAccion.textContent = accion;

        // Botón BORRAR
        var botonBorrar = document.createElement("button");
        botonBorrar.type = "button";
        botonBorrar.classList.add("btn", "btn-danger", "btn-sm");
        botonBorrar.textContent = "BORRAR";
        botonBorrar.onclick = function () {
            fila.remove();
        };
        celdaEliminar.appendChild(botonBorrar);

        // Limpiar campos después de agregar a la tabla
        document.getElementById("txtidprod").value = "";
        document.getElementById("txtstock").value = "";
        document.getElementById("txtcantidad").value = "";
        document.getElementById("txtnombre").value = "";

        // Recolectar datos de la tabla dinámica y agregarlos a campos ocultos en el formulario
        actualizarDatosFormulario();
    }

    // Función para actualizar el formulario con los datos de la tabla dinámica
    function actualizarDatosFormulario() {
        var tabla = document.getElementById("tablaCuerpo");
        var idProductos = [];
        var cantidades = [];
        var acciones = [];
        var inventarioID = document.querySelector('input[name="idinventario"]').value;

        // Recorrer filas de la tabla dinámica
        for (var i = 0; i < tabla.rows.length; i++) {
            var fila = tabla.rows[i];
            var codigo = fila.cells[0].textContent.trim();
            var cantidad = fila.cells[3].textContent.trim();
            var accion = fila.cells[4].textContent.trim();

            idProductos.push(codigo);
            cantidades.push(cantidad);
            acciones.push(accion);
        }

        // Crear campos ocultos para los arrays
        crearCampoOculto("idProductos", idProductos);
        crearCampoOculto("cantidades", cantidades);
        crearCampoOculto("acciones", acciones);
        crearCampoOculto("inventarioID", inventarioID);
    }

    // Función para crear un campo oculto en el formulario
    function crearCampoOculto(nombre, valor) {
        var formulario = document.getElementById("formInventario");
        var campoOculto = document.createElement("input");
        campoOculto.type = "hidden";
        campoOculto.name = nombre;
        campoOculto.value = JSON.stringify(valor);

        // Remover campo oculto anterior si existe
        var campoExistente = formulario.querySelector("input[name='" + nombre + "']");
        if (campoExistente) {
            formulario.removeChild(campoExistente);
        }

        // Agregar campo oculto actualizado al formulario
        formulario.appendChild(campoOculto);
    }
</script>
    </body>
</html>
