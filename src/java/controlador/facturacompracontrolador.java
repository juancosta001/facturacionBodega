/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.compramodelo;

/**
 * @author juana
 *
 */
@WebServlet(name = "facturacompracontrolador", urlPatterns = {"/facturacompracontrolador"})
public class facturacompracontrolador extends HttpServlet {

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
            out.println("<title>Servlet facturacompracontrolador</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet facturacompracontrolador at " + request.getContextPath() + "</h1>");
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
        String compraId = request.getParameter("compra");

        if (action != null) {
            if (action.equalsIgnoreCase("home")) {
                acceso = "index.jsp";
            } else {
                if (action.equalsIgnoreCase("add")) {
                    acceso = "vistas/guardarcompra.jsp";
                } else {
                    if (action.equalsIgnoreCase("guardarcompra")) {
                        compramodelo modelo = new compramodelo();
                        modelo.setIdCompra(request.getParameter("txtnumero"));
                        modelo.setFecha(request.getParameter("txtfechacompra"));
                        modelo.setCondicion(request.getParameter("condicion"));

                        String condicion = request.getParameter("condicion");
                        String estado = condicion.equalsIgnoreCase("contado") ? "COMPLETADO" : "PENDIENTE";
                        modelo.setEstado(estado);

                        modelo.setIdUsuarios(request.getParameter("txtusu"));
                        modelo.setIdApertura(request.getParameter("txtaper"));
                        modelo.setProveedor(request.getParameter("txtcodigopro"));
                        modelo.guardarCompra();
                        String[] codigos = request.getParameterValues("codigo[]");
                        String[] cantidades = request.getParameterValues("cantidad[]");
                        String[] preciosUnitarios = request.getParameterValues("precio[]");
                        for (int i = 0; i < codigos.length; i++) {
                            String codigo = codigos[i];
                            String cantidad = cantidades[i];
                            String precioUnitario = preciosUnitarios[i];
                            modelo.guardarDetalle(request.getParameter("txtnumero"), codigo, cantidad, precioUnitario);
                        }
                        acceso = "facturacompra.jsp";
                    } else {
                        if (action.equalsIgnoreCase("imprimir")) {
                            request.setAttribute("compra2", request.getParameter("compra"));
                            System.out.println("ID de compra recibido: " + compraId);
                            acceso = "reportes/rptcompra.jsp";
                        }
                    }
                }
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
