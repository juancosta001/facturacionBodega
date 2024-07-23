<%-- 
    Document   : modificar_producto
    Created on : 23 abr 2024, 22:24:19
    Author     : juana
--%>
<%@page import="modelo.modeloproducto"%>
<%@page import="java.util.List"%>
<%@page import="modelo.modeloproveedor"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Modificar Producto</title>
    <link rel="stylesheet" href="../css/style.css"/>
    <link rel="stylesheet" href="../css/bootstrap.min.css"/>
</head>
<body>
    <%
        HttpSession sesion = request.getSession();
        if (sesion.getAttribute("sesion") == null) {
            out.print("<script>location.replace('../index.jsp')</script>");
        }
    %>
    <%
        modeloproducto modelo = new modeloproducto();
        String id = request.getParameter("id");
        modelo.setId(id);
        List<modeloproducto> list = modelo.listarProductos();
        modeloproducto producto = null;
        for (modeloproducto p : list) {
            if (p.getId().equals(id)) {
                producto = p;
                break;
            }
        }
    %>
    <main>
        <div class="container">
            <div class="row">
                <div class="col-md-6 offset-md-3">
                    <form action="../productocontrolador" method="post">
                        <div class="form-container">
                            <h2>Modificar Producto</h2>
                            <input type="hidden" name="txtcodigo" value="<%= producto != null ? producto.getId() : "" %>">
                            <div class="form-group">
                                <label for="txtnombre">Nombre:</label>
                                <input type="text" id="txtnombre" name="txtnombre" class="form-control" value="<%= producto != null ? producto.getNombre() : "" %>" required>
                            </div>
                            <div class="form-group">
                                <label for="txtcosto">Costo:</label>
                                <input type="text" id="txtcosto" name="txtcosto" class="form-control" value="<%= producto != null ? producto.getCosto() : "" %>" required>
                            </div>
                            <div class="form-group">
                                <label for="txtprecio">Precio:</label>
                                <input type="text" id="txtprecio" name="txtprecio" class="form-control" value="<%= producto != null ? producto.getPrecio() : "" %>" required>
                            </div>
                            <div class="form-group">
                                <label for="txtstock">Stock:</label>
                                <input type="text" id="txtstock" name="txtstock" class="form-control" value="<%= producto != null ? producto.getStock() : "" %>" required>
                            </div>
                            <div class="form-group">
                                <label for="txtstockminimo">Stock Mínimo:</label>
                                <input type="text" id="txtstockminimo" name="txtstockminimo" class="form-control" value="<%= producto != null ? producto.getStockMinimo() : "" %>" required>
                            </div>
                            <div class="form-group">
                                <label for="cboproveedor">Proveedor:</label>
                                <select id="cboproveedor" name="cboproveedor" class="form-control" required>
                                    <% 
                                        modeloproveedor modeloProveedor = new modeloproveedor();
                                        List<modeloproveedor> listaProveedores = modeloProveedor.listarProveedores();
                                        for (modeloproveedor proveedor : listaProveedores) { 
                                    %>
                                        <option value="<%= proveedor.getCodigo() %>" <%= producto != null && proveedor.getCodigo().equals(producto.getProveedor()) ? "selected" : "" %>><%= proveedor.getNombre() %></option>
                                    <% } %>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>IVA:</label>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="iva" id="ivaExenta" value="Exenta" <%= producto != null && "Exenta".equals(producto.getIva()) ? "checked" : "" %>>
                                    <label class="form-check-label" for="ivaExenta">Exenta</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="iva" id="iva5" value="5%" <%= producto != null && "5%".equals(producto.getIva()) ? "checked" : "" %>>
                                    <label class="form-check-label" for="iva5">5%</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="iva" id="iva10" value="10%" <%= producto != null && "10%".equals(producto.getIva()) ? "checked" : "" %>>
                                    <label class="form-check-label" for="iva10">10%</label>
                                </div>
                            </div>
                            <input type="submit" class="btn btn-primary btn-block" name="accion" value="Modificar">
                            <a href="../productos.jsp" class="btn btn-secondary btn-block">Volver</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </main>
</body>
</html>

