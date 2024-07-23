<%-- 
    Document   : guardarfactura
    Created on : 25 may 2024, 23:35:59
    Author     : juana
--%>
<%@page import="modelo.facturaventamodelo"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="modelo.modelocliente"%>
<%@page import="modelo.modeloabrircaja"%>
<%@page import="modelo.modeloproducto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Guardar Factura</title>

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
            facturaventamodelo facturaModelo = new facturaventamodelo();
            String ultimoNumeroFactura = facturaModelo.obtenerUltimoNumeroFactura();
            int nuevoNumeroFactura = Integer.parseInt(ultimoNumeroFactura) + 1;
        %>
        <%
            HttpSession sesion2 = request.getSession();
            modeloabrircaja verificar = new modeloabrircaja();
            Object a = sesion2.getAttribute("idusuario");
            verificar.setIdusuario((String) a);
            if (!verificar.validarCaja().equals("ABIERTA")) {
                request.setAttribute("validarcaja", "cerrada");
                request.getRequestDispatcher("../menuprincipal.jsp").forward(request, response);
            }
        %>
        <%@ include file="../plantilla.jsp" %>
        <div class="container my-4">
            <form action="facturaventacontrolador" method='post'>
                <h2 class="text-center mb-2" style="padding-left:20px !important;">FACTURACIÓN</h2>
                <input type="hidden" name="lblcodigo" value="<%= sesion.getAttribute("codigo")%>">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">Datos de la Factura</h5>
                                <div class="form-group">
                                    <label for="txtnumero">N factura</label>
                                    <input type="text" class="form-control" name="txtnumero" value="<%= nuevoNumeroFactura%>" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="condicion">Condición</label>
                                    <select class="form-control" name="condicion">
                                        <option value="contado">Contado</option>
                                        <option value="credito">Crédito</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="txtfechafac">Fecha</label>
                                    <input type="text" class="form-control" id="txtfecha" name="txtfechafac" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="txtestado">Estado</label>
                                    <input type="text" class="form-control" id="txtestado" value="PENDIENTE" readonly>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">Datos del Cliente</h5>
                                <div class="form-group">
                                    <label for="txtcodigocli">Código</label>
                                    <div class="input-group">
                                        <input type="text" class="form-control" name="txtcodigocli" id="txtcodigo" readonly required>
                                        <div class="input-group-append" >
                                            <button type="button" class="btn btn-primary" name="txtbuscarcli" onclick="mostrarModal()" style="position:relative;top:-5px" >BUSCAR</button>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="txtnombre">Nombre</label>
                                    <input type="text" class="form-control" name="txtnombre" id="txtnombre" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="txtapellido">Apellido</label>
                                    <input type="text" class="form-control" name="txtapellido" id="txtapellido" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="txtruc">RUC/CI</label>
                                    <input type="text" class="form-control" name="txtruc" id="txtruc" readonly>
                                    <%
                                        modeloabrircaja mf = new modeloabrircaja();
                                        mf.setIdusuario((String) sesion.getAttribute("idusuario"));
                                    %>
                                    <input type="hidden" name="txtaper" id="txtaper" value="<%=mf.obtenerultimapertura()%>" readonly>
                                    <input type="hidden" name="txtusu" id="txtusu" value="<%=sesion.getAttribute("idusuario")%>" readonly>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row justify-content-center mb-3">
                    <div class="col-12 col-md-4 mb-3">
                        <div class="form-group">
                            <label for="txtcodpro">Código</label>
                            <div class="input-group">
                                <input type="text" class="form-control" name="txtcodprod" id="txtcodpro" disabled>
                                <input type="hidden" name="txtiva" id="txtiva">
                                <input type="hidden" name="txtprecio" id="txtprecio">
                                <div class="input-group-append">
                                    <button type="button" class="btn btn-primary" onclick="mostrarModalp()" style="position:relative;top:-5px">BUSCAR</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class=" col-md-4 mb-3">
                        <div class="form-group">
                            <label id="txtnombrepro" style="position:relative;top:35px"></label>
                        </div>
                    </div>
                    <div class=" col-md-2 mb-3">
                        <div class="form-group">
                            <label for="txtcantidad">Cantidad</label>
                            <input type="number" class="form-control" name="txtcantidad" id="txtcantidad" required>
                        </div>
                    </div>
                    <div class=" col-md-2 mb-3">
                        <div class="form-group">
                            <label style="visibility: hidden;">AgregaBotón</label>
                            <button type="button" class="btn btn-success btn-block" onclick="cargarproducto()" style="position:relative;top:-5px;left:-20px">AGREGAR</button>
                        </div>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table table-bordered" id="tablafactura">
                        <thead class="thead-light">
                            <tr>
                                <th>CODIGO</th>
                                <th>CANTIDAD</th>
                                <th>DESCRIPCION</th>
                                <th>P.U</th>
                                <th>EXENTA</th>
                                <th>5%</th>
                                <th>10%</th>
                                <th>ACCION</th>
                            </tr>
                        </thead>
                        <tbody id="tablaCuerpo">
                        </tbody>
                    </table>
                </div>
                <button type="submit" class="btn btn-primary" name="accion" value="guardarfactura">GUARDAR</button>
            </form>
        </div>

        <!-- Modal Cliente -->
        <div id="miModal" class="modal" tabindex="-1" role="dialog">
            <div class="modal-dialog modal-xl" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">BUSCADOR DE CLIENTES</h5>
                        <button type="button" class="close" onclick="cerrarModal()" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <table class="table table-striped">
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
                                <%
                                    modelocliente modelo = new modelocliente();
                                    List<modelocliente> list = modelo.listarClientes();
                                    Iterator<modelocliente> iter = list.iterator();
                                    modelocliente m = null;
                                    while (iter.hasNext()) {
                                        m = iter.next();
                                %>
                                <tr>
                                    <td><span class="dato-input"><%=m.getCodigo()%></span></td>
                                    <td><span class="dato-input"><%=m.getNombre()%></span></td>
                                    <td><span class="dato-input"><%=m.getApellido()%></span></td>
                                    <td><span class="dato-input"><%=m.getRuc()%></span></td>
                                    <td><span class="dato-input"><%=m.getTelefono()%></span></td>
                                    <td><span class="dato-input"><%=m.getCiudad()%></span></td>
                                    <td><button type="button" class="btn btn-primary" onclick="obtenerFilacliente(this)">SELECCIONAR</button></td>
                                </tr>
                                <%}%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal Producto -->
        <div id="miModalp" class="modal" tabindex="-1" role="dialog" >
            <div class="modal-dialog modal-xl" role="document" >
                <div class="modal-content" >
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
                                    <th>IVA</th>
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
                                    <td><span class="dato-input"><%=mp.getIva()%></span></td>
                                    <td><button type="button" class="btn btn-primary" onclick="moverFilaProducto(this)">SELECCIONAR</button></td>
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
                        Por favor, selecciona un elemento antes de continuar.
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

        <!-- Modal de Cliente No Seleccionado -->
        <div class="modal fade" id="modalClienteNoSeleccionado" tabindex="-1" role="dialog" aria-labelledby="modalClienteNoSeleccionadoLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalClienteNoSeleccionadoLabel">Error: Cliente no Seleccionado</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        Por favor, selecciona un cliente antes de continuar.
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
        <div class="modal fade" id="modalRegistros" tabindex="-1" role="dialog" aria-labelledby="modalProductoNoSeleccionadoLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalProductoNoSeleccionadoLabel">Error: Producto no Seleccionado</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        No se encuentra ningún registro en la tabla de productos.
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
                                        // Aquí irían tus scripts de JavaScript
        </script>
    </body>
