<%-- 
    Document   : agregarclientes
    Created on : 23 abr 2024, 21:02:23
    Author     : juana
--%>
<%@page import="modelo.modeloproveedor"%>
<%@page import="java.util.List"%>
<%@page import="modelo.modelocliente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Agregar Clientes</title>
        <link rel="icon" href="img/logobodega.ico" type="image/x-icon">
    </head>
    <body>
       
<%
    
    // Obtener el último código de cliente
    modelocliente modeloCliente = new modelocliente();
    String ultimoCodigoCliente = modeloCliente.obtenerUltimoCodigo();
    int siguienteCodigoCliente = Integer.parseInt(ultimoCodigoCliente) + 1;

    // Obtener la lista de ciudades directamente del modelo de proveedores
    List<modelocliente> listarciudades = modeloCliente.listarciudades();
%>
<%@include file="../plantilla.jsp" %>
<div class="container" style="background-color: transparent !important;">
    <div class="row" >
        <div class="col-md-6 offset-md-3">
            <div class="form-container">
                <h1>AGREGAR CLIENTE</h1>
                <form action="./clientecontrolador" method="post">
                    <div class="form-group">
                        <label for="txtcodigo">Código:</label>
                        <input type="text" id="txtcodigo" name="txtcodigo" class="form-control" value="<%= siguienteCodigoCliente %>" readonly>
                    </div>
                    <div class="form-group">
                        <label for="txtnombre">Nombre:</label>
                        <input type="text" id="txtnombre" name="txtnombre" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="txtapellido">Apellido:</label>
                        <input type="text" id="txtapellido" name="txtapellido" class="form-control" required>
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
                        <label for="cbociudad">Ciudad:</label>
                        <select id="cbociudad" name="cbociudad" class="form-control">
                            <% for (modelocliente ciudad : listarciudades) { %>
                                <option value="<%= ciudad.getCodigo() %>"><%= ciudad.getCiudad() %></option>
                            <% } %>
                        </select>
                    </div>
                    <input type="submit" class="btn btn-primary btn-block" name="accion" value="Agregar">
                    <a href="clientes.jsp" class="btn btn-secondary btn-block">Volver</a>
                </form>
            </div>
        </div>
    </div>
</div>
</html>
