/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.loginmodelo;

/**
 *
 * @author ALUMNOS
 */
@WebServlet(name = "logincontrolador", urlPatterns = {"/logincontrolador"})
public class logincontrolador extends HttpServlet {

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
        HttpSession sesion = request.getSession();
        if (action.equalsIgnoreCase("Ingresar")) {
            loginmodelo m = new loginmodelo();
            m.setUsuario(request.getParameter("txtusuario"));
            m.setClave(request.getParameter("txtclave"));
            boolean aux = m.acceder();
            if (aux == false) {
                request.setAttribute("error", m);
                acceso = "index.jsp";
            } else {
                String tipo = m.validar();
                sesion.setAttribute("sesion", "activo");
                sesion.setAttribute("usunombre", m.getUsuario());
                sesion.setAttribute("idusuario", m.obtenerId());
                if (tipo.equals("ADMINISTRADOR")) {
                    sesion.setAttribute("sesion", "activo");
                    acceso = "menuprincipal.jsp";
                }
                if (tipo.equals("Invitado")) {
                    sesion.setAttribute("sesion", "activo");
                    acceso = "menuinvitado.jsp";
                }
                String nombreUsuario = m.obtenerNombreUsuario();
                String idUsuario = m.obtenerId();

            }
        }
        RequestDispatcher vista = request.getRequestDispatcher(acceso);
        vista.forward(request, response);
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
