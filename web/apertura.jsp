<%-- 
    Document   : apertura
    Created on : 8 may. 2024, 08:31:28
    Author     : ALUMNOS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Abrir Caja</title>
        <style> 
         .modal-caja-content h1 {
                margin-top: 10px;
                margin-left:15%; 
              
                font-size: 24px; 
                font-weight: bold;
                margin-bottom: 10px; 
            }
             .modal-caja-content button {
                 width: 50px;
                margin-left:24%; 
                
            }
        </style>
    </head>
    <body>
        <%@include file="plantilla.jsp" %>
       <main style="padding-top: 10px">
            <div style="background-color: white;width: 400px;height: 200px; margin-left: 40%;padding-left:10px;border-radius:15px;">
            <form class="menu3" action="abrircajacontrolador" method="post">
                <br> <h1 style="margin-left: 9%">Apertura de Caja</h1>
               
                <input type="hidden" name="lblcodigo" value="<%= sesion.getAttribute("idusuario")%>"> 
                <label style="margin-top: 10px">Ingrese un monto</label> 
                <input type="number" name="txtmonto" min="0">
               <button type="submit" onclick="mostrarModal()" class="btn btn-primary" style="margin-left: 35%;margin-top: 15px">Abrir Caja</button> 
                <div id="miModal" class="modal"><!-- comment -->
                    <div class="modal-caja-content"><!-- comment -->
                        <span class="close" onclick="cerrarModal()">&times;</span>
                        <h1>¿DESEA ABRIR CAJA?</h1><!-- comment -->
                        <button type="submit" name="accion" value="abrir" class="btn btn-primary">SI</button>
                      
                        <button type="button" onclick="cerrarModal()" class="btn btn-secondary">NO</button>
                    </div>
                </div>
            </form>
            </div>
        </main>
        
                <script src="js/caja.js"></script>
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



                        <script> 
window.onload = function() {
    // Obtener la altura del footer
    var footerHeight = document.getElementById('footer').offsetHeight;

    // Establecer el padding-bottom del main
    document.getElementsByTagName('main')[0].style.paddingBottom = footerHeight + 'px';
};
</script>

    </footer>
    </body>
</html>
