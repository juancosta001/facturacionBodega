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
import javax.servlet.http.HttpSession;
import modelo.cobromodelo;
import modelo.facturaventamodelo;
import modelo.modelocliente;

/**
 *
 * @author juana
 */
@WebServlet(name = "cobrocontrolador2", urlPatterns = {"/cobrocontrolador2"})
public class cobrocontrolador2 extends HttpServlet {

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
            out.println("<title>Servlet cobrocontrolador2</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet cobrocontrolador2 at " + request.getContextPath() + "</h1>");
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
                acceso = "vistas/guardarcobro.jsp";
            } else if (action.equalsIgnoreCase("guardarcobro")) {
                cobromodelo modelo = new cobromodelo();
                modelo.setCodigo(request.getParameter("txtcodigo"));
                modelo.setFecha(request.getParameter("txtfecha"));
                modelo.setEstado("COBRADO");
                modelo.setIdclientes(request.getParameter("txtcodigocli"));
                modelo.setIdapertura(request.getParameter("txtaper"));
                modelo.guardarcobro();

                // Obtener los IDs de las facturas seleccionadas
                String[] facturasSeleccionadas = request.getParameterValues("facturasSeleccionadas");

                if (facturasSeleccionadas != null) {
                    for (String facturaId : facturasSeleccionadas) {
                        // Obtener el monto correspondiente a la factura seleccionada
                        String monto = request.getParameter("monto_" + facturaId);
                        // Guardar el detalle del cobro
                        modelo.guardardetalle(facturaId, request.getParameter("txtcodigo"), monto);
                    }
                }
                acceso = "cobros.jsp";
            } else if (action.equalsIgnoreCase("buscarFacturasPendientes")) {
                String clienteId = request.getParameter("clienteId");
                cobromodelo modelo = new cobromodelo();
                List<facturaventamodelo> facturasPendientes = modelo.obtenerFacturasPendientes(clienteId);

                response.setContentType("text/html;charset=UTF-8");
                PrintWriter out = response.getWriter();
                for (facturaventamodelo factura : facturasPendientes) {
                    out.println("<tr>");
                    out.println("<td><span class='dato-input'>" + factura.getIdfacturacion() + "</span></td>");
                    out.println("<td><span class='dato-input'>" + factura.getEstado() + "</span></td>");
                    out.println("<td><span class='dato-input'>" + factura.getCondicion() + "</span></td>");
                    out.println("<td><input type='text' readonly name='monto_" + factura.getIdfacturacion() + "' value='" + factura.getMonto() + "'></td>");
                    out.println("<td><input type='checkbox' name='facturasSeleccionadas' value='" + factura.getIdfacturacion() + "'></td>");
                    out.println("</tr>");
                }
                return;
            } else if (action.equalsIgnoreCase("informe")) {
                acceso = "reportes/rptcobro.jsp";
            } else if (action.equalsIgnoreCase("anular")) {
                String idCobro = request.getParameter("id");
                cobromodelo modelo = new cobromodelo();

                // Actualizar estado del cobro a ANULADO
                modelo.actualizarEstadoCobro(idCobro, "ANULADO");

                // Obtener idventa asociado al cobro y revertir su estado a PENDIENTE
                String idVenta = modelo.obtenerIdVentaAsociada(idCobro); // Necesitas implementar este método en cobromodelo.java
                modelo.revertirEstadoVenta(idVenta);

                // Redireccionar de vuelta a cobros.jsp o cualquier página que desees
                acceso = "cobros.jsp";
            }

        }
        if ("buscarClientesConFacturasPendientes".equals(action)) {
            modelocliente modeloCliente = new modelocliente();
            List<modelocliente> listaClientes = modeloCliente.listarClientesConFacturasPendientes();

            request.setAttribute("listaClientes", listaClientes);
            RequestDispatcher rd = request.getRequestDispatcher("vistas/guardarcobro.jsp");
            rd.forward(request, response);
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