</html>


<!-- Custom Script -->
<script>
    var fechaActual = new Date();
    var dia = fechaActual.getDate();
    var mes = fechaActual.getMonth() + 1;
    var año = fechaActual.getFullYear();
    var fechaFormateada = año + "-" + (mes < 10 ? '0' : '') + mes + "-" + (dia < 10 ? '0' : '') + dia;
    document.getElementById("txtfecha").value = fechaFormateada;
    document.addEventListener("DOMContentLoaded", function () {
        var guardarButton = document.querySelector("button[name='accion'][value='guardarfactura']");

        guardarButton.addEventListener("click", function (event) {
            var tableBody = document.getElementById("tablaCuerpo");
            var rowCount = tableBody.rows.length;

            if (rowCount === 0) {
                event.preventDefault();
                $('#modalRegistros').modal('show');
            }
        });
    });

    function mostrarModal() {
        $('#miModal').modal('show');
    }

    function cerrarModal() {
        $('#miModal').modal('hide');
    }

    function mostrarModalp() {
        $('#miModalp').modal('show');
    }

    function cerrarModalp() {
        $('#miModalp').modal('hide');
    }

    function obtenerFilacliente(boton) {
        var fila = boton.parentNode.parentNode;
        var celdas = fila.getElementsByTagName("td");
        var datosFila = [];
        for (var i = 0; i < celdas.length - 1; i++) {
            var valor = celdas[i].querySelector(".dato-input").textContent;
            datosFila.push(valor);
        }
        if (datosFila.length === 0 || datosFila[0].trim() === "") {
            $('#modalClienteNoSeleccionado').modal('show');
            return;
        }

        document.getElementById("txtcodigo").value = datosFila[0];
        document.getElementById("txtnombre").value = datosFila[1];
        document.getElementById("txtapellido").value = datosFila[2];
        document.getElementById("txtruc").value = datosFila[3];
        cerrarModal();
    }


    function moverFilaProducto(boton) {
        var fila = boton.parentNode.parentNode;
        var celdas = fila.getElementsByTagName("td");
        var datosFila = [];
        for (var i = 0; i < celdas.length - 1; i++) {
            var valor = celdas[i].querySelector(".dato-input").textContent;
            datosFila.push(valor);
        }
        var codigo = datosFila[0];
        if (codigo === "") {
            $('#modalProductoNoSeleccionado').modal('show');
            return;
        }
        document.getElementById("txtcodpro").value = datosFila[0];
        document.getElementById("txtnombrepro").textContent = datosFila[1];
        document.getElementById("txtprecio").value = datosFila[3];

        var iva = parseInt(datosFila[6]);
        var exenta = iva === 0 ? "exenta" : "";

        document.getElementById("txtiva").value = exenta || iva;

        cerrarModalp();
        var input = document.getElementById("txtcantidad");
        input.focus();
        console.log("Valor de iva:", iva);
    }

    function cargarproducto() {
        event.preventDefault();
        var codigo = document.getElementById("txtcodpro").value;
        var cliente = document.getElementById("txtnombre").value;
        if (cliente === "") {
            $('#modalClienteNoSeleccionado').modal('show');
            return;
        }

        if (codigo === "") {
            $('#modalAdvertencia').modal('show');
            return;
        }


        var cantidad = parseInt(document.getElementById("txtcantidad").value);
        if (isNaN(cantidad) || cantidad <= 0) {
            $('#modalCantidadInvalida').modal('show');
            return;
        }


        var nombre = document.getElementById("txtnombrepro").textContent;
        var precio = parseFloat(document.getElementById("txtprecio").value);
        var iva = parseFloat(document.getElementById("txtiva").value);

        var montoIVA = 0;
        if (iva === 10) {
            montoIVA = (precio * cantidad * iva) / 100;
        }

        var montoExenta = 0;
        var montoCinco = 0;
        if (iva === 0) {
            montoExenta = precio * cantidad;
        } else if (iva === 5) {
            montoCinco = (precio * cantidad * iva) / 100;
        }

        var ivaTabla = isNaN(iva) ? "Exenta" : "";

        var cuerpoTabla = document.getElementById("tablaCuerpo");
        var fila = document.createElement("tr");

        var celdaCodigo = document.createElement("td");
        var inputCodigo = document.createElement("input");
        inputCodigo.type = "text";
        inputCodigo.value = codigo;
        inputCodigo.name = "codigo[]";
        inputCodigo.style.border = "none";
        inputCodigo.readOnly = true;
        celdaCodigo.appendChild(inputCodigo);
        fila.appendChild(celdaCodigo);

        var celdaCantidad = document.createElement("td");
        var inputCantidad = document.createElement("input");
        inputCantidad.type = "text";
        inputCantidad.value = cantidad;
        inputCantidad.name = "cantidad[]";
        inputCantidad.style.border = "none";
        celdaCantidad.appendChild(inputCantidad);
        fila.appendChild(celdaCantidad);

        var celdaNombre = document.createElement("td");
        var textoNombre = document.createTextNode(nombre);
        celdaNombre.appendChild(textoNombre);
        fila.appendChild(celdaNombre);

        var celdaPrecio = document.createElement("td");
        var inputPrecio = document.createElement("input");
        inputPrecio.type = "text";
        inputPrecio.value = precio;
        inputPrecio.name = "precio[]";
        inputPrecio.style.border = "none";
        celdaPrecio.appendChild(inputPrecio);
        fila.appendChild(celdaPrecio);

        var celdaExenta = document.createElement("td");
        var textoExenta = document.createTextNode(ivaTabla);
        celdaExenta.appendChild(textoExenta);
        fila.appendChild(celdaExenta);

        var celdaCinco = document.createElement("td");
        if (iva === 5) {
            var textoMontoCinco = document.createTextNode(montoCinco.toFixed(2));
            celdaCinco.appendChild(textoMontoCinco);
        }
        fila.appendChild(celdaCinco);

        var celdaDiez = document.createElement("td");
        if (iva === 10) {
            var textoMontoIVA = document.createTextNode(montoIVA.toFixed(2));
            celdaDiez.appendChild(textoMontoIVA);
        }
        fila.appendChild(celdaDiez);

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
        console.log("Valor de 'condicion': ", document.getElementsByName("condicion")[0].value);
    }
</script>
</body>
</html>
