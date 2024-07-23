<%-- 
    Document   : clientes
    Created on : 23 abr 2024, 21:02:13
    Author     : juana
--%>

<%@ page import="modelo.modelocliente" %>
<%@ page import="java.util.List" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Clientes</title>
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
                    <div class="formclientes">
                        <form action="clientecontrolador" method="post">
                            <h2>Tabla de Clientes</h2>
                            <div class="buttons">
                                <button type="submit" name="accion" value="home" class="btn btn-primary">INICIO</button>
                                <button type="submit" name="accion" value="nuevo" class="btn btn-success">NUEVO CLIENTE</button>
                                <button type="submit" name="accion" value="informe" class="btn btn-success">IMPRIMIR</button>
                            </div>
                        </form>
                        <br><br>
                        <div class="table-responsive">
                            <table class="table table-striped text-center">
                                <thead>
                                    <tr>
                                        <th scope="col">ID</th>
                                        <th scope="col">Nombre</th>
                                        <th scope="col">Apellido</th>
                                        <th scope="col">RUC</th>
                                        <th scope="col">Teléfono</th>
                                        <th scope="col">Ciudad</th>
                                        <th scope="col">Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% 
                                        modelocliente modelo = new modelocliente();
                                        List<modelocliente> listaClientes = modelo.listarClientes();
                                        for (modelocliente cliente : listaClientes) {
                                    %>
                                    <tr>
                                        <td><%= cliente.getCodigo() %></td>
                                        <td><%= cliente.getNombre() %></td>
                                        <td><%= cliente.getApellido() %></td>
                                        <td><%= cliente.getRuc() %></td>
                                        <td><%= cliente.getTelefono() %></td>
                                        <td><%= cliente.getNombreCiudad() %></td>
                                        <td>
                                            <form action="clientecontrolador" method="post">
                                                <input type="hidden" name="id" value="<%= cliente.getCodigo() %>">
                                                <a href="vistas/modificar_clientes.jsp?id=<%= cliente.getCodigo() %>" class="btn btn-primary">EDITAR</a>
                                                <button type="submit" name="delete" value="<%= cliente.getCodigo() %>" class="btn btn-danger">ELIMINAR</button>
                                            </form>
                                        </td>
                                    </tr>
                                    <% } %>
                                    <% String mensaje = (String) request.getAttribute("mensaje"); %>
                                    <% if (mensaje != null && !mensaje.isEmpty()) { %>
                                    <div class="alert alert-danger" role="alert">
                                        <%= mensaje %>
                                    </div>
                                    <% } %>
                                </tbody>
                            </table>
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
                            <label id="txtid"><%= idusuariov %></label>
                            <label id="txtnombre"><%= usunombrev %></label>
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
