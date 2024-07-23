<%-- 
    Document   : productos
    Created on : 23 abr 2024, 22:23:25
    Author     : juana
--%>
<%@page import="modelo.modeloproducto"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Productos</title>
        <link rel="icon" href="img/logobodega.ico" type="image/x-icon">
    </head>
    <body>
         <div class="imagen-fondo">
                <img src="img/fondo-forms.png" alt="Fondo">           
            </div>
        <%@include file="plantilla.jsp" %>
        <main>
            <div class="container">
                <form action="productocontrolador" method="post">
                    <h2>Tabla de Productos</h2>
                    <div class="buttons">
                        <button type="submit" name="accion" value="home" class="btn btn-primary">INICIO</button>
                        <button type="submit" name="accion" value="nuevo" class="btn btn-success">NUEVO PRODUCTO</button>
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
                                <th scope="col">Costo</th>
                                <th scope="col">Precio</th>
                                <th scope="col">Stock</th>
                                <th scope="col">Stock Mínimo</th>
                                <th scope="col">Proveedor</th>
                                <th scope="col">IVA</th>
                                <th scope="col">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                modeloproducto modelo = new modeloproducto();
                                List<modeloproducto> listaProductos = modelo.listarProductos();
                                for (modeloproducto producto : listaProductos) {
                            %>
                            <tr>
                                <td><%= producto.getId() %></td>
                                <td><%= producto.getNombre() %></td>
                                <td><%= producto.getCosto() %></td>
                                <td><%= producto.getPrecio() %></td>
                                <td><%= producto.getStock() %></td>
                                <td><%= producto.getStockMinimo() %></td>
                                <td><%= producto.getNombreProveedor() %></td>
                                <td>
                                    <%= producto.getIva() %>
                                </td>
                                <td>
                                    <form action="productocontrolador" method="post">
                                        <input type="hidden" name="id" value="<%= producto.getId() %>">
                                        <a href="vistas/modificar_producto.jsp?id=<%= producto.getId() %>" class="btn btn-primary">EDITAR</a>
                                        <button type="submit" name="delete" value="<%= producto.getId() %>" class="btn btn-danger">ELIMINAR</button>
                                    </form>
                                </td>
                            </tr>
                            <%
                                }
                            %>
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

