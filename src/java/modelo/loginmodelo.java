/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

import java.util.logging.Logger;
import java.util.logging.Level;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;

/**
 *
 * @author ALUMNOS
 */
public class loginmodelo {

    private String usuario, clave;
    Statement st;
    ResultSet rs;
    private String mensaje;
    private String mensajeError;

    public String getMensajeError() {
        return mensajeError;
    }

    public void setMensajeError(String mensajeError) {
        this.mensajeError = mensajeError;
    }

    public String getMensaje() {
        return mensaje;
    }

    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getClave() {
        return clave;
    }

    public void setClave(String clave) {
        this.clave = clave;
    }

    public boolean acceder() {
        boolean acceso = false;
        String sql = "SELECT * FROM usuarios WHERE usu_nombre='" + usuario + "' AND usu_clave='" + clave + "'";
        try {
            st = utilidades.conexion.sta(st);
            rs = st.executeQuery(sql);
            if (!rs.next()) {
                mensajeError = "Usuario o contraseña incorrectos";
            } else {
                acceso = true;
            }
            st.close();
            rs.close();
        } catch (SQLException ex) {
            Logger.getLogger(loginmodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
        return acceso;
    }

    public String validar() {
        String sql = "SELECT * FROM usuarios WHERE usu_nombre='" + usuario + "' AND usu_clave='" + clave + "'";
        String tipo = "";
        try {
            st = utilidades.conexion.sta(st);
            rs = st.executeQuery(sql);
            if (rs.next()) {
                tipo = rs.getString("usu_tipo");
            } else {
                tipo = "error";
            }
            st.close();
            rs.close();
        } catch (Exception ex) {
            Logger.getLogger(loginmodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
        return tipo;
    }

    public String obtenerId() {
        String sql = "select * from usuarios where usu_nombre='" + usuario + "' and usu_clave='" + clave + "' and usu_estado='ACTIVO'";
        String id = "";
        try {
            st = utilidades.conexion.sta(st);
            rs = st.executeQuery(sql);
            rs.next();
            if (rs.getRow() == 0) {
                id = "error";
            } else {
                id = rs.getString("idusuarios");
            }
            st.close();
            rs.close();
        } catch (SQLException ex) {
            Logger.getLogger(loginmodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
        return id;
    }

    public String obtenerNombreUsuario() {
        String sql = "SELECT * FROM usuarios WHERE usu_nombre='" + usuario + "' AND usu_clave='" + clave + "'";
        String nombre = "";
        try {
            st = utilidades.conexion.sta(st);
            rs = st.executeQuery(sql);
            if (rs.next()) {
                nombre = rs.getString("usu_nombre");
            } else {
                nombre = "Usuario no encontrado";
            }
            st.close();
            rs.close();
        } catch (Exception ex) {
            Logger.getLogger(loginmodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
        return nombre;
    }

}
