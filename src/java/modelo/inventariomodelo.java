package modelo;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class inventariomodelo {
    private Statement st;
    private ResultSet rs;
    private String idInventario, estado, fecha, idAperturas;

    public String getIdInventario() {
        return idInventario;
    }

    public void setIdInventario(String idInventario) {
        this.idInventario = idInventario;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getIdAperturas() {
        return idAperturas;
    }

    public void setIdAperturas(String idAperturas) {
        this.idAperturas = idAperturas;
    }

    public void guardarInventario() {
        String sql = "INSERT INTO inventario (idinventario, inv_estado, inv_fecha, aperturas_idaperturas) "
                + "VALUES ('" + idInventario + "','" + estado + "', '" + fecha + "', '" + idAperturas + "')";
        try {
            st = utilidades.conexion.sta(st);
            st.executeUpdate(sql);
            st.close();
        } catch (SQLException ex) {
            Logger.getLogger(inventariomodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void guardarDetalleInventario(String idInventario, String idProducto, String tipoMovimientos, int cantidad) {
        String sql = "INSERT INTO detalle_inventario (inventario_idinventario, productos_idproductos, tipo_movimiento, cantidad) "
                + "VALUES ('" + idInventario + "', '" + idProducto + "', '" + tipoMovimientos + "', " + cantidad + ")";
        try {
            st = utilidades.conexion.sta(st);
            st.executeUpdate(sql);
            st.close();
        } catch (SQLException ex) {
            Logger.getLogger(inventariomodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public List<inventariomodelo> listarInventarios() {
        List<inventariomodelo> listaInventarios = new ArrayList<>();
        String sql = "SELECT * FROM inventario";
        try {
            st = utilidades.conexion.sta(st);
            rs = st.executeQuery(sql);
            while (rs.next()) {
                inventariomodelo inventario = new inventariomodelo();
                inventario.setIdInventario(rs.getString("idinventario"));
                inventario.setEstado(rs.getString("inv_estado"));
                inventario.setFecha(rs.getString("inv_fecha"));
                inventario.setIdAperturas(rs.getString("aperturas_idaperturas"));
                listaInventarios.add(inventario);
            }
            rs.close();
            st.close();
        } catch (SQLException ex) {
            Logger.getLogger(inventariomodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listaInventarios;
    }

    public void eliminarInventario(String idInventario) {
        String sql = "DELETE FROM inventario WHERE idinventario = '" + idInventario + "'";
        try {
            st = utilidades.conexion.sta(st);
            st.executeUpdate(sql);
            st.close();
        } catch (SQLException ex) {
            Logger.getLogger(inventariomodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

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
            Logger.getLogger(facturaventamodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ultimoNumero;
    }
}
