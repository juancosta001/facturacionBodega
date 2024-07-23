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
import modelo.modelocliente;
import modelo.modeloproveedor;

/**
 *
 * @author juana
 */
@WebServlet(name = "clientecontrolador", urlPatterns = {"/clientecontrolador"})
public class clientecontrolador extends HttpServlet {

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
            out.println("<title>Servlet clientecontrolador</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet clientecontrolador at " + request.getContextPath() + "</h1>");
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

// Obtener la lista de ciudades desde el modelo de proveedores
        List<modeloproveedor> listaCiudades = new modeloproveedor().listarciudades();
        request.setAttribute("listaCiudades", listaCiudades);
        HttpSession sesion = request.getSession();
        if (action != null) {
            if (action.equalsIgnoreCase("home")) {
                acceso = "menuprincipal.jsp";
            } else {
                sesion.setAttribute("sesion","activo");
                if (action.equalsIgnoreCase("Agregar")) {
                    modelocliente modelo = new modelocliente();
                    modelo.setNombre(request.getParameter("txtnombre"));
                    modelo.setApellido(request.getParameter("txtapellido"));
                    modelo.setRuc(request.getParameter("txtruc"));
                    modelo.setTelefono(request.getParameter("txttelefono"));
                    modelo.setCiudad(request.getParameter("cbociudad"));
                    modelo.guardarCliente();
                    System.out.println("Mensaje del modelo: " + modelo.getMensaje());
                    acceso = "clientes.jsp";
                } else {
                    if (action.equals("nuevo")) {
                      
                        acceso = "vistas/agregarclientes.jsp";
                    } else {
                        if (action.equalsIgnoreCase("Modificar")) {                          
                            modelocliente modelo = new modelocliente();
                            modelo.setCodigo(request.getParameter("txtcodigo"));
                            modelo.setNombre(request.getParameter("txtnombre"));
                            modelo.setApellido(request.getParameter("txtapellido"));
                            modelo.setRuc(request.getParameter("txtruc"));
                            modelo.setTelefono(request.getParameter("txttelefono"));
                            modelo.setCiudad(request.getParameter("cbociudad"));
                            modelo.modificarCliente();
                            acceso = "clientes.jsp";
                        } else if (action.equalsIgnoreCase("informe")) {
                            acceso = "reportes/rptclientes.jsp";
                        }
                    }
                }
            }
        }

        if (editar != null) {
            request.setAttribute("idclientes", editar);
            acceso = "vistas/modificar_cliente.jsp";
        }

        if (borrar != null) {
            modelocliente modelo = new modelocliente();
            modelo.setCodigo(borrar);
            modelo.eliminarCliente();
            acceso = "clientes.jsp";
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
