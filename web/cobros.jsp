<%-- 
    Document   : cobros
    Created on : 2 jul 2024, 20:28:34
    Author     : juana
--%>

<%@ page import="modelo.cobromodelo" %>
<%@ page import="java.util.List" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cobros</title>
        <link rel="icon" href="img/logobodega.ico" type="image/x-icon">
        <link rel="stylesheet" href="css/style.css">
    </head>
    <body>
        <div class="imagen-fondo">
            <img src="img/fondo-forms.png" alt="Fondo">
        </div>

        <%@ include file="plantilla.jsp" %>
        <main>
            <div class="content">
                <div class="container">
                    <div class="formcobros">
                        <form action="cobrocontrolador2" method="post">
                            <h2>Tabla de Cobros</h2>
                            <div class="buttons">
                                <button type="submit" name="accion" value="home" class="btn btn-primary">INICIO</button>
                                <button type="submit" name="accion" value="add" class="btn btn-success">NUEVO COBRO</button>
                                <button type="submit" name="accion" value="informe" class="btn btn-success">IMPRIMIR</button>
                            </div>
                        </form>
                        <br><br>
                        <div class="table-responsive">
                            <table class="table table-striped text-center">
                                <thead>
                                    <tr>
                                        <th scope="col">ID</th>
                                        <th scope="col">Fecha</th>
                                        <th scope="col">Estado</th>
                                        <th scope="col">Cliente ID</th>
                                        <th scope="col">Apertura ID</th>
                                        <th scope="col">Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%                                        cobromodelo modelo = new cobromodelo();
                                        List<cobromodelo> listaCobros = modelo.listarCobros();
                                        for (cobromodelo cobro : listaCobros) {
                                    %>
                                    <tr>
                                        <td><%= cobro.getCodigo()%></td>
                                        <td><%= cobro.getFecha()%></td>
                                        <td><%= cobro.getEstado()%></td>
                                        <td><%= cobro.getIdclientes()%></td>
                                        <td><%= cobro.getIdapertura()%></td>
                                        <td>
                                            <form action="cobrocontrolador2" method="post">
                                                <input type="hidden" name="id" value="<%= cobro.getCodigo()%>">
                                                <button type="submit" name="accion" value="anular" class="btn btn-primary" data-toggle="modal" data-target="#confirmacionModal">
                                                    ANULAR
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                    <% } %>
                                    <% String mensaje = (String) request.getAttribute("mensaje"); %>
                                    <% if (mensaje != null && !mensaje.isEmpty()) {%>
                                <div class="alert alert-danger" role="alert">
                                    <%= mensaje%>
                                </div>
                                <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal fade" id="confirmacionModal" tabindex="-1" role="dialog" aria-labelledby="confirmacionModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="confirmacionModalLabel">Confirmación de Anulación</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            ¿Está seguro que desea anular este cobro?
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                            <button type="submit" class="btn btn-primary">Sí, Anular</button>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <footer id="footer">
            <div class="container__footer">
                <div class="box__footer">
                    <a href="index.html" class="logo">
                        <img src="img/logo-bodega.png" alt="">
                    </a>
                    <div class="terms">
                        <p><b>
                                <%
                                    String idusuariov = (String) sesion.getAttribute("idusuario");
                                    String usunombrev = (String) sesion.getAttribute("usunombre");
                                %>
                                <label id="txtid"><%= idusuariov%></label>
                                <label id="txtnombre"><%= usunombrev%></label>
                            </b></p>
                    </div>
                </div>
                <div class="box__footer">
                    <h2>Temas de Interés</h2>
                    <a href="menuprincipal.jsp"><u>Inicio</u></a>
                    <a href="clientes.jsp"><u>Clientes</u></a>
                    <a href="personales.jsp"><u>Personales</u></a>
                    <a href="productos.jsp"><u>Productos</u></a>
                </div>
                <div class="box__footer">
                    <h2>Temas de Interés</h2>
                    <a href="usuarios.jsp"><u>Usuarios</u></a>
                    <a href="productos.jsp"><u>Productos</u></a>
                    <a href="proveedores.jsp"><u>Proveedores</u></a>
                </div>
                <div class="box__footer">
                    <h2>Contactenos</h2>
                    <a href="#">juanacostapereira9@gmail.com</a>
                    <a href="#"> +595 972-905-982</a>
                </div>
            </div>
        </footer>
    </body>
</html>