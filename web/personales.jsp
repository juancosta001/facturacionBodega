<%-- 
    Document   : personales
    Created on : 20 abr 2024, 12:40:32
    Author     : juana
--%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="modelo.modelopersonal"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Personales</title>
        <link rel="icon" href="img/logobodega.ico" type="image/x-icon">
    </head>
    <body>
        <div class="imagen-fondo">
            <img src="img/fondo-forms.png" alt="Fondo">           
        </div>

        <%@include file="plantilla.jsp" %>
        <main>
            <div class="container ">
                <form action="personalcontrolador" method="post"> 
                    <h2>Tabla de Personales </h2>
                    <div class="buttons">
                        <button type="submit" name="accion" value="home" class="btn btn-primary">INICIO</button>
                        <button type="submit" name="accion" value="nuevo" class="btn btn-success">NUEVO PERSONAL</button>
                        <button type="submit" name="accion" value="informe" class="btn btn-success">IMPRIMIR</button>
                    </div>
                </form>
                <br><br>
                <div class="table-responsive">
                    <table class="table table-striped text-center">
                        <thead>
                            <tr>
                                <th scope="col">CÓDIGO</th>
                                <th scope="col">NOMBRE</th>
                                <th scope="col">APELLIDO</th>
                                <th scope="col">CI</th>
                                <th scope="col">TELÉFONO</th>
                                <th scope="col">ACCIONES</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%                                modelopersonal modelo = new modelopersonal();
                                List<modelopersonal> list = modelo.listarpersonal();
                                for (modelopersonal m : list) {
                            %>
                            <tr>
                                <td><%= m.getCodigo()%></td>
                                <td><%= m.getNombre()%></td>
                                <td><%= m.getApellido()%></td>
                                <td><%= m.getCi()%></td>
                                <td><%= m.getTelefono()%></td>
                                <td>
                                    <form action="personalcontrolador" method="post"> 
                                        <input type="hidden" name="id" value="<%= m.getCodigo()%>"> 
                                        <a href="vistas/modificar_personal.jsp?id=<%= m.getCodigo()%>" class="btn btn-primary">EDITAR</a> 
                                        <button type="submit" name="delete" value="<%= m.getCodigo()%>" class="btn btn-danger">ELIMINAR</button>
                                    </form>
                                </td>
                            </tr>
                            <%
                                }
                            %>
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
