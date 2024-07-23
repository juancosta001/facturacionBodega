/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author juana
 */
public class modeloproveedor {

    private String codigo;
    private String nombre;
    private String ruc;
    private String telefono;
    private String correo;
    private String ciudad;
    private String mensaje;
    Statement st;
    ResultSet rs;

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getRuc() {
        return ruc;
    }

    public void setRuc(String ruc) {
        this.ruc = ruc;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getCiudad() {
        return ciudad;
    }

    public void setCiudad(String ciudad) {
        this.ciudad = ciudad;
    }

    public String getMensaje() {
        return mensaje;
    }

    public String getNombreCiudad() {
        return ciudad;
    }

    public String getIdProveedor() {
        return codigo;
    }

    public String getNombreProveedor() {
        return nombre;
    }

    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }

    public void guardarProveedor() {
        String sql = "INSERT INTO proveedores(prov_nombre, prov_ruc, prov_telefono, prov_correo, idciudades) "
                + "VALUES('" + nombre + "','" + ruc + "','" + telefono + "','" + correo + "','" + ciudad + "')";
        try {
            st = utilidades.conexion.sta(st);
            st.executeUpdate(sql);
            st.close();
            mensaje = "Proveedor guardado correctamente";
        } catch (SQLException ex) {
            mensaje = "Error al guardar el proveedor: " + ex.getMessage();
            Logger.getLogger(modeloproveedor.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public List<modeloproveedor> listarProveedores() {
        ArrayList<modeloproveedor> lista = new ArrayList<>();
        String sql = "SELECT p.idproveedores, p.prov_nombre, p.prov_ruc, p.prov_telefono, p.prov_correo, c.ciu_nombre "
                + "FROM proveedores p INNER JOIN ciudades c ON p.idciudades = c.idciudades";

        try {
            // Aquí deberías obtener una conexión adecuada y ejecutar la consulta SQL
            st = utilidades.conexion.sta(st);
            rs = st.executeQuery(sql);

            while (rs.next()) {
                modeloproveedor proveedor = new modeloproveedor();
                proveedor.setCodigo(rs.getString("idproveedores"));
                proveedor.setNombre(rs.getString("prov_nombre"));
                proveedor.setRuc(rs.getString("prov_ruc"));
                proveedor.setTelefono(rs.getString("prov_telefono"));
                proveedor.setCorreo(rs.getString("prov_correo"));
                proveedor.setCiudad(rs.getString("ciu_nombre"));
                lista.add(proveedor);
            }
            st.close();
            rs.close();
        } catch (SQLException ex) {
            Logger.getLogger(modeloproveedor.class.getName()).log(Level.SEVERE, null, ex);
        }
        return lista;
    }

    public void eliminarProveedor() {
        String sql = "DELETE FROM proveedores WHERE idproveedores = '" + codigo + "'";
        try {
            st = utilidades.conexion.sta(st);
            st.executeUpdate(sql);
            st.close();
            mensaje = "Proveedor eliminado correctamente";
        } catch (SQLException ex) {
            mensaje = "Error al eliminar el proveedor: " + ex.getMessage();
            Logger.getLogger(modeloproveedor.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public List<modeloproveedor> listarProveedoresPorId(String id) {
        ArrayList<modeloproveedor> lista = new ArrayList<>();
        String sql = "SELECT p.idproveedores, p.prov_nombre, p.prov_ruc, p.prov_telefono, p.prov_correo, c.ciu_nombre "
                + "FROM proveedores p INNER JOIN ciudades c ON p.idciudades = c.idciudades "
                + "WHERE p.idproveedores = '" + id + "'";
        try {
            st = utilidades.conexion.sta(st);
            rs = st.executeQuery(sql);

            while (rs.next()) {
                modeloproveedor proveedor = new modeloproveedor();
                proveedor.setCodigo(rs.getString("idproveedores"));
                proveedor.setNombre(rs.getString("prov_nombre"));
                proveedor.setRuc(rs.getString("prov_ruc"));
                proveedor.setTelefono(rs.getString("prov_telefono"));
                proveedor.setCorreo(rs.getString("prov_correo"));
                proveedor.setCiudad(rs.getString("ciu_nombre"));
                lista.add(proveedor);
            }
            st.close();
            rs.close();
        } catch (SQLException ex) {
            Logger.getLogger(modeloproveedor.class.getName()).log(Level.SEVERE, null, ex);
        }
        return lista;
    }

    public void modificarProveedor() {
        String sql = "UPDATE proveedores SET prov_nombre='" + nombre + "', prov_ruc='" + ruc + "', prov_telefono='" + telefono + "', prov_correo='" + correo + "', idciudades='" + ciudad + "' WHERE idproveedores='" + codigo + "'";
        try {
            st = utilidades.conexion.sta(st);
            st.executeUpdate(sql);
            st.close();
            mensaje = "Proveedor modificado correctamente";
        } catch (SQLException ex) {
            mensaje = "Error al modificar el proveedor: " + ex.getMessage();
            Logger.getLogger(modeloproveedor.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public String obtenerUltimoCodigo() {
        String ultimoCodigo = "";
        String sql = "SELECT MAX(idproveedores) AS ultimo_codigo FROM proveedores";
        try {
            Connection conn = utilidades.conexion.Enlace(null);
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            if (rs.next()) {
                ultimoCodigo = rs.getString("ultimo_codigo");
            }

            rs.close();
            stmt.close();
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(modeloproveedor.class.getName()).log(Level.SEVERE, null, ex);
        }

        return ultimoCodigo;
    }

    public List<modeloproveedor> listarciudades() {
        ArrayList<modeloproveedor> lista = new ArrayList<>();
        String sql = "select * from ciudades";

        try {
            st = utilidades.conexion.sta(st);
            rs = st.executeQuery(sql);

            while (rs.next()) {
                modeloproveedor ciudad = new modeloproveedor();
                ciudad.setCodigo(rs.getString("idciudades"));
                ciudad.setCiudad(rs.getString("ciu_nombre"));
                lista.add(ciudad);
            }

            st.close();
            rs.close();
        } catch (SQLException ex) {
            Logger.getLogger(modelopersonal.class.getName()).log(Level.SEVERE, null, ex);
        }
        return lista;
    }

}
