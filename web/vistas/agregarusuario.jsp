<%-- 
    Document   : agregarusuario
    Created on : 23 abr 2024, 2:15:20
    Author     : juana
--%>

<%@page import="java.util.List"%>
<%@page import="modelo.modelopersonal"%>
<%@page import="modelo.modelousuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Agregar usuario</title>
    </head>
    <body>
        <main>
        <%
            // Obtener el último código
            modelousuario modeloUsuario = new modelousuario();
            String ultimoCodigoUsuario = modeloUsuario.obtenerUltimoCodigo();
            int siguienteCodigoUsuario = Integer.parseInt(ultimoCodigoUsuario) + 1;

            modelopersonal modeloPersonal = new modelopersonal();
            List<modelopersonal> listaPersonales = modeloPersonal.listarpersonal();
        %>
        <%@include file="../plantilla.jsp" %>
       <div class="container" style="background-color: transparent !important;">
            <div class="row">
                <div class="col-md-6 offset-md-3">
                    <div class="form-container">
                        <h1>AGREGAR USUARIO</h1>
                        <form action="./usuariocontrolador" method="post">
                            <div class="form-group">
                                <label for="txtcodigo">Código:</label>
                                <input type="text" id="txtcodigo" name="txtcodigo" class="form-control" value="<%= siguienteCodigoUsuario%>" disabled>
                            </div>
                            <div class="form-group">
                                <label for="txtnombre">Nombre:</label>
                                <input type="text" id="txtnombre" name="txtnombre" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="txtclave">Clave:</label>
                                <input type="password" id="txtclave" name="txtclave" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="txttipo">Tipo:</label>
                                <select id="txttipo" name="txttipo" class="form-control" required>
                                    <option value="administrador">Administrador</option>
                                    <option value="Invitado">Invitado</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="txtestado">Estado:</label>
                                <select id="txtestado" name="txtestado" class="form-control" required>
                                    <option value="ACTIVO">ACTIVO</option>
                                    <option value="INACTIVO">INACTIVO</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="cbopersonal">Personal:</label>
                                <select id="cbopersonal" name="cbopersonal" class="form-control" required>
                                    <% for (modelopersonal personal : listaPersonales) {%>
                                    <option value="<%= personal.getCodigo()%>"><%= personal.getNombre()%></option>
                                    <% }%>
                                </select>
                            </div>
                            <input type="submit" class="btn btn-primary btn-block" name="accion" value="Agregar">
                            <a href="usuarios.jsp" class="btn btn-secondary btn-block">Volver</a>
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
