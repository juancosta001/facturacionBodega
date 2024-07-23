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
import javax.servlet.http.HttpSession;
import modelo.modelopersonal;

/**
 *
 * @author juana
 */
@WebServlet(name = "personalcontrolador", urlPatterns = {"/personalcontrolador"})
public class personalcontrolador extends HttpServlet {

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
        String editar = request.getParameter("editar");
        String borrar = request.getParameter("delete");
        HttpSession sesion = request.getSession();
        if (action != null) {
            if (action.equalsIgnoreCase("home")) {
                acceso = "menuprincipal.jsp";
            } else {
                sesion.setAttribute("sesion","activo");
                if (action.equalsIgnoreCase("Agregar")) {
                    sesion.setAttribute("sesion","activo");
                   modelopersonal modelo = new modelopersonal();
                    modelo.setNombre(request.getParameter("txtnombre"));
                    modelo.setApellido(request.getParameter("txtapellido"));
                    modelo.setCi(request.getParameter("txtci"));
                    modelo.setTelefono(request.getParameter("txttelefono"));
                    modelo.guardarpersonal();
                    acceso = "personales.jsp";
                } else {
                    if (action.equals("nuevo")) {  
                        acceso = "vistas/agregarpersonal.jsp";
                    } else {
                        if (action.equalsIgnoreCase("Modificar")) {
                            modelopersonal modelo = new modelopersonal();
                            modelo.setCodigo(request.getParameter("txtcodigo"));
                            modelo.setNombre(request.getParameter("txtnombre"));
                            modelo.setApellido(request.getParameter("txtapellido"));
                            modelo.setCi(request.getParameter("txtci"));
                            modelo.setTelefono(request.getParameter("txttelefono"));
                            modelo.modificarpersonal();
                            acceso = "personales.jsp";
                        } else if (action.equalsIgnoreCase("informe")) {
                            acceso = "reportes/rptpersonal.jsp";
                        }
                    }
                }
            }
        }
        if(editar != null){
            request.setAttribute("idpersonales", editar);
            acceso = "vistas/modificar_personal.jsp";
        }
        if(borrar != null){
            modelopersonal model = new modelopersonal();
            model.setCodigo(borrar);
            model.eliminarpersonal();
            acceso = "personales.jsp";
        }
        
        if(!acceso.equals("")){
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
