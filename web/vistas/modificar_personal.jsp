<%-- 
    Document   : modificar_personal
    Created on : 20 abr 2024, 12:44:49
    Author     : juana
--%>

<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="modelo.modelopersonal"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Modificar Personal</title>
        <link rel="stylesheet" href="../css/style.css"/>
        <link rel="stylesheet" href="../css/bootstrap.min.css"/>
         <title>Modificar Personal</title>
    </head>
    <body>
          
       <%
            HttpSession sesion = request.getSession();
            if(sesion.getAttribute("sesion") == null){
                out.print("<script>location.replace('../index.jsp')</script>");
            }
        %>
          <%  String id= request.getParameter("id");
                modelopersonal modelo = new modelopersonal();
                modelo.setCodigo(id);
                List <modelopersonal> list = modelo.listarid(id);
                Iterator <modelopersonal> iter = list.iterator();
                iter.hasNext();
                modelopersonal m = null;
                while(iter.hasNext()){
                m = iter.next();
                }
                
            %>
      
    <main>
        <div class="container">
            <div class="row">
                <div class="col-md-6 offset-md-3">
                    <form action="../personalcontrolador" method="post">
                        <div class="form-container">
                            <h2>Modificar Personal</h2>
                            <input type="hidden" name="txtcodigo" value="<%=m.getCodigo()%>">
                            <div class="form-group">
                                <label for="txtnombre">Nombre:</label>
                                <input type="text" id="txtnombre" name="txtnombre" class="form-control" value="<%=m.getNombre()%>" required>
                            </div>
                            <div class="form-group">
                                <label for="txtapellido">Apellido:</label>
                                <input type="text" id="txtapellido" name="txtapellido" class="form-control" value="<%=m.getApellido()%>" required>
                            </div>
                            <div class="form-group">
                                <label for="txtci">C.I:</label>
                                <input type="text" id="txtci" name="txtci" class="form-control" value="<%=m.getCi()%>" required>
                            </div>
                            <div class="form-group">
                                <label for="txttelefono">Teléfono:</label> 
                                <input type="text" id="txttelefono" name="txttelefono" class="form-control" value="<%=m.getTelefono()%>" required>
                            </div>
                            <input type="submit" class="btn btn-primary btn-block" name="accion" value="Modificar" >
                            <a href="../personales.jsp" class="btn btn-secondary btn-block">Volver</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </main>
    </body>
</html>
