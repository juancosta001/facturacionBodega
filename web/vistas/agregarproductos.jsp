<%-- 
    Document   : agregarproductos
    Created on : 23 abr 2024, 22:23:33
    Author     : juana
--%>
<%@page import="java.util.List"%>
<%@page import="modelo.modeloproveedor"%>
<%@page import="modelo.modeloproducto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Agregar Productos</title>
</head>
<body>
     
<%
    // Obtener el último código de producto
    modeloproducto modeloProducto = new modeloproducto();
    String ultimoCodigoProducto = modeloProducto.obtenerUltimoCodigo();
    int siguienteCodigoProducto = Integer.parseInt(ultimoCodigoProducto) + 1;

    // Obtener lista de proveedores
    modeloproveedor modeloProveedor = new modeloproveedor();
    List<modeloproveedor> listaProveedores = modeloProveedor.listarProveedores();
%>
<%@include file="../plantilla.jsp" %>
<div class="container" style="background-color: transparent !important;">
    <div class="row">
        <div class="col-md-6 offset-md-3">
            <div class="form-container">
                <h1>AGREGAR PRODUCTO</h1>
                <form action="./productocontrolador" method="post">
                    <div class="form-group">
                        <label for="txtcodigo">Código:</label>
                        <input type="text" id="txtcodigo" name="txtcodigo" class="form-control" value="<%= siguienteCodigoProducto %>" disabled>
                    </div>
                    <div class="form-group">
                        <label for="txtnombre">Nombre:</label>
                        <input type="text" id="txtnombre" name="txtnombre" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="txtcosto">Costo:</label>
                        <input type="text" id="txtcosto" name="txtcosto" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="txtprecio">Precio:</label>
                        <input type="text" id="txtprecio" name="txtprecio" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="txtstock">Stock:</label>
                        <input type="text" id="txtstock" name="txtstock" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="txtstockminimo">Stock Mínimo:</label>
                        <input type="text" id="txtstockminimo" name="txtstockminimo" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="cboproveedor">Proveedor:</label>
                        <select id="cboproveedor" name="cboproveedor" class="form-control">
                            <% for (modeloproveedor proveedor : listaProveedores) { %>
                                <option value="<%= proveedor.getIdProveedor() %>"><%= proveedor.getNombreProveedor() %></option>
                            <% } %>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>IVA:</label>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="iva" id="ivaExenta" value="Exenta">
                            <label class="form-check-label" for="ivaExenta">
                                Exenta
                            </label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="iva" id="iva5" value="5">
                            <label class="form-check-label" for="iva5">
                                5%
                            </label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="iva" id="iva10" value="10" checked>
                            <label class="form-check-label" for="iva10">
                                10%
                            </label>
                        </div>
                    </div>
                    <input type="submit" class="btn btn-primary btn-block" name="accion" value="Agregar">
                    <a href="productos.jsp" class="btn btn-secondary btn-block">Volver</a>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>


