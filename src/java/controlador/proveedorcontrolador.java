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
import modelo.modeloproveedor;

/**
 *
 * @author juana
 */
@WebServlet(name = "proveedorcontrolador", urlPatterns = {"/proveedorcontrolador"})
public class proveedorcontrolador extends HttpServlet {

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
            out.println("<title>Servlet proveedorcontrolador</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet proveedorcontrolador at " + request.getContextPath() + "</h1>");
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
String editar = request.getParameter("editar");
String borrar = request.getParameter("delete");
List<modeloproveedor> listaCiudades = new modeloproveedor().listarciudades();
    request.setAttribute("listaCiudades", listaCiudades);
    HttpSession sesion = request.getSession();

if (action != null) {
    if (action.equalsIgnoreCase("home")) {
        acceso = "menuprincipal.jsp";
    } else {
         sesion.setAttribute("sesion","activo");
        if (action.equalsIgnoreCase("Agregar")) {
            sesion.setAttribute("sesion","activo");
            modeloproveedor modelo = new modeloproveedor();
            modelo.setNombre(request.getParameter("txtnombre"));
            modelo.setRuc(request.getParameter("txtruc"));
            modelo.setTelefono(request.getParameter("txttelefono"));
            modelo.setCorreo(request.getParameter("txtcorreo"));
            modelo.setCiudad(request.getParameter("cbociudad"));
            modelo.guardarProveedor();
            System.out.println("Mensaje del modelo: " + modelo.getMensaje());
            acceso = "proveedores.jsp";
        } else {
            if (action.equals("nuevo")) {
                
                acceso = "vistas/agregarproveedor.jsp";
            } else {
                if (action.equalsIgnoreCase("Modificar")) {
                
                    modeloproveedor modelo = new modeloproveedor();
                    modelo.setCodigo(request.getParameter("txtcodigo"));
                    modelo.setNombre(request.getParameter("txtnombre"));
                    modelo.setRuc(request.getParameter("txtruc"));
                    modelo.setTelefono(request.getParameter("txttelefono"));
                    modelo.setCorreo(request.getParameter("txtcorreo"));
                    modelo.setCiudad(request.getParameter("cbociudad"));
                    modelo.modificarProveedor();
                    acceso = "proveedores.jsp";
                } else if (action.equalsIgnoreCase("informe")) {
                    acceso = "reportes/rptproveedores.jsp";
                }
            }
        }
    }
}


if (editar != null) {
    request.setAttribute("idproveedores", editar);
    acceso = "vistas/modificar_proveedor.jsp";
}

if (borrar != null) {
    modeloproveedor modelo = new modeloproveedor();
    modelo.setCodigo(borrar);
    modelo.eliminarProveedor();
    acceso = "proveedores.jsp";
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
