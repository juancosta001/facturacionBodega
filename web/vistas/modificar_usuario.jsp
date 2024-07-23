<%-- 
    Document   : modificar_usuario
    Created on : 23 abr 2024, 2:15:28
    Author     : juana
--%>

<%@page import="modelo.modelousuario"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="modelo.modelopersonal"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Modificar Usuario</title>
        <link rel="stylesheet" href="../css/style.css"/>
        <link rel="stylesheet" href="../css/bootstrap.min.css"/>
    
</head>
<body>
   <%
            HttpSession sesion = request.getSession();
            if (sesion.getAttribute("sesion") == null) {
                out.print("<script>location.replace('../index.jsp')</script>");
            }
        %>
    <% modelousuario modelo = new modelousuario();
        String id = request.getParameter("id");
        modelo.setCodigo(id);
        List<modelousuario> list = modelo.listarUsuarios();
        modelousuario usuario = null;
        for (modelousuario u : list) {
            if (u.getCodigo().equals(id)) {
                usuario = u;
                break;
            }
        }
    %>
    <main>
        <div class="container">
            <div class="row">
                <div class="col-md-6 offset-md-3">
                    <form action="../usuariocontrolador" method="post">
                        <div class="form-container">
                            <h2>Modificar Usuario</h2>
                            <input type="hidden" name="txtcodigo" value="<%= usuario != null ? usuario.getCodigo() : ""%>">
                            <div class="form-group">
                                <label for="txtnombre">Nombre:</label>
                                <input type="text" id="txtnombre" name="txtnombre" class="form-control" value="<%= usuario != null ? usuario.getNombre() : ""%>" required>
                            </div>
                            <div class="form-group">
                                <label for="txtclave">Clave:</label>
                                <input type="password" id="txtclave" name="txtclave" class="form-control" value="<%= usuario != null ? usuario.getClave() : ""%>" required>
                            </div>
                            <div class="form-group">
                                <label for="txttipo">Tipo:</label>
                                <select id="txttipo" name="txttipo" class="form-control" required>
                                    <option value="admin" <%= usuario != null && usuario.getTipo().equals("admin") ? "selected" : ""%>>Admin</option>
                                    <option value="usuario" <%= usuario != null && usuario.getTipo().equals("usuario") ? "selected" : ""%>>Usuario</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="txtestado">Estado:</label>
                                <select id="txtestado" name="txtestado" class="form-control" required>
                                    <option value="ACTIVO" <%= usuario != null && usuario.getEstado().equals("ACTIVO") ? "selected" : ""%>>ACTIVO</option>
                                    <option value="INACTIVO" <%= usuario != null && usuario.getEstado().equals("INACTIVO") ? "selected" : ""%>>INACTIVO</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="cbopersonal">Personal:</label>
                                <select id="cbopersonal" name="cbopersonal" class="form-control" required>
                                    <% modelopersonal modeloPersonal = new modelopersonal();
                                        List<modelopersonal> listaPersonal = modeloPersonal.listarpersonal();
                                        for (modelopersonal personal : listaPersonal) {%>
                                    <option value="<%= personal.getCodigo()%>" <%= usuario != null && personal.getCodigo().equals(usuario.getPersonal()) ? "selected" : ""%>><%= personal.getNombre()%></option>
                                    <% }%>
                                </select>
                            </div>
                            <input type="submit" class="btn btn-primary btn-block" name="accion" value="Modificar">
                            <a href="../usuarios.jsp" class="btn btn-secondary btn-block">Volver</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </main>
</body>
</html>
