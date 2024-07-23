<%-- 
    Document   : menuinvitado
    Created on : 24 abr 2024, 2:38:35
    Author     : juana
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>MENU INVITADO</title>
        <link rel="stylesheet" href="css/bootstrap.min.css"/>
        <link rel="icon" href="img/logobodega.ico" type="image/x-icon">
        <style>
            body, html {
                height: 100%;
                margin: 0;
                font-family: Arial, Helvetica, sans-serif;
                overflow: hidden; /* Evita el desplazamiento */
            }
            .background {
                background-image: url('img/fondo.png');
                height: 100%;
                background-position: center;
                background-repeat: no-repeat;
                background-size: cover;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                z-index: -1;
            }
            header {
                position: relative;
                z-index: 1;
                padding: 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                background-color: rgb(86, 28, 36);
                width: 100%;
            }
            nav ul {
                list-style-type: none;
                margin: 0;
                padding: 0;
                display: flex;
            }
            nav ul li {
                margin-right: 15px;
                color: white;
            }
            nav ul li a {
                text-decoration: none;
                color: white;
                font-size: 18px;
            }
            .content {
                display: flex;
                height: calc(100% - 80px); /* Descontar el tamaño del header */
                align-items: center;
                justify-content: space-around;
                padding: 20px;
            }
            .bienvenida-mensaje {
                flex: 1;
                text-align: left;
                color: white;
            }
            .bienvenida-mensaje h1 {
                font-size: 48px;
                margin: 0;
            }
            .section-container {
                flex: 1;
                display: flex;
                flex-direction: column;
                gap: 20px;
            }
            .section {
                background-color: rgba(255, 255, 255, 0.9);
                padding: 20px;
                border-radius: 8px;
            }
            .section h2 {
                font-size: 36px;
                color: rgb(86, 28, 36);
                margin-bottom: 20px;
            }
            .section p {
                font-size: 18px;
                color: #333;
                line-height: 1.6;
            }
        </style>
    </head>
    <body>
        <%
            HttpSession sesion = request.getSession();
            if (sesion.getAttribute("sesion") == null) {
                out.print("<script>location.replace('index.jsp')</script>");
            }
        %>
        <div class="background"></div>
        <header>
            <div class="logo-nav">
                <a href="#"><img class="logo" src="img/logobodega.png" alt="logo"/></a>
            </div>
            <nav>
                <ul>
                    <li><a href="index.jsp" class="nav-link">Iniciar Sesión</a></li>
                </ul>
            </nav>
        </header>

        <main class="content">
            <div class="bienvenida-mensaje">
                <h1>Bienvenidos al Menú de Invitados de la Bodega Acosta</h1>
            </div>
            
            <div class="section-container">
                <div class="section" id="nosotros">
                    <h2>Nosotros</h2>
                    <p>La Bodega Acosta es una importadora y exportadora de vinos ubicada en Ypacaraí, Paraguay. Nos dedicamos a ofrecer una selección exclusiva de vinos de las mejores bodegas del mundo, garantizando calidad y satisfacción a nuestros clientes. Con años de experiencia en la industria vinícola, nuestra misión es traer los sabores más exquisitos y las mejores cosechas a tu mesa.</p>
                </div>
                
                <div class="section" id="servicios">
                    <h2>Servicios</h2>
                    <p>En la Bodega Acosta, ofrecemos una amplia variedad de servicios relacionados con la venta de vinos. Desde asesoramiento personalizado para la elección del vino perfecto, hasta la organización de catas y eventos privados. Nuestro equipo de expertos está siempre dispuesto a ayudarte a descubrir nuevos sabores y a disfrutar de la experiencia vinícola en su máxima expresión.</p>
                </div>
            </div>
        </main>

        <script src="js/script.js"></script>
    </body>
</html>
