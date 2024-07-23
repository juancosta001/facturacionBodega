<%-- 
    Document   : nuevo_personal
    Created on : 20 abr 2024, 12:44:41
    Author     : juana
--%>

<%@page import="modelo.modelopersonal"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Agregar Personal</title>
    </head>
    <body>
        <main>
        <%
            // Obtener el último código
            modelopersonal modelo = new modelopersonal();
            String ultimoCodigo = modelo.obtenerUltimoCodigo();
            int siguienteCodigo = Integer.parseInt(ultimoCodigo) + 1;
        %>
        <%@include file="../plantilla.jsp" %>
        <div class="container" style="background-color: transparent !important;">
            <div class="row">
                <div class="col-md-6 offset-md-3">
                    <div class="form-container">
                        <h1>AGREGAR PERSONAL</h1>
                        <form action="./personalcontrolador" method="post">
                            <div class="form-group">
                                <label for="txtcodigo">Código:</label>
                                <input type="text" id="txtcodigo" name="txtcodigo" class="form-control" value="<%= siguienteCodigo %>" readonly>
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
                                <label for="txtci">C.I:</label>
                                <input type="text" id="txtci" name="txtci" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="txttelefono">Teléfono:</label>
                                <input type="text" id="txttelefono" name="txttelefono" class="form-control" required>
                            </div>
                            <input type="submit" class="btn btn-primary btn-block" name="accion" value="Agregar">
                            <a href="personales.jsp" class="btn btn-secondary btn-block">Volver</a>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <footer>
        <!-- Contenido del pie de página -->
    </footer>

                    </html>
