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
import modelo.loginmodelo;
import modelo.modelousuario;

/**
 *
 * @author juana
 */
@WebServlet(name = "usuariocontrolador", urlPatterns = {"/usuariocontrolador"})
public class usuariocontrolador extends HttpServlet {

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
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @p
     * aram response servlet response
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

    if (action != null && action.equalsIgnoreCase("Ingresar")) {
        // Lógica para validar el inicio de sesión
        loginmodelo m = new loginmodelo();
        m.setUsuario(request.getParameter("txtusuario"));
        m.setClave(request.getParameter("txtclave"));
        HttpSession sesion = request.getSession();
        boolean aux = m.acceder();
        if (aux) {
            String tipo = m.validar();
            if (tipo.equals("ADMINISTRADOR")) {
                sesion.setAttribute("sesion","activo");
                acceso = "menuprincipal.jsp";
            } else {
                acceso = "menuinvitado.jsp";
            }
        } else {
            // Inicio de sesión fallido, mostrar mensaje de error y redirigir al formulario de inicio de sesión
            request.setAttribute("error", "Nombre de usuario o contraseña incorrectos");
            acceso = "index.jsp";
        }
    } else {
        // Otras acciones del controlador
        if (action != null) {
            if (action.equalsIgnoreCase("home")) {
                acceso = "menuprincipal.jsp";
            } else {
                if (action.equalsIgnoreCase("Agregar")) {
                    modelousuario modelo = new modelousuario();
                    modelo.setNombre(request.getParameter("txtnombre"));
                    modelo.setClave(request.getParameter("txtclave"));
                    modelo.setTipo(request.getParameter("txttipo"));
                    modelo.setEstado(request.getParameter("txtestado"));
                    modelo.setPersonal(request.getParameter("cbopersonal")); 
                    modelo.guardarusuario();
                    System.out.println("Mensaje del modelo: " + modelo.getMensaje());
                    acceso = "usuarios.jsp";
                } else {
                    if (action.equals("nuevo")) {
                        acceso = "vistas/agregarusuario.jsp";
                    } else {
                        if (action.equalsIgnoreCase("Modificar")) {
                            modelousuario modelo = new modelousuario();
                            modelo.setCodigo(request.getParameter("txtcodigo"));
                            modelo.setNombre(request.getParameter("txtnombre"));
                            modelo.setClave(request.getParameter("txtclave"));
                            modelo.setTipo(request.getParameter("txttipo"));
                            modelo.setEstado(request.getParameter("txtestado"));
                            modelo.setPersonal(request.getParameter("cbopersonal")); 
                            modelo.modificarusuario();
                            acceso = "usuarios.jsp";
                        } else if (action.equalsIgnoreCase("informe")) {
                            acceso = "reportes/rptusuarios.jsp";
                        }
                    }
                }
            }
        }
    }

    if (editar != null) {
        request.setAttribute("idusuarios", editar);
        acceso = "vistas/modificar_usuario.jsp";
    }

    if (borrar != null) {
        modelousuario modelo = new modelousuario();
        modelo.setCodigo(borrar);
        modelo.eliminarusuario();
        acceso = "usuarios.jsp";
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
