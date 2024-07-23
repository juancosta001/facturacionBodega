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
 * Modelo para manejar operaciones de inventario
 * @autor juana
 */
public class inventariomodelo2 {

    private Statement st;
    private ResultSet rs;
    private String idinventario;
    private String fecha;
    private String estado;
    private String idapertura;

    // Getters y Setters
    public String getIdinventario() {
        return idinventario;
    }

    public void setIdinventario(String idinventario) {
        this.idinventario = idinventario;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getIdapertura() {
        return idapertura;
    }

    public void setIdapertura(String idapertura) {
        this.idapertura = idapertura;
    }

    // Listar inventarios
    public List<inventariomodelo> listarInventarios() {
        ArrayList<inventariomodelo> lista = new ArrayList<>();
        String sql = "SELECT * FROM inventario";

        try {
            st = utilidades.conexion.sta(st);
            rs = st.executeQuery(sql);
            while (rs.next()) {
                inventariomodelo modelo = new inventariomodelo();
                modelo.setIdInventario(rs.getString("idinventario"));
                modelo.setFecha(rs.getString("inv_fecha"));
                modelo.setEstado(rs.getString("inv_estado"));
                modelo.setIdAperturas(rs.getString("aperturas_idaperturas"));
                lista.add(modelo);
            }
            st.close();
            rs.close();
        } catch (SQLException ex) {
            Logger.getLogger(inventariomodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
        return lista;
    }

    // Guardar inventario
    public void guardarInventario() {
        String sql = "INSERT INTO inventario(idinventario, inv_fecha, inv_estado, aperturas_idaperturas)"
                + "values('" + idinventario + "', '" + fecha + "', '" + estado + "', '" + idapertura + "')";
        try {
            st = utilidades.conexion.sta(st);
            st.executeUpdate(sql);
            st.close();
        } catch (SQLException ex) {
            Logger.getLogger(inventariomodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // Guardar detalle de inventario
    public void guardarDetalleInventario(String id, String idpro, String tipoMovimiento, String cantidad) {
        String sql = "INSERT INTO detalle_inventario(inventario_idinventario, productos_idproductos, tipo_movimiento, cantidad)"
                + "values('" + id + "', '" + idpro + "', '" + tipoMovimiento + "', '" + cantidad + "')";
        try {
            st = utilidades.conexion.sta(st);
            st.executeUpdate(sql);
            st.close();
        } catch (SQLException ex) {
            Logger.getLogger(inventariomodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // Obtener el último número de inventario
    public String obtenerUltimoNumeroInventario() {
        String sql = "SELECT MAX(idinventario) as ultimoNumero FROM inventario";
        String ultimoNumero = "0";
        try {
            st = utilidades.conexion.sta(st);
            rs = st.executeQuery(sql);
            if (rs.next()) {
                ultimoNumero = rs.getString("ultimoNumero");
                if (ultimoNumero == null) {
                    ultimoNumero = "0";
                }
            }
            st.close();
            rs.close();
        } catch (SQLException ex) {
            Logger.getLogger(inventariomodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ultimoNumero;
    }

    // Obtener total del inventario (opcional, dependiendo de la lógica de negocios)
    public String obtenerTotalInventario(String inventario) {
        String sql = "SELECT SUM(Cantidad) as suma FROM detalle_inventario "
                + "WHERE inventario_idinventario='" + inventario + "'";
        String aux = "";
        try {
            st = utilidades.conexion.sta(st);
            rs = st.executeQuery(sql);
            rs.next();
            aux = rs.getString("suma");
        } catch (SQLException ex) {
            Logger.getLogger(inventariomodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
        return aux;
    }
}
