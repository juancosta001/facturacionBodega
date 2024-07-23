/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.inventariomodelo;
import java.util.logging.Logger;
import java.util.logging.Level;

/**
 *
 * @author juana
 */
@WebServlet(name = "inventariocontrolador", urlPatterns = {"/inventariocontrolador"})
public class inventariocontrolador extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet inventariocontrolador</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet inventariocontrolador at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
      @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String acceso = "";
        String action = request.getParameter("accion");

        if (action != null) {
            if (action.equalsIgnoreCase("home")) {
                acceso = "index.jsp";
            } else if (action.equalsIgnoreCase("add")) {
                acceso = "vistas/guardarinventario.jsp";
            } else if (action.equalsIgnoreCase("guardarInventario")) {
                try {
                    inventariomodelo modelo = new inventariomodelo();
                    modelo.setIdInventario(request.getParameter("idinventario"));
                    modelo.setEstado("COMPLETADO");
                    modelo.setFecha(request.getParameter("txtfecha"));
                    modelo.setIdAperturas(request.getParameter("txtaper"));
                    modelo.guardarInventario();

                    // Obtener los parámetros del formulario
                    String[] productos = request.getParameterValues("idProductos[]");
                    String[] cantidades = request.getParameterValues("cantidades[]");
                    String[] acciones = request.getParameterValues("acciones[]");

                    // Logs para depuración
                    Logger.getLogger(inventariocontrolador.class.getName()).log(Level.INFO, "Productos recibidos: {0}", (productos != null ? Arrays.toString(productos) : "null"));
                    Logger.getLogger(inventariocontrolador.class.getName()).log(Level.INFO, "Cantidades recibidas: {0}", (cantidades != null ? Arrays.toString(cantidades) : "null"));
                    Logger.getLogger(inventariocontrolador.class.getName()).log(Level.INFO, "Acciones recibidas: {0}", (acciones != null ? Arrays.toString(acciones) : "null"));

                    // Verificar si los arrays no son nulos y tienen la misma longitud
                    if (productos != null && cantidades != null && acciones != null
                            && productos.length == cantidades.length && productos.length == acciones.length) {

                        for (int i = 0; i < productos.length; i++) {
                            String producto = productos[i];
                            String accion = acciones[i];
                            String cantidadStr = cantidades[i];

                            if (!cantidadStr.isEmpty()) {
                                try {
                                    int cantidad = Integer.parseInt(cantidadStr);
                                    // Llama al método para guardar el detalle del inventario
                                    modelo.guardarDetalleInventario(modelo.getIdInventario(), producto, accion, cantidad);
                                } catch (NumberFormatException e) {
                                    Logger.getLogger(inventariocontrolador.class.getName()).log(Level.SEVERE, "Error al convertir cantidad a entero", e);
                                    // Manejar la excepción según sea necesario (redireccionamiento a página de error, etc.)
                                }
                            } else {
                                Logger.getLogger(inventariocontrolador.class.getName()).log(Level.WARNING, "Cantidad vacía para producto: {0}", producto);
                                // Puedes decidir cómo manejar este caso según tus requerimientos
                            }
                        }
                    } else {
                        Logger.getLogger(inventariocontrolador.class.getName()).log(Level.WARNING, "Longitudes de arrays no coinciden o arrays nulos");
                        // Manejar el caso donde los arrays no tienen la misma longitud o son nulos
                    }

                    acceso = "inventarios.jsp";
                } catch (Exception e) {
                    Logger.getLogger(inventariocontrolador.class.getName()).log(Level.SEVERE, "Error al procesar solicitud de guardar inventario", e);
                    // Manejar la excepción según sea necesario (redireccionamiento a página de error, etc.)
                }
            } else if (action.equalsIgnoreCase("eliminar")) {
                String idInventario = request.getParameter("id");
                try {
                    inventariomodelo modelo = new inventariomodelo();
                    modelo.eliminarInventario(idInventario);
                    acceso = "inventarios.jsp"; // Revisar si es correcto redireccionar aquí o a otra página
                } catch (Exception e) {
                    Logger.getLogger(inventariocontrolador.class.getName()).log(Level.SEVERE, "Error al eliminar inventario", e);
                    // Manejar la excepción según sea necesario (redireccionamiento a página de error, etc.)
                }
            }
        }

        if (!acceso.equals("")) {
            RequestDispatcher vista = request.getRequestDispatcher(acceso);
            vista.forward(request, response);
        }
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }


    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
