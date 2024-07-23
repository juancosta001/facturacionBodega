<%-- 
    Document   : index
    Created on : 17 abr. 2024, 10:22:07
    Author     : ALUMNOS
--%>

<%@page import="modelo.loginmodelo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>CONTROL DE ACCESO</title>
    <link rel="stylesheet" href="css/style.css"/>
    <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <link rel="icon" href="img/logobodega.ico" type="image/x-icon">
    <style>
        body {
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
        }

        .custom-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            position: relative;
        }

        .background-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            background: url("img/fondologin.png") center center no-repeat;
            background-size: cover;
            filter: blur(10px);
            -webkit-filter: blur(10px);
            opacity: 0.8;
        }

        .card {
            position: relative; 
            width: 400px;
            height: 478px;
            padding: 65px;
            border-radius: 10px;
            box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.1);
            background: #fff;
        }

        .card-title {
            text-align: center;
            padding-top: 110px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-control-lg {
            font-size: 1.2rem;
            height: 50px;
        }

        .btn-lg {
            font-size: 1.2rem;
            padding: 10px 20px;
            margin-left: 30%;
        }

        .error-message {
            color: #ff0000;
            text-align: center;
            margin-top: 10px;
        }

        .logo {
            position: absolute; 
            top: -7px;
            left: 50%;
            transform: translateX(-50%);
            width: 250px;
            height: 200px;
            z-index: 1;
        }
    </style>
</head>
<body>
    <div class="custom-container">
        <div class="background-overlay"></div>
        <div class="card">
            <img class="logo" src="img/logo-bodega.png" alt="logo"/>
            <h1 class="card-title">Bodega Acosta</h1>
              <% loginmodelo m = (loginmodelo) request.getAttribute("error");
                   if (m != null && m.getMensajeError() != null) {%>
                <p class="error-message"><%= m.getMensajeError()%></p>
                <% }%>

            <form action="logincontrolador" method="post">
                <div class="form-group">
                    <input type="text" class="form-control form-control-lg" id="txtusuario" name="txtusuario" placeholder="USUARIO">
                </div>
                <div class="form-group">
                    <input type="password" class="form-control form-control-lg" id="txtclave" name="txtclave" placeholder="CONTRASEÑA">
                </div>
                <button type="submit" class="btn btn-primary btn-lg btn-block" name="accion" value="Ingresar">Ingresar</button>

              
            </form>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="js/script.js"></script>
</body>
</html>


