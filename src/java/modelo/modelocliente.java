/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

import java.sql.Connection;
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
public class modelocliente {

    private String codigo;
    private String nombre;
    private String apellido;
    private String ruc;
    private String telefono;
    private String ciudad;
    private String mensaje;
    private Statement st;
    private ResultSet rs;

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

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
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

    public String getCiudad() {
        return ciudad;
    }

    public void setCiudad(String ciudad) {
        this.ciudad = ciudad;
    }

    public String getMensaje() {
        return mensaje;
    }

    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }

    public String getNombreCiudad() {
        return ciudad;
    }

    public void guardarCliente() {
        String sql = "INSERT INTO clientes(cli_nombre, cli_apellido, cli_ruc, cli_telefono, idciudades) "
                + "VALUES('" + nombre + "','" + apellido + "','" + ruc + "','" + telefono + "','" + ciudad + "')";
        try {
            st = utilidades.conexion.sta(st);
            st.executeUpdate(sql);
            st.close();
            mensaje = "Cliente guardado correctamente";
        } catch (SQLException ex) {
            mensaje = "Error al guardar el cliente: " + ex.getMessage();
            Logger.getLogger(modelocliente.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public List<modelocliente> listarClientes() {
        ArrayList<modelocliente> lista = new ArrayList<>();
        String sql = "SELECT c.idclientes, c.cli_nombre, c.cli_apellido, c.cli_ruc, c.cli_telefono, p.ciu_nombre "
                + "FROM clientes c INNER JOIN ciudades p ON c.idciudades = p.idciudades";

        try {
            st = utilidades.conexion.sta(st);
            rs = st.executeQuery(sql);

            while (rs.next()) {
                modelocliente cliente = new modelocliente();
                cliente.setCodigo(rs.getString("idclientes"));
                cliente.setNombre(rs.getString("cli_nombre"));
                cliente.setApellido(rs.getString("cli_apellido"));
                cliente.setRuc(rs.getString("cli_ruc"));
                cliente.setTelefono(rs.getString("cli_telefono"));
                cliente.setCiudad(rs.getString("ciu_nombre"));
                lista.add(cliente);
            }
            st.close();
            rs.close();
        } catch (SQLException ex) {
            Logger.getLogger(modelocliente.class.getName()).log(Level.SEVERE, null, ex);
        }
        return lista;
    }

    public void eliminarCliente() {
        String sql = "DELETE FROM clientes WHERE idclientes = '" + codigo + "'";
        try {
            st = utilidades.conexion.sta(st);
            st.executeUpdate(sql);
            st.close();
            mensaje = "Cliente eliminado correctamente";
        } catch (SQLException ex) {
            mensaje = "Error al eliminar el cliente: " + ex.getMessage();
            Logger.getLogger(modelocliente.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public List<modelocliente> listarClientesPorId(String id) {
        ArrayList<modelocliente> lista = new ArrayList<>();
        String sql = "SELECT c.idclientes, c.cli_nombre, c.cli_apellido, c.cli_ruc, c.cli_telefono, ciu.ciu_nombre "
                + "FROM clientes c INNER JOIN ciudades ciu ON c.idciudades = ciu.idciudades "
                + "WHERE c.idclientes = '" + id + "'";
        try {
            st = utilidades.conexion.sta(st);
            rs = st.executeQuery(sql);

            while (rs.next()) {
                modelocliente cliente = new modelocliente();
                cliente.setCodigo(rs.getString("idclientes"));
                cliente.setNombre(rs.getString("cli_nombre"));
                cliente.setApellido(rs.getString("cli_apellido"));
                cliente.setRuc(rs.getString("cli_ruc"));
                cliente.setTelefono(rs.getString("cli_telefono"));
                cliente.setCiudad(rs.getString("ciu_nombre"));
                lista.add(cliente);
            }
            st.close();
            rs.close();
        } catch (SQLException ex) {
            Logger.getLogger(modelocliente.class.getName()).log(Level.SEVERE, null, ex);
        }
        return lista;
    }

    public void modificarCliente() {
        String sql = "UPDATE clientes SET cli_nombre='" + nombre + "', cli_apellido='" + apellido + "', cli_ruc='" + ruc + "', cli_telefono='" + telefono + "', idciudades='" + ciudad + "' WHERE idclientes='" + codigo + "'";
        try {
            st = utilidades.conexion.sta(st);
            st.executeUpdate(sql);
            st.close();
            mensaje = "Cliente modificado correctamente";
        } catch (SQLException ex) {
            mensaje = "Error al modificar el cliente: " + ex.getMessage();
            Logger.getLogger(modelocliente.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public String obtenerUltimoCodigo() {
        String ultimoCodigo = "";
        String sql = "SELECT MAX(idclientes) AS ultimo_codigo FROM clientes";
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
            Logger.getLogger(modelocliente.class.getName()).log(Level.SEVERE, null, ex);
        }

        return ultimoCodigo;
    }

    public List<modelocliente> listarciudades() {
        ArrayList<modelocliente> lista = new ArrayList<>();
        String sql = "select * from ciudades";

        try {
            st = utilidades.conexion.sta(st);
            rs = st.executeQuery(sql);

            while (rs.next()) {
                modelocliente ciudad = new modelocliente();
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

    public List<modelocliente> listarClientesConFacturasPendientes() {
        List<modelocliente> lista = new ArrayList<>();
        String sql = "SELECT c.idclientes, c.cli_nombre, c.cli_apellido, c.cli_ruc, c.cli_telefono, ciu.ciu_nombre FROM clientes c "
                + "INNER JOIN ventas v ON c.idclientes = v.idclientes "
                + "INNER JOIN ciudades ciu ON c.idciudades = ciu.idciudades "
                + "WHERE v.ven_condicion = 'credito' AND v.ven_estado = 'PENDIENTE'";
        try {
            st = utilidades.conexion.sta(st);
            rs = st.executeQuery(sql);
            while (rs.next()) {
                modelocliente cliente = new modelocliente();
                cliente.setCodigo(rs.getString("idclientes"));
                cliente.setNombre(rs.getString("cli_nombre"));
                cliente.setApellido(rs.getString("cli_apellido"));
                cliente.setRuc(rs.getString("cli_ruc"));
                cliente.setTelefono(rs.getString("cli_telefono"));
                cliente.setCiudad(rs.getString("ciu_nombre"));
                lista.add(cliente);
            }
            rs.close();
            st.close();
        } catch (SQLException ex) {
            Logger.getLogger(modelocliente.class.getName()).log(Level.SEVERE, null, ex);
        }
        return lista;
    }

}
