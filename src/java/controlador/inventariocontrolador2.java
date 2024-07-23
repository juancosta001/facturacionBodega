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
import modelo.inventariomodelo2;

/**
 * Servlet implementation class inventariocontrolador
 */
@WebServlet(name = "inventariocontrolador2", urlPatterns = {"/inventariocontrolador2"})
public class inventariocontrolador2 extends HttpServlet {

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
            // Empty implementation
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
        
        String inventarioId = request.getParameter("inventario");
        System.out.println("ID de inventario recibido: " + inventarioId);
        if (inventarioId != null) {
            request.setAttribute("inventario", inventarioId);
            RequestDispatcher dispatcher = request.getRequestDispatcher("reportes/rptinventario.jsp");
            dispatcher.forward(request, response);
        }
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
    String inventarioId = request.getParameter("inventario");

    if (action != null) {
        if (action.equalsIgnoreCase("home")) {
            acceso = "index.jsp";
        } else if (action.equalsIgnoreCase("add")) {
            acceso = "vistas/guardarinventario2.jsp";
        } else if (action.equalsIgnoreCase("guardarinventario")) {
            inventariomodelo2 modelo = new inventariomodelo2();
            modelo.setIdinventario(request.getParameter("txtidinventario"));
            modelo.setFecha(request.getParameter("txtfechainv"));
            modelo.setEstado("COMPLETADO");
            modelo.setIdapertura(request.getParameter("txtaper"));
            modelo.guardarInventario();

            String[] codigos = request.getParameterValues("idproducto[]");
            String[] stocks = request.getParameterValues("stock[]");
            String[] cantidades = request.getParameterValues("cantidad[]");
            String[] acciones = request.getParameterValues("accion[]");

            if (codigos != null && stocks != null && cantidades != null && acciones != null) {
                for (int i = 0; i < codigos.length; i++) {
                    String codigo = codigos[i];
                    String stock = stocks[i];
                    String cantidad = cantidades[i];
                    String accion = acciones[i];
                    System.out.println("Saving detail: " + codigo + ", " + stock + ", " + cantidad + ", " + accion);
                    modelo.guardarDetalleInventario(request.getParameter("txtidinventario"), codigo, accion, cantidad);
                }
            } else {
                System.out.println("Parametros nulos o vacíos");
            }
            acceso = "inventarios.jsp";
        } else if (action.equalsIgnoreCase("imprimir")) {
            inventarioId = request.getParameter("inventario");
            System.out.println("ID de inventario recibido: " + inventarioId);
            request.setAttribute("inventario", inventarioId);
            acceso = "reportes/rptinventario.jsp";
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
        return "Servlet para manejar inventarios";
    }// </editor-fold>
}
