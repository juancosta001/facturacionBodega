<%-- 
    Document   : plantilla
    Created on : 19 abr. 2024, 23:26:57
    Author     : juana
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="css/style.css"/>
        <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <img class="logo" src="img/logobodega.png" alt="logo"/>
</head>
<body>
    <div class="imagen-fondo">
        <img src="img/fondo-forms.png" alt="Fondo">           
    </div>
    <%
        HttpSession sesion = request.getSession();
        if (sesion.getAttribute("sesion") == null) {
            out.print("<script>location.replace('index.jsp')</script>");
        }
    %>


    <header>
        <div class="logo-nav">
            <a href="menuprincipal.jsp"><img class="logo" src="img/logo-bodega.png" /></a>
        </div>
        <nav >
            <ul>
                <li class="has-submenu"><a href="#">Mantenimiento</a>
                    <ul class="submenu">
                        <li><a href="clientes.jsp">Clientes</a></li>
                        <li><a href="personales.jsp">Personales</a></li>
                        <li><a href="usuarios.jsp">Usuarios</a></li>
                        <li><a href="productos.jsp">Productos</a></li>
                        <li><a href="proveedores.jsp">Proveedores</a></li>
                    </ul>
                </li>

                <li class="has-submenu"><a href="#">Compras</a>
                    <ul class="submenu">
                        <li><a href="facturacompra.jsp">Registros de Compras</a></li>
                    </ul>
                </li>
                <li class="has-submenu"><a href="#">Ventas</a>
                    <ul class="submenu">
                        <li><a href="facturaventa.jsp">Generacion de Ventas</a></li>
                    </ul>
                </li>
                <li class="has-submenu"><a href="#">Tesoreria</a>
                    <ul class="submenu">
                        <li><a href="apertura.jsp">Abrir Caja</a></li>
                        <li><a href="cobros.jsp">Cobrar</a></li>
                        <li><a href="pagos.jsp">Pagar</a></li>
                        <li><a href="cerrar.jsp">Cerrar caja</a></li>
                    </ul>
                </li>
                <li class="has-submenu"><a href="#">Inventario</a>
                    <ul class="submenu">
                        <li><a href="inventarios.jsp">Ajuste de inventario</a></li>
                    </ul>
                </li>
                <li class="has-submenu"><a href="#"><%= sesion.getAttribute("usunombre")%></a>
                    <ul class="submenu">
                        <li><a href="cerrarsesion">Cerrar Sesión</a></li>
                    </ul>
                </li>


            </ul>
        </nav>
    </header>

    <main>

    </main>

    <script src="js/script.js"></script> 
</body>
</html>
