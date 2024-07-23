<%-- 
    Document   : guardarinventario
    Created on : 25 may 2024, 23:35:59
    Author     : juana
--%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="modelo.modeloproducto"%>
<%@page import="modelo.modeloabrircaja"%>
<%@page import="modelo.inventariomodelo2"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Guardar Inventario</title>

        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
                position: relative;
                top: 1px;
            }
            .container {
                width: 100%;
                background-color: #ffffff;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                margin-top: 20px;
                min-height: calc(150vh - 5px);
            }
            .row {
                margin-bottom: 15px;
            }
            .form-control[readonly] {
                background-color: #e9ecef;
                opacity: 1;
            }
            .table-responsive {
                margin-top: 20px;
            }
            .table td, .table th {
                vertical-align: middle;
            }
        </style>
    </head>
    <body class="bg-light">
        <%
            inventariomodelo2 inventarioModelo = new inventariomodelo2();
            String ultimoNumeroInventario = inventarioModelo.obtenerUltimoNumeroInventario();
            int nuevoNumeroInventario = Integer.parseInt(ultimoNumeroInventario) + 1;
        %>
        <%@ include file="../plantilla.jsp" %>
        <div class="container my-4">
            <form action="inventariocontrolador2" method='post'>
                <h2 class="text-center mb-2" style="padding-left:20px !important;">INVENTARIO</h2>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">Datos del Inventario</h5>
                                <div class="form-group">
                                    <label for="txtidinventario">ID Inventario</label>
                                    <input type="text" class="form-control" name="txtidinventario" value="<%= nuevoNumeroInventario%>" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="txtfechainv">Fecha</label>
                                    <input type="text" class="form-control" id="txtfechainv" name="txtfechainv" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="txtnombre">Nombre</label>
                                    <input type="text" class="form-control" id="txtnombre" name="txtnombre" readonly>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">Datos del Producto</h5>
                                <div class="form-group">
                                    <label for="txtidproducto">ID Producto</label>
                                    <div class="input-group">
                                        <input type="text" class="form-control" name="txtidproducto" id="txtidproducto" readonly required>
                                        <div class="input-group-append">
                                            <button type="button" class="btn btn-primary" name="txtbuscarprod" onclick="mostrarModalp()" style="position:relative;top:-5px">BUSCAR</button>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="txtstockactual">Stock Actual</label>
                                    <input type="text" class="form-control" name="txtstockactual" id="txtstockactual" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="txtaccion">Acción a Realizar</label>
                                    <select class="form-control" name="txtaccion" id="txtaccion">
                                        <option value="Aumentar">Aumentar</option>
                                        <option value="Disminuir">Disminuir</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="txtcantidad">Cantidad a Modificar</label>
                                    <input type="number" class="form-control" name="txtcantidad" id="txtcantidad" required>
                                </div>
                                <div class="form-group">
                                    <button type="button" class="btn btn-success" onclick="modificarProducto()">MODIFICAR</button>
                                </div>
                            </div>
                        </div>
                        <%
                            modeloabrircaja mf = new modeloabrircaja();
                            mf.setIdusuario((String) sesion.getAttribute("idusuario"));
                        %>
                        <input type="hidden" name="txtaper" id="txtaper" value="<%=mf.obtenerultimapertura()%>" readonly>
                        <input type="hidden" name="txtusu" id="txtusu" value="<%=sesion.getAttribute("idusuario")%>" readonly>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table table-bordered" id="tablaInventario">
                        <thead class="thead-light">
                            <tr>
                                <th>ID Inventario</th>
                                <th>ID Producto</th>
                                <th>Stock Actual</th>
                                <th>Cantidad a Modificar</th>
                                <th>Acción</th>
                                <th>Eliminar</th>
                            </tr>
                        </thead>
                        <tbody id="tablaCuerpoInventario">
                        </tbody>
                    </table>
                </div>
                <button type="submit" class="btn btn-primary" name="accion" value="guardarinventario">GUARDAR</button>
            </form>
        </div>

        <!-- Modal Producto -->
        <div id="miModalp" class="modal" tabindex="-1" role="dialog">
            <div class="modal-dialog modal-xl" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">BUSCADOR DE PRODUCTOS</h5>
                        <button type="button" class="close" onclick="cerrarModalp()" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>CODIGO</th>
                                    <th>NOMBRE</th>
                                    <th>STOCK</th>
                                    <th>COSTO</th>
                                    <th>PRECIO</th>
                                    <th>MINIMO</th>
                                    <th>ACCION</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    modeloproducto modelop = new modeloproducto();
                                    List<modeloproducto> listp = modelop.listarProductos();
                                    Iterator<modeloproducto> iterp = listp.iterator();
                                    modeloproducto mp = null;
                                    while (iterp.hasNext()) {
                                        mp = iterp.next();
                                %>
                                <tr>
                                    <td><span class="dato-input"><%=mp.getId()%></span></td>
                                    <td><span class="dato-input"><%=mp.getNombre()%></span></td>
                                    <td><span class="dato-input"><%=mp.getStock()%></span></td>
                                    <td><span class="dato-input"><%=mp.getCosto()%></span></td>
                                    <td><span class="dato-input"><%=mp.getPrecio()%></span></td>
                                    <td><span class="dato-input"><%=mp.getStockMinimo()%></span></td>
                                    <td><button type="button" class="btn btn-primary" onclick="obtenerFilaProducto(this)">SELECCIONAR</button></td>
                                </tr>
                                <%}%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal de Advertencia -->
        <div class="modal fade" id="modalAdvertencia" tabindex="-1" role="dialog" aria-labelledby="modalAdvertenciaLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalAdvertenciaLabel">Advertencia</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        Por favor, selecciona un producto antes de continuar.
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal de Cantidad Inválida -->
        <div class="modal fade" id="modalCantidadInvalida" tabindex="-1" role="dialog" aria-labelledby="modalCantidadInvalidaLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalCantidadInvalidaLabel">Error de Cantidad</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        La cantidad ingresada es inválida. Por favor, introduce una cantidad válida.
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal de Producto No Seleccionado -->
        <div class="modal fade" id="modalProductoNoSeleccionado" tabindex="-1" role="dialog" aria-labelledby="modalProductoNoSeleccionadoLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalProductoNoSeleccionadoLabel">Error: Producto no Seleccionado</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        Por favor, selecciona un producto antes de continuar.
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
                                        var fechaActual = new Date();
                                        var dia = fechaActual.getDate();
                                        var mes = fechaActual.getMonth() + 1;
                                        var año = fechaActual.getFullYear();
                                        var fechaFormateada = año + "-" + (mes < 10 ? '0' : '') + mes + "-" + (dia < 10 ? '0' : '') + dia;
                                        document.getElementById("txtfechainv").value = fechaFormateada;

                                        document.addEventListener("DOMContentLoaded", function () {
                                            var guardarButton = document.querySelector("button[name='accion'][value='guardarinventario']");

                                            guardarButton.addEventListener("click", function (event) {
                                                var tableBody = document.getElementById("tablaCuerpoInventario");
                                                var rowCount = tableBody.rows.length;

                                                if (rowCount === 0) {
                                                    event.preventDefault();
                                                    $('#modalAdvertencia').modal('show');
                                                }
                                            });
                                        });

                                        function mostrarModalp() {
                                            $('#miModalp').modal('show');
                                        }

                                        function cerrarModalp() {
                                            $('#miModalp').modal('hide');
                                        }

                                        function obtenerFilaProducto(boton) {
                                            var fila = boton.parentNode.parentNode;
                                            var celdas = fila.getElementsByTagName("td");
                                            var datosFila = [];
                                            for (var i = 0; i < celdas.length - 1; i++) {
                                                var valor = celdas[i].querySelector(".dato-input").textContent;
                                                datosFila.push(valor);
                                            }
                                            if (datosFila.length === 0 || datosFila[0].trim() === "") {
                                                $('#modalProductoNoSeleccionado').modal('show');
                                                return;
                                            }

                                            document.getElementById("txtidproducto").value = datosFila[0];
                                            document.getElementById("txtnombre").value = datosFila[1];
                                            document.getElementById("txtstockactual").value = datosFila[2];
                                            cerrarModalp();
                                        }

                                        function modificarProducto() {
                                            event.preventDefault();
                                            var idInventario = document.querySelector("input[name='txtidinventario']").value;
                                            var idProducto = document.querySelector("input[name='txtidproducto']").value;
                                            var stockActual = document.querySelector("input[name='txtstockactual']").value;
                                            var accion = document.querySelector("select[name='txtaccion']").value;
                                            var cantidad = document.querySelector("input[name='txtcantidad']").value;

                                            if (idProducto === "" || cantidad === "") {
                                                $('#modalAdvertencia').modal('show');
                                                return;
                                            }

                                            if (isNaN(cantidad) || cantidad <= 0) {
                                                $('#modalCantidadInvalida').modal('show');
                                                return;
                                            }

                                            var cuerpoTabla = document.getElementById("tablaCuerpoInventario");
                                            var fila = document.createElement("tr");

                                            var celdaIdInventario = document.createElement("td");
                                            celdaIdInventario.innerHTML = '<input type="hidden" name="idinventario[]" value="' + idInventario + '">' + idInventario;
                                            fila.appendChild(celdaIdInventario);

                                            var celdaIdProducto = document.createElement("td");
                                            celdaIdProducto.innerHTML = '<input type="hidden" name="idproducto[]" value="' + idProducto + '">' + idProducto;
                                            fila.appendChild(celdaIdProducto);

                                            var celdaStockActual = document.createElement("td");
                                            celdaStockActual.innerHTML = '<input type="hidden" name="stock[]" value="' + stockActual + '">' + stockActual;
                                            fila.appendChild(celdaStockActual);

                                            var celdaCantidad = document.createElement("td");
                                            celdaCantidad.innerHTML = '<input type="hidden" name="cantidad[]" value="' + cantidad + '">' + cantidad;
                                            fila.appendChild(celdaCantidad);

                                            var celdaAccion = document.createElement("td");
                                            celdaAccion.innerHTML = '<input type="hidden" name="accion[]" value="' + accion + '">' + accion;
                                            fila.appendChild(celdaAccion);

                                            var celdaBoton = document.createElement("td");
                                            var boton = document.createElement("button");
                                            boton.textContent = "Eliminar";
                                            boton.type = "button";
                                            boton.classList.add("btn", "btn-danger");
                                            boton.addEventListener("click", function () {
                                                var fila = this.parentNode.parentNode;
                                                fila.remove();
                                            });
                                            celdaBoton.appendChild(boton);
                                            fila.appendChild(celdaBoton);

                                            cuerpoTabla.appendChild(fila);
                                        }
        </script>

    </body>
</html>
