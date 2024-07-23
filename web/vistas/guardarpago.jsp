
<%@page import="modelo.modeloabrircaja"%>
<%@page import="modelo.compramodelo"%>
<%@page import="modelo.pagomodelo"%>
<%@page import="java.util.List"%>
<%@page import="modelo.modeloproveedor"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registrar Pago</title>
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
        <%@ include file="../plantilla.jsp" %>
        <div class="container">
            <form id="formPago" action="pagocontrolador" method="post" onsubmit="return validarFormulario()">
                <!-- Campo oculto para el código de sesión -->
                <input type="hidden" name="lblcodigo" value="<%= sesion.getAttribute("codigo")%>">
                <div class="row">
                    <div class="col-md-6">
                        <!-- Datos del pago -->
                        <div class="card mb-3">
                            <div class="card-header">Datos del Pago</div>
                            <div class="card-body">
                                <div class="form-group">
                                    <label for="txtcodigo">N° PAGO</label>
                                    <input type="text" class="form-control" name="txtcodigo" id="txtcodigo" value="<%= new pagomodelo().obtenerProximoNumeroPago()%>" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="txtfecha">FECHA</label>
                                    <input type="text" class="form-control" id="txtfecha" name="txtfecha" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="txtestado">ESTADO</label>
                                    <input type="text" class="form-control" name="txtestado" id="txtestado" value="PENDIENTE" readonly>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <!-- Datos del proveedor -->
                        <div class="card mb-3">
                            <div class="card-header">Datos del Proveedor</div>
                            <div class="card-body">
                                <div class="form-group">
                                    <label for="txtcodigoprov">CODIGO</label>
                                    <div class="input-group">
                                        <input type="text" class="form-control" name="txtcodigoprov" id="txtcodigoprov" readonly>
                                        <div class="input-group-append">
                                            <button type="button" class="btn btn-primary" name="btnbuscarprov" onclick="mostrarModal()">BUSCAR</button>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="txtnombreprov">NOMBRE</label>
                                    <input type="text" class="form-control" name="txtnombreprov" id="txtnombreprov" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="txtrucprov">RUC</label>
                                    <input type="text" class="form-control" name="txtrucprov" id="txtrucprov" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="txttelprov">TELÉFONO</label>
                                    <input type="text" class="form-control" name="txttelprov" id="txttelprov" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="txtemailprov">CORREO</label>
                                    <input type="text" class="form-control" name="txtemailprov" id="txtemailprov" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="txtciudadprov">CIUDAD</label>
                                    <input type="text" class="form-control" name="txtciudadprov" id="txtciudadprov" readonly>
                                </div>
                                <%
                                        // Obtiene la última apertura de caja del usuario actual
                                        modeloabrircaja mf = new modeloabrircaja();
                                        mf.setIdusuario((String) sesion.getAttribute("idusuario"));
                                    %>

                                    <input type="hidden" name="txtaper" id="txtaper" value="<%= mf.obtenerultimapertura()%>" readonly>
                                    <input type="hidden" name="txtusu" id="txtusu" value="<%= sesion.getAttribute("idusuario")%>" readonly>
                            </div>
                        </div>
                    </div>
                </div>
                                
                <!-- Modal buscador proveedor -->
                <div id="miModal" class="modal">
                    <div class="modal-dialog modal-xl">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Buscador de Proveedores</h5>
                                <button type="button" class="close" onclick="cerrarModal()">&times;</button>
                            </div>
                            <div class="modal-body">
                                <table class="table table-bordered" id="mitabla">
                                    <thead>
                                        <tr>
                                            <th>CODIGO</th>
                                            <th>NOMBRE</th>
                                            <th>RUC</th>
                                            <th>TELÉFONO</th>
                                            <th>CORREO</th>
                                            <th>CIUDAD</th>
                                            <th>ACCION</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% modeloproveedor modelo = new modeloproveedor();
                                            List<modeloproveedor> list = modelo.listarProveedores();
                                            for (modeloproveedor m : list) {%>
                                        <tr>
                                            <td><span class="dato-input"><%= m.getCodigo()%></span></td>
                                            <td><span class="dato-input"><%= m.getNombre()%></span></td>
                                            <td><span class="dato-input"><%= m.getRuc()%></span></td>
                                            <td><span class="dato-input"><%= m.getTelefono()%></span></td>
                                            <td><span class="dato-input"><%= m.getCorreo()%></span></td>
                                            <td><span class="dato-input"><%= m.getCiudad()%></span></td>
                                            <td><button type="button" class="btn btn-primary" onclick="obtenerFilaProveedor(this)">SELECCIONAR</button></td>
                                        </tr>
                                        <% }%>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Lista de compras pendientes -->
                <div class="card mb-3">
                    <div class="card-header">Facturas Pendientes</div>
                    <div class="card-body">
                        <table class="table table-bordered" id="tablafactura">
                            <thead>
                                <tr>
                                    <th>CODIGO</th>
                                    <th>FECHA</th>
                                    <th>CONDICION</th>
                                    <th>MONTO</th>
                                    <th>SELECCIONAR</th>
                                </tr>
                            </thead>
                            <tbody id="tablaCuerpo">
                                <!-- Cuerpo de la tabla para mostrar facturas -->
                            </tbody>
                        </table>
                    </div>
                </div>
                <!-- Botón para guardar el pago -->
                <div class="text-center">
                    <button type="submit" class="btn btn-success" name="accion" value="guardarpago">GUARDAR</button>
                </div>
            </form>
        </div>

        <!-- Modales de advertencia -->
        <div class="modal fade" id="modalProveedor" tabindex="-1" role="dialog" aria-labelledby="modalProveedorLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalProveedorLabel">Advertencia</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        Por favor, seleccione un proveedor antes de continuar.
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>
<div class="modal fade" id="modalProveedor" tabindex="-1" role="dialog" aria-labelledby="modalProveedorLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalProveedorLabel">Advertencia</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        Por favor, seleccione un proveedor antes de continuar.
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="modalNoDeudas" tabindex="-1" role="dialog" aria-labelledby="modalCompraLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalCompraLabel">Advertencia</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        No existe un pago pendiente con este proveedor.
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="modalCodigo" tabindex="-1" role="dialog" aria-labelledby="modalCompraLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalCompraLabel">Advertencia</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        Por favor, rellene el codigo de pago.
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
                                                document.addEventListener("DOMContentLoaded", function () {
                                                    // Función para obtener la fecha actual y establecerla en un campo de texto
                                                    var fechaActual = new Date();
                                                    var dia = fechaActual.getDate();
                                                    var mes = fechaActual.getMonth() + 1;
                                                    var año = fechaActual.getFullYear();

                                                    if (mes <= 9) {
                                                        mes = "0" + mes;
                                                    }

                                                    var fechaFormateada = año + "-" + mes + "-" + dia;
                                                    document.getElementById("txtfecha").value = fechaFormateada.toString();
                                                });

                                                // Función para mostrar la ventana modal
                                                function mostrarModal() {
                                                    event.preventDefault();
                                                    $('#miModal').modal('show');
                                                }

                                                // Función para cerrar la ventana modal
                                                function cerrarModal() {
                                                    event.preventDefault();
                                                    $('#miModal').modal('hide');
                                                }

                                                // Función para obtener datos de fila de proveedor seleccionado
                                                // Función para obtener datos de fila de proveedor seleccionado
                                                // Función para obtener datos de fila de proveedor seleccionado
                                                function obtenerFilaProveedor(boton) {
                                                    event.preventDefault();
                                                    var fila = boton.parentNode.parentNode;
                                                    var celdas = fila.getElementsByTagName("td");
                                                    var datosFila = [];

                                                    for (var i = 0; i < celdas.length - 1; i++) {
                                                        var valor = celdas[i].querySelector(".dato-input").textContent;
                                                        datosFila.push(valor);
                                                    }

                                                    console.log("Datos de la fila seleccionada:", datosFila);

                                                    document.getElementById("txtcodigoprov").value = datosFila[0];
                                                    document.getElementById("txtnombreprov").value = datosFila[1];
                                                    document.getElementById("txtrucprov").value = datosFila[2];
                                                    document.getElementById("txttelprov").value = datosFila[3];
                                                    document.getElementById("txtemailprov").value = datosFila[4];
                                                    document.getElementById("txtciudadprov").value = datosFila[5];

                                                    cerrarModal();

                                                    var xhr = new XMLHttpRequest();
                                                    xhr.open("POST", "pagocontrolador", true);
                                                    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

                                                    xhr.onreadystatechange = function () {
                                                        if (xhr.readyState === 4) {
                                                            console.log("Estado de la solicitud:", xhr.status);
                                                            if (xhr.status === 200) {
                                                                var tablaCuerpo = document.getElementById("tablaCuerpo");
                                                                tablaCuerpo.innerHTML = xhr.responseText; // Actualizar contenido de tablaCuerpo

                                                                // Verificar si la tabla está vacía
                                                                if (tablaCuerpo.rows.length === 0) {
                                                                    console.log("La tablaCuerpo está vacía.");
                                                                    $('#modalNoDeudas').modal('show');
                                                                }
                                                            } else {
                                                                console.error("Error en la solicitud:", xhr.status);

                                                            }
                                                        }
                                                    };

                                                    var params = "accion=buscarComprasPendientes&proveedorId=" + datosFila[0];
                                                    console.log("Parámetros de la solicitud:", params);
                                                    xhr.send(params);
                                                }

                                                // Validación del formulario antes de enviar
                                                function validarFormulario() {
                                                    var proveedorSeleccionado = document.getElementById("txtcodigoprov").value.trim();
                                                    var pagoCodigo = document.getElementById("txtcodigo").value.trim();
                                                    var filasFacturas = document.getElementById("tablaCuerpo").getElementsByTagName("tr").length;

                                                    if (proveedorSeleccionado === "") {
                                                        $('#modalProveedor').modal('show');
                                                        return false;
                                                    }

                                                    if (pagoCodigo === "") {
                                                        $('#modalCodigo').modal('show');
                                                        return false;
                                                    }

                                                    if (filasFacturas === 0) {
                                                        $('#modalCompra').modal('show');
                                                        return false;
                                                    }

                                                    var checkboxes = document.querySelectorAll('#tablaCuerpo input[type="checkbox"]');
                                                    var alMenosUnoSeleccionado = false;

                                                    for (var i = 0; i < checkboxes.length; i++) {
                                                        if (checkboxes[i].checked) {
                                                            alMenosUnoSeleccionado = true;
                                                            break;
                                                        }
                                                    }

                                                    if (!alMenosUnoSeleccionado) {
                                                        $('#modalCompra').modal('show');
                                                        return false;
                                                    }

                                                    var montoValido = true;
                                                    var inputsMontos = document.querySelectorAll('#tablaCuerpo input[type="number"]');

                                                    for (var j = 0; j < inputsMontos.length; j++) {
                                                        var monto = parseFloat(inputsMontos[j].value);

                                                        if (isNaN(monto) || monto <= 0) {
                                                            montoValido = false;
                                                            break;
                                                        }
                                                    }

                                                    if (!montoValido) {
                                                        $('#modalMonto').modal('show');
                                                        return false;
                                                    }

                                                    // Si pasa todas las validaciones, se envía el formulario
                                                    return true;
                                                }

        </script>

    </body>
</html>
