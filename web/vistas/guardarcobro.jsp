<%@page import="modelo.cobromodelo"%>
<%@page import="java.util.List"%>
<%@page import="modelo.modelocliente"%>
<%@page import="modelo.facturaventamodelo"%>
<%@page import="modelo.modeloabrircaja"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registrar Cobro</title>
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
            .form-control[readonly] {
                background-color: #e9ecef;
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
            <form id="formCobro" action="cobrocontrolador2" method="post" onsubmit="return validarFormulario()">
                <!-- Campo oculto para el código de sesión -->
                <input type="hidden" name="lblcodigo" value="<%= sesion.getAttribute("codigo")%>">
                <div class="row">
                    <div class="col-md-6">
                        <!-- Datos del cobro -->
                        <div class="card mb-3">
                            <div class="card-header">Datos del Cobro</div>
                            <div class="card-body">
                                <div class="form-group">
                                    <label for="txtcodigo">N° COBRO</label>
                                    <input type="text" class="form-control" name="txtcodigo" id="txtcodigo" value="<%= new cobromodelo().obtenerProximoNumeroFactura()%>" readonly>
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
                        <!-- Datos del cliente -->
                        <div class="card mb-3">
                            <div class="card-header">Datos del Cliente</div>
                            <div class="card-body">
                                <div class="form-group">
                                    <label for="txtcodigocli">CODIGO</label>
                                    <div class="input-group">
                                        <input type="text" class="form-control" name="txtcodigocli" id="txtcodigocli" readonly>
                                        <div class="input-group-append">
                                            <button type="button" class="btn btn-primary" name="btnbuscarcli" onclick="mostrarModal()">BUSCAR</button>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="txtnombre">NOMBRE</label>
                                    <input type="text" class="form-control" name="txtnombre" id="txtnombre" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="txtapellido">APELLIDO</label>
                                    <input type="text" class="form-control" name="txtapellido" id="txtapellido" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="txtci">RUC/CI</label>
                                    <input type="text" class="form-control" name="txtci" id="txtci" readonly>
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
                </div>
                <!-- Modal buscador cliente -->
                <div id="miModal" class="modal">
                    <!-- Contenido del modal -->
                    <div class="modal-dialog modal-xl">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Buscador de Clientes</h5>
                                <button type="button" class="close" onclick="cerrarModal()">&times;</button>
                            </div>
                            <div class="modal-body">
                                <table class="table table-bordered" id="mitabla">
                                    <thead>
                                        <tr>
                                            <th>CODIGO</th>
                                            <th>NOMBRE</th>
                                            <th>APELLIDO</th>
                                            <th>CI</th>
                                            <th>TELEFONO</th>
                                            <th>CIUDAD</th>
                                            <th>ACCION</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% modelocliente modelo = new modelocliente();
                                            List<modelocliente> list = modelo.listarClientes();
                                            for (modelocliente m : list) {%>
                                        <tr>
                                            <td><span class="dato-input"><%= m.getCodigo()%></span></td>
                                            <td><span class="dato-input"><%= m.getNombre()%></span></td>
                                            <td><span class="dato-input"><%= m.getApellido()%></span></td>
                                            <td><span class="dato-input"><%= m.getRuc()%></span></td>
                                            <td><span class="dato-input"><%= m.getTelefono()%></span></td>
                                            <td><span class="dato-input"><%= m.getCiudad()%></span></td>
                                            <td><button type="button" class="btn btn-primary" onclick="obtenerFilacliente(this)">SELECCIONAR</button></td>
                                        </tr>
                                        <% }%>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Lista de facturas pendientes -->
                <div class="card mb-3">
                    <div class="card-header">Facturas Pendientes</div>
                    <div class="card-body">
                        <table class="table table-bordered" id="tablafactura">
                            <thead>
                                <tr>
                                    <th>CODIGO</th>
                                    <th>ESTADO</th>
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
                <!-- Botón para guardar el cobro -->
                <div class="text-center">
                    <button type="submit" class="btn btn-success" name="accion" value="guardarcobro">GUARDAR</button>
                </div>

                <!-- Modales de advertencia -->
                <div class="modal fade" id="modalCliente" tabindex="-1" role="dialog" aria-labelledby="modalClienteLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="modalClienteLabel">Advertencia</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                Por favor, seleccione un cliente antes de continuar.
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal fade" id="modalCodigo" tabindex="-1" role="dialog" aria-labelledby="modalCodigoLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="modalClienteLabel">Advertencia</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                Por favor, ingrese el numero de  factura del cobro.
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal fade" id="modalFactura" tabindex="-1" role="dialog" aria-labelledby="modalFacturaLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="modalFacturaLabel">Advertencia</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                Por favor, seleccione al menos una factura antes de continuar.
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal fade" id="modalMonto" tabindex="-1" role="dialog" aria-labelledby="modalMontoLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="modalMontoLabel">Advertencia</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                Por favor, ingrese montos válidos mayores a cero para las facturas seleccionadas.
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Modal para cuando no hay facturas pendientes del cliente -->
                <div class="modal fade" id="modalNoDeudas" tabindex="-1" role="dialog" aria-labelledby="modalNoDeudasLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Advertencia</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                Este cliente no tiene facturas pendientes.
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                            </div>
                        </div>
                    </div>
                </div>

            </form>
        </div>
        <!-- Script JavaScript para manejar eventos en la página -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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

                                                // Función para obtener datos de fila de cliente seleccionado
                                                function obtenerFilacliente(boton) {
                                                    event.preventDefault();
                                                    var fila = boton.parentNode.parentNode;
                                                    var celdas = fila.getElementsByTagName("td");
                                                    var datosFila = [];

                                                    for (var i = 0; i < celdas.length - 1; i++) {
                                                        var valor = celdas[i].querySelector(".dato-input").textContent;
                                                        datosFila.push(valor);
                                                    }

                                                    document.getElementById("txtcodigocli").value = datosFila[0];
                                                    document.getElementById("txtnombre").value = datosFila[1];
                                                    document.getElementById("txtapellido").value = datosFila[2];
                                                    document.getElementById("txtci").value = datosFila[3];
                                                    cerrarModal();

                                                    var xhr = new XMLHttpRequest();
                                                    xhr.open("POST", "cobrocontrolador2", true);
                                                    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

                                                    xhr.onreadystatechange = function () {
                                                        if (xhr.readyState === 4 && xhr.status === 200) {
                                                            var tablaCuerpo = document.getElementById("tablaCuerpo");
                                                            tablaCuerpo.innerHTML = xhr.responseText;

                                                            // Verificar si la tabla está vacía
                                                            if (tablaCuerpo.rows.length === 0) {
                                                                $('#modalNoDeudas').modal('show');
                                                            }
                                                        }
                                                    };

                                                    var params = "accion=buscarFacturasPendientes&clienteId=" + datosFila[0];
                                                    xhr.send(params);
                                                }
                                                // Validación del formulario antes de enviar
                                                // Validación del formulario antes de enviar
                                                function validarFormulario() {
                                                    var clienteSeleccionado = document.getElementById("txtcodigocli").value.trim();
                                                    var cobroCodigo = document.getElementById("txtcodigo").value.trim(); // Nuevo código para obtener el valor del campo txtcodigo
                                                    var filasFacturas = document.getElementById("tablaCuerpo").getElementsByTagName("tr").length;

                                                    if (clienteSeleccionado === "") {
                                                        $('#modalCliente').modal('show');
                                                        return false;
                                                    }

                                                    if (cobroCodigo === "") { // Validación del campo txtcodigo
                                                        // Mostrar modal de advertencia específico para el campo txtcodigo
                                                        $('#modalCodigo').modal('show');
                                                        return false;
                                                    }

                                                    if (filasFacturas === 0) {
                                                        $('#modalFactura').modal('show');
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
                                                        $('#modalFactura').modal('show');
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
