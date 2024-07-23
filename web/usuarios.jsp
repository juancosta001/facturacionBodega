<%-- 
    Document   : usuarios
    Created on : 23 abr 2024, 2:15:42
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
        <title>Usuarios</title>
        <link rel="icon" href="img/logobodega.ico" type="image/x-icon">

    </head>
    <body>
        <div class="imagen-fondo">
            <img src="img/fondo-forms.png" alt="Fondo">           
        </div>
        <%@include file="plantilla.jsp" %>
        <main>
            <div class="container">
                <form action="usuariocontrolador" method="post"> 
                    <h2>Tabla de Usuarios</h2>
                    <div class="buttons">
                        <button type="submit" name="accion" value="home" class="btn btn-primary">INICIO</button>
                        <button type="submit" name="accion" value="nuevo" class="btn btn-success">NUEVO USUARIO</button>
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
                               
                                <th scope="col">Tipo</th>
                                <th scope="col">Estado</th>
                                <th scope="col">Personal</th>
                                <th scope="col">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%                                modelousuario modelo = new modelousuario();
                                List<modelousuario> listaUsuarios = modelo.listarUsuarios();
                                for (modelousuario usuario : listaUsuarios) {
                            %>
                            <tr>
                                <td><%= usuario.getCodigo()%></td>
                                <td><%= usuario.getNombre()%></td>
                                
                                <td><%= usuario.getTipo()%></td>
                                <td><%= usuario.getEstado()%></td>
                                <td><%= usuario.getNombrePersonal()%></td>
                                <td>
                                    <form action="usuariocontrolador" method="post"> 
                                        <input type="hidden" name="id" value="<%= usuario.getCodigo()%>"> 
                                        <a href="vistas/modificar_usuario.jsp?id=<%= usuario.getCodigo()%>" class="btn btn-primary">EDITAR</a> 
                                        <button type="submit" name="delete" value="<%= usuario.getCodigo()%>" class="btn btn-danger">ELIMINAR</button>
                                    </form>
                                </td>
                            </tr>
                            <%
                                }
                            %>
                            <% String mensaje = (String) request.getAttribute("mensaje"); %>
                            <% if (mensaje != null && !mensaje.isEmpty()) {%>
                        <div class="alert alert-danger" role="alert">
                            <%= mensaje%>
                        </div>
                        <% }%>

                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </body>
    <footer id="footer">
        <div class="container__footer">
            <div class="box__footer">
                <a href="index.html" class="logo" >
                    <img src="img/logo-bodega.png" alt="">
                </a>
                <div class="terms">
                    <p><b>
                            <%
                                String idusuariov = (String) sesion.getAttribute("idusuario");
                                String usunombrev = (String) sesion.getAttribute("usunombre");
                            %>

                            <label id="txtid"><%=idusuariov%></label>
                            <label id="txtnombre"><%=usunombrev%></label>
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


</html>
