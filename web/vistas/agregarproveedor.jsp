<%-- 
    Document   : agregarproveedor
    Created on : 23 abr 2024, 16:48:09
    Author     : juana
--%>

<%@page import="java.util.List"%>
<%@page import="modelo.modeloproveedor"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Agregar Proveedor</title>
    </head>
    <body>
         
<%
    // Obtener el último código de proveedor
    modeloproveedor modeloProveedor = new modeloproveedor();
    String ultimoCodigoProveedor = modeloProveedor.obtenerUltimoCodigo();
    int siguienteCodigoProveedor = Integer.parseInt(ultimoCodigoProveedor) + 1;

    // Obtener la lista de ciudades directamente del modelo de proveedores
    List<modeloproveedor> listarciudades = modeloProveedor.listarciudades();
%>
<%@include file="../plantilla.jsp" %>
<div class="container" style="background-color: transparent !important;">
    <div class="row">
        <div class="col-md-6 offset-md-3">
            <div class="form-container">
                <h1>AGREGAR PROVEEDOR</h1>
                <form action="./proveedorcontrolador" method="post">
                    <div class="form-group">
                        <label for="txtcodigo">Código:</label>
                        <input type="text" id="txtcodigo" name="txtcodigo" class="form-control" value="<%= siguienteCodigoProveedor %>" readonly>
                    </div>
                    <div class="form-group">
                        <label for="txtnombre">Nombre:</label>
                        <input type="text" id="txtnombre" name="txtnombre" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="txtruc">RUC:</label>
                        <input type="text" id="txtruc" name="txtruc" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="txttelefono">Teléfono:</label>
                        <input type="text" id="txttelefono" name="txttelefono" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="txtcorreo">Correo:</label>
                        <input type="text" id="txtcorreo" name="txtcorreo" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="cbociudad">Ciudad:</label>
                        <select id="cbociudad" name="cbociudad" class="form-control" required>
                            <% for (modeloproveedor modelo : listarciudades) { %>
                                 <option value="<%= modelo.getCodigo() %>"><%= modelo.getNombreCiudad() %></option>
                            <% } %>
                        </select>
                    </div>
                    <input type="submit" class="btn btn-primary btn-block" name="accion" value="Agregar">
                    <a href="proveedores.jsp" class="btn btn-secondary btn-block">Volver</a>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
