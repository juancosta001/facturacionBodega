<%-- 
    Document   : modificar_proveedor
    Created on : 23 abr 2024, 16:48:20
    Author     : juana
--%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="modelo.modeloproveedor"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <img class="logo" src="../img/logobodega.png" alt="logo"/>
        <link rel="stylesheet" href="../css/style.css"/>
        <link rel="stylesheet" href="../css/bootstrap.min.css"/>
        <title>Modificar Proveedor</title>
</head>
<body>
    <%
            HttpSession sesion = request.getSession();
            if (sesion.getAttribute("sesion") == null) {
                out.print("<script>location.replace('../index.jsp')</script>");
            }
        %>
    <%
       

        modeloproveedor modelo = new modeloproveedor();
        String id = request.getParameter("id");
        modelo.setCodigo(id);
        List<modeloproveedor> list = modelo.listarProveedoresPorId(id);
        modeloproveedor proveedor = null;
        for (modeloproveedor p : list) {
            if (p.getCodigo().equals(id)) {
                proveedor = p;
                break;
            }
        }
    %>
   
    <main>
        <div class="container">
            <div class="row">
                <div class="col-md-6 offset-md-3">
                    <form action="../proveedorcontrolador" method="post">
                        <div class="form-container">
                            <h2>Modificar Proveedor</h2>
                            <input type="hidden" name="txtcodigo" value="<%=proveedor.getCodigo()%>">
                            <div class="form-group">
                                <label for="txtnombre">Nombre:</label>
                                <input type="text" id="txtnombre" name="txtnombre" class="form-control" value="<%=proveedor.getNombre()%>" required>
                            </div>
                            <div class="form-group">
                                <label for="txtruc">RUC:</label>
                                <input type="text" id="txtruc" name="txtruc" class="form-control" value="<%=proveedor.getRuc()%>" required>
                            </div>
                            <div class="form-group">
                                <label for="txttelefono">Teléfono:</label>
                                <input type="text" id="txttelefono" name="txttelefono" class="form-control" value="<%=proveedor.getTelefono()%>" required>
                            </div>
                            <div class="form-group">
                                <label for="txtcorreo">Correo:</label>
                                <input type="text" id="txtcorreo" name="txtcorreo" class="form-control" value="<%=proveedor.getCorreo()%>" required>
                            </div>
                            <div class="form-group">
                                <label for="cbopersonal">Ciudad:</label>
                                <select id="cbociudad" name="cbociudad" class="form-control" required>
                                    <% modeloproveedor modeloProv = new modeloproveedor();
                                        List<modeloproveedor> listaCiudades = modeloProv.listarciudades();
                                        for (modeloproveedor prov : listaCiudades) {%>
                                    <option value="<%= prov.getCodigo()%>" <%= proveedor != null && prov.getCodigo().equals(proveedor.getCiudad()) ? "selected" : ""%>><%= prov.getCiudad()%></option>
                                    <% }%>
                                </select>


                            </div>
                            <input type="submit" class="btn btn-primary btn-block" name="accion" value="Modificar">
                            <a href="../proveedores.jsp" class="btn btn-secondary btn-block">Volver</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </main>
</body>
</html>
