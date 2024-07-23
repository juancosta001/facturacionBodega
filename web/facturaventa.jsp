<%-- 
    Document   : facturaventa
    Created on : 25 may 2024, 23:13:42
    Author     : juana
--%>

<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="modelo.facturaventamodelo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Facturación</title>
        <link rel="icon" href="img/logobodega.ico" type="image/x-icon">
    </head>
    <body>
        <%@include file="plantilla.jsp" %>
        
        <main>
             <div class="imagen-fondo">
                <img src="img/fondo-forms.png" alt="Fondo">           
            </div>
            <div class="container">
                <h2>Formulario Facturación</h2>
                <form action="facturaventacontrolador" method="post">
                    <button type="submit" name="accion" value="add" class="btn btn-success">AGREGAR NUEVA FACTURA</button> 
                </form>
                <br><br>
                <div class="table-responsive">
                    <table class="table table-striped text-center">
                        <thead>
                            <tr>
                                <th>N°</th>
                                <th>FECHA</th>
                                <th>CONDICIÓN</th>
                                <th>ESTADO</th>
                                <th>APERTURA</th>
                                <th>CLIENTES</th>
                                <th>ACCION</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%  
                                facturaventamodelo modelo = new facturaventamodelo();
                                List<facturaventamodelo> list = modelo.listarfacturas();
                                Iterator<facturaventamodelo> iter = list.iterator();
                                facturaventamodelo m = null;
                                while (iter.hasNext()) {
                                    m = iter.next();
                            %>
                            <tr>
                                <td><%= m.getIdfacturacion()%></td>
                                <td><%= m.getFecha()%></td>
                                <td><%= m.getCondicion()%></td>
                                <td><%= m.getEstado()%></td>
                                <td><%= m.getIdapertura()%></td>                           
                                <td><%= m.getCliente()%></td>
                                <td>
                                    <form action="facturaventacontrolador" method="post" target="_blank">
                                        <input type="hidden" name="accion" value="imprimir">
                                        <button type="submit" name="factura" value="<%= m.getIdfacturacion()%>" class="btn btn-primary">IMPRIMIR</button>
                                    </form>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
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
    </body>
</html>
