<%-- 
    Document   : facturacompra
    Created on : 1 jun 2024, 10:08:23
    Author     : juana
--%>


<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="modelo.compramodelo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Compras</title>
        <link rel="icon" href="img/logobodega.ico" type="image/x-icon">
    </head>
    <body>
        <%@include file="plantilla.jsp" %>
        
        <main>
             <div class="imagen-fondo">
                <img src="img/fondo-forms.png" alt="Fondo">           
            </div>
            <div class="container">
                <h2>Formulario Compras</h2>
                <form action="facturacompracontrolador" method="post">
                    <button type="submit" name="accion" value="add" class="btn btn-success">AGREGAR NUEVA COMPRA</button> 
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
                                <th>PROVEEDOR</th>
                                <th>APERTURA</th>
                                <th>USUARIO</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%  
                                compramodelo modelo = new compramodelo();
                                List<compramodelo> list = modelo.listarCompras();
                                Iterator<compramodelo> iter = list.iterator();
                                compramodelo m = null;
                                while (iter.hasNext()) {
                                    m = iter.next();
                            %>
                            <tr>
                                <td><%= m.getIdCompra() %></td>
                                <td><%= m.getFecha() %></td>
                                <td><%= m.getCondicion() %></td>
                                <td><%= m.getEstado() %></td>
                                <td><%= m.getProveedor() %></td>
                                <td><%= m.getIdApertura() %></td>                           
                                <td><%= m.getIdUsuarios() %></td>
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
