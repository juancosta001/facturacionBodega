<%-- 
    Document   : cerrar
    Created on : 8 may. 2024, 09:01:25
    Author     : ALUMNOS
--%>

<%@page import="modelo.modeloabrircaja"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@include file="plantilla.jsp" %> 
        <% modeloabrircaja m = new modeloabrircaja();
            Object p = sesion.getAttribute("idusuario");
            m.setIdusuario(p.toString());
            if (m.validarCaja().equals("CERRADA")) {
                request.setAttribute("validarcaja", "cerrada");
                out.print("<script>location.replace('menuprincipal.jsp')</script>");
            }
        %>
        <main style="padding-top: 10px">
             <div style="background-color: white;width: 400px;height: 200px; margin-left: 40%;padding-left:10px;border-radius:15px;">
            <form class="menu3" action="abrircajacontrolador" method="post">
                <br><h1 style="margin-left: 15%">Cierre de Caja</h1>
                <input type="hidden" name="lblcodigo" value="<%= sesion.getAttribute("idusuario")%>"> 
                <label style="margin-top: 10px">Ingrese un monto</label>
                <input type="number" name="txtmontocierre">
                <br><button type="submit" onclick="mostrarModal()" class="btn btn-primary" style="margin-left: 35%;margin-top: 15px">Cerrar Caja</button> 
                <div id="miModal" class="modal-caja"><!-- comment -->
                    <div class="modal-caja-content"><!-- comment -->
                        <span class="close" onclick="cerrarModal()">&times;</span>
                        <h1>¿DESEA CERRAR CAJA?</h1><!-- comment -->
                        <button type="submit" name="accion" value="cerrar" class="btn btn-secondary">SI</button>
                        <button type="button" onclick="cerrarModal()" class="btn btn-secondary">NO</button>
                    </div>
                </div>
            </form>
             </div>
        </main>
                <script src="js/caja.js"></script>
    </body>
    <footer id="footer" style="margin-top: 30px">
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



    <script>
        window.onload = function () {
            // Obtener la altura del footer
            var footerHeight = document.getElementById('footer').offsetHeight;

            // Establecer el padding-bottom del main
            document.getElementsByTagName('main')[0].style.paddingBottom = footerHeight + 'px';
        };
    </script>
</html>
