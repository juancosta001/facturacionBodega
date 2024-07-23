/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import java.io.IOException;
import java.io.PrintWriter;

import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.compramodelo;
import modelo.pagomodelo;

/**
 *
 * @author juana
 */
@WebServlet(name = "pagocontrolador", urlPatterns = {"/pagocontrolador"})
public class pagocontrolador extends HttpServlet {

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
            out.println("<title>Servlet pagocontrolador</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet pagocontrolador at " + request.getContextPath() + "</h1>");
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
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
                acceso = "vistas/guardarpago.jsp";
            } else if (action.equalsIgnoreCase("guardarpago")) {
                pagomodelo modelo = new pagomodelo();
                modelo.setCodigo(request.getParameter("txtcodigo"));
                modelo.setFecha(request.getParameter("txtfecha"));
                modelo.setEstado("PAGADO");
                modelo.setIdproveedores(request.getParameter("txtcodigoprov"));
                modelo.setIdapertura(request.getParameter("txtaper"));
                modelo.guardarpago();

                // Obtener los IDs de las compras seleccionadas
                String[] comprasSeleccionadas = request.getParameterValues("comprasSeleccionadas");

                if (comprasSeleccionadas != null) {
                    for (String compraId : comprasSeleccionadas) {
                        // Obtener el monto correspondiente a la compra seleccionada
                        String monto = request.getParameter("monto_" + compraId);
                        // Guardar el detalle del pago
                        modelo.guardardetalle(compraId, request.getParameter("txtcodigo"), monto);
                    }
                }
                acceso = "pagos.jsp";
            } else if (action.equalsIgnoreCase("buscarComprasPendientes")) {
                String proveedorId = request.getParameter("proveedorId");
                pagomodelo modelo = new pagomodelo();
                List<compramodelo> comprasPendientes = modelo.obtenerComprasPendientes(proveedorId);

                response.setContentType("text/html;charset=UTF-8");
                PrintWriter out = response.getWriter();
                try {
                    for (compramodelo compra : comprasPendientes) {
                        out.println("<tr>");
                        out.println("<td><span class='dato-input'>" + compra.getIdCompra() + "</span></td>");
                        out.println("<td><span class='dato-input'>" + compra.getFecha() + "</span></td>");
                        out.println("<td><span class='dato-input'>" + compra.getCondicion() + "</span></td>");
                        out.println("<td><input type='text' readonly name='monto_" + compra.getIdCompra() + "' value='" + compra.getMonto() + "'></td>");
                        out.println("<td><input type='checkbox' name='comprasSeleccionadas' value='" + compra.getIdCompra() + "'></td>");
                        out.println("</tr>");
                    }
                } catch (Exception e) {
                    // Manejar la excepción apropiadamente
                    e.printStackTrace();
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    out.println("Error al obtener compras pendientes: " + e.getMessage());
                } finally {
                    out.close();
                }
                return;
            } else if (action.equalsIgnoreCase("informe")) {
                acceso = "reportes/rptpago.jsp";
            } else if (action.equalsIgnoreCase("anular")) {
                String idPago = request.getParameter("id");
                pagomodelo modelo = new pagomodelo();

                // Actualizar estado del pago a ANULADO
                modelo.actualizarEstadoPago(idPago, "ANULADO");

                // Obtener idcompra asociado al pago y revertir su estado a PENDIENTE
                String idCompra = modelo.obtenerIdCompraAsociada(idPago); // Necesitas implementar este método en pagomodelo.java
                modelo.revertirEstadoCompra(idCompra);

                // Redireccionar de vuelta a pagos.jsp o cualquier página que desees
                acceso = "pagos.jsp";
            }
        }

        if (!acceso.equals("")) {
            RequestDispatcher vista = request.getRequestDispatcher(acceso);
            vista.forward(request, response);
        }
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
