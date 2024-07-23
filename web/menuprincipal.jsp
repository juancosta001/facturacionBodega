<%-- 
    Document   : menuprincipal
    Created on : 17 abr. 2024, 10:23:44
    Author     : ALUMNOS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Menu Principal</title>
        <link rel="icon" href="img/logobodega.ico" type="image/x-icon">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <style> .imagen-fondo-menu img {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                z-index: 0;
                background-image: url('img/fondo.png');
                background-size: cover; /* Ajusta la imagen para cubrir todo el fondo */
                background-position: center; /* Centra la imagen */
            }
            /* Estilos para los encabezados h1 dentro del modal */
            .modal-caja-content h1 {
                margin-top: 10px;
                margin-left:24%; 
                font-family: 'Times New Roman', Times, serif;
                font-size: 32px; 
                font-weight: bold;
                margin-bottom: 10px; 
            }
             .modal-caja-content h2 {
                margin-top: 10px;
                margin-left:23%; 
                font-family: 'Times New Roman', Times, serif;
                font-size: 28px; 
                font-weight: bold;
                margin-bottom: 10px; 
            }
            .modal-caja-content button{
                margin-left: 35%;
            }
        </style>
        <link href="https://fonts.googleapis.com/css2?family=Roboto+Slab:wght@100&family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap" rel="stylesheet">
    </head>

    <body>
        <div class="imagen-fondo-menu">
            <img src="img/fondo.png" alt="Fondo">
        </div>
        <%@include file="plantilla.jsp" %>
        <div class="container-inicio">
            <main style="padding-top: 150px">
                <div id="modal" class="modal">
                    <div class="modal-caja-content"> 
                        <span class="close" onclick="cerrarModal()">&times;</span>
                        <% String validarcaja = (String) request.getAttribute("validarcaja");
                            if (validarcaja != null && validarcaja.equals("noabrir")) { %>
                        <h1>Caja Abierta</h1>
                        <h2>Debe CERRAR</h1>
                        <button onclick="cerrarModal()" class="btn btn-primary">ACEPTAR</button>
                        <% } else if (validarcaja != null && validarcaja.equals("abierta")) { %>
                        <h1>Caja Abierta Correctamente</h1>
                        <button onclick="cerrarModal()" class="btn btn-primary">ACEPTAR</button>
                        <% } else if (validarcaja != null && validarcaja.equals("cerrada")) { %>
                        <h1>Caja Cerrada</h1> 
<!--                        arreglar mensaje-->
                        <button onclick="cerrarModal()" class="btn btn-primary">ACEPTAR</button>
                        <% } %>
                    </div>
                </div>
                <h1 id="titulo1">Bienvenido al panel </h1>
                <h1 id="titulo">de administrador</h1>
            </main>
        </div>
    </body>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
        <% String validar3 = (String) request.getAttribute("validarcaja");
                if (validar3 != null) { %>
            mostrarModal();
        <% } %>
        });

        function mostrarModal() {
            document.getElementById('modal').style.display = 'block';
        }

        function cerrarModal() {
            document.getElementById('modal').style.display = 'none';
        }
    </script>
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
