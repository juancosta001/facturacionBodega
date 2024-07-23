<%-- 
    Document   : modificar_clientes
    Created on : 23 abr 2024, 21:03:10
    Author     : juana
--%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="modelo.modelocliente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="../css/style.css"/>
    <link rel="stylesheet" href="../css/bootstrap.min.css"/>
    <title>Modificar Clientes</title>
    
</head>
<body>
  
    
     <%
            
        %>
    <%
        
        modelocliente modeloCliente = new modelocliente();
        String idCliente = request.getParameter("id");
        modeloCliente.setCodigo(idCliente);
        List<modelocliente> listaClientes = modeloCliente.listarClientesPorId(idCliente);
        modelocliente cliente = null;
        for (modelocliente c : listaClientes) {
            if (c.getCodigo().equals(idCliente)) {
                cliente = c;
                break;
            }
        }
    %>
    <main>
        <div class="container">
            <div class="row">
                <div class="col-md-6 offset-md-3" style="position:relative;top:150px">
                    <form action="../clientecontrolador" method="post">
                        <div class="form-container">
                            <h2>Modificar Cliente</h2>
                            <input type="hidden" name="txtcodigo" value="<%=cliente.getCodigo()%>">
                            <div class="form-group">
                                <label for="txtnombre">Nombre:</label>
                                <input type="text" id="txtnombre" name="txtnombre" class="form-control" value="<%=cliente.getNombre()%>" required>
                            </div>
                            <div class="form-group">
                                <label for="txtapellido">Apellido:</label>
                                <input type="text" id="txtapellido" name="txtapellido" class="form-control" value="<%=cliente.getApellido()%>" required>
                            </div>
                            <div class="form-group">
                                <label for="txtruc">RUC:</label>
                                <input type="text" id="txtruc" name="txtruc" class="form-control" value="<%=cliente.getRuc()%>" required>
                            </div>
                            <div class="form-group">
                                <label for="txttelefono">Teléfono:</label>
                                <input type="text" id="txttelefono" name="txttelefono" class="form-control" value="<%=cliente.getTelefono()%>" required>
                            </div>
                            <div class="form-group">
                                <label for="cbociudad">Ciudad:</label>
                                <select id="cbociudad" name="cbociudad" class="form-control">
                                    <% modelocliente modeloCli = new modelocliente();
                                        List<modelocliente> listaCiudades = modeloCli.listarciudades();
                                        for (modelocliente cli : listaCiudades) {%>
                                    <option value="<%= cli.getCodigo()%>" <%= cliente != null && cli.getCodigo().equals(cliente.getCiudad()) ? "selected" : ""%>><%= cli.getNombreCiudad()%></option>
                                    <% }%>
                                </select>
                            </div>
                            <input type="submit" class="btn btn-primary btn-block" name="accion" value="Modificar">
                            <a href="../clientes.jsp" class="btn btn-secondary btn-block">Volver</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </main>
</body>
</html>
