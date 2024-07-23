package modelo;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class compramodelo {

    private Statement st;
    private ResultSet rs;
    private String idCompra;
    private String fecha;
    private String condicion;
    private String estado;
    private String idUsuarios;
    private String idApertura;
    private String proveedor;
    private String monto;

    public String getMonto() {
        return monto;
    }

    public void setMonto(String monto) {
        this.monto = monto;
    }

    public String getIdCompra() {
        return idCompra;
    }

    public void setIdCompra(String idCompra) {
        this.idCompra = idCompra;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getCondicion() {
        return condicion;
    }

    public void setCondicion(String condicion) {
        this.condicion = condicion;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getIdUsuarios() {
        return idUsuarios;
    }

    public void setIdUsuarios(String idUsuarios) {
        this.idUsuarios = idUsuarios;
    }

    public String getIdApertura() {
        return idApertura;
    }

    public void setIdApertura(String idApertura) {
        this.idApertura = idApertura;
    }

    public String getProveedor() {
        return proveedor;
    }

    public void setProveedor(String proveedor) {
        this.proveedor = proveedor;
    }

    public List<compramodelo> listarCompras() {
        ArrayList<compramodelo> lista = new ArrayList<>();
        String sql = "SELECT c.idcompras, c.com_fecha, c.com_condicion, c.com_estado, p.prov_nombre, c.aperturas_idaperturas, u.usu_nombre "
                + "FROM compras c "
                + "JOIN proveedores p ON c.idproveedores = p.idproveedores "
                + "JOIN usuarios u ON c.idusuarios = u.idusuarios";
        try {
            st = utilidades.conexion.sta(st);
            rs = st.executeQuery(sql);
            while (rs.next()) {
                compramodelo modelo = new compramodelo();
                modelo.setIdCompra(rs.getString(1));
                modelo.setFecha(rs.getString(2));
                modelo.setCondicion(rs.getString(3));
                modelo.setEstado(rs.getString(4));
                modelo.setProveedor(rs.getString(5));
                modelo.setIdApertura(rs.getString(6));
                modelo.setIdUsuarios(rs.getString(7));
                lista.add(modelo);
            }
            st.close();
            rs.close();
        } catch (SQLException ex) {
            Logger.getLogger(compramodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
        return lista;
    }

    public void guardarCompra() {
        String sql = "INSERT INTO compras(idcompras, com_fecha, com_condicion, com_estado, idusuarios, idproveedores, aperturas_idaperturas) "
                + "VALUES ('" + idCompra + "', '" + fecha + "', '" + condicion + "', '" + estado + "', '" + idUsuarios + "', '" + proveedor + "', '" + idApertura + "')";
        try {
            st = utilidades.conexion.sta(st);
            st.executeUpdate(sql);
            st.close();
        } catch (SQLException ex) {
            Logger.getLogger(compramodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void guardarDetalle(String id, String idpro, String can, String pre) {
        String sql = "INSERT INTO detalle_compras(idcompras, idproductos, det_precio, det_cantidad) "
                + "VALUES ('" + id + "', '" + idpro + "', '" + pre + "', '" + can + "')";
        try {
            st = utilidades.conexion.sta(st);
            st.executeUpdate(sql);
            st.close();
        } catch (SQLException ex) {
            Logger.getLogger(compramodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public String obtenerTotal(String compra) {
        String sql = "select sum(det_cantidad*det_precio) as suma from detallecompras where idcompras='" + compra + "'";
        String aux = "";
        try {
            st = utilidades.conexion.sta(st);
            rs = st.executeQuery(sql);
            rs.next();
            aux = rs.getString("suma");
        } catch (SQLException ex) {
            Logger.getLogger(compramodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
        return aux;
    }

    public String obtenerUltimoNumeroCompra() {
        String sql = "SELECT MAX(idcompras) as ultimoNumero FROM compras";
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
            Logger.getLogger(compramodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ultimoNumero;
    }

    public List<compramodelo> listarComprasPendientes() {
        ArrayList<compramodelo> lista = new ArrayList<>();
        String sql = "SELECT c.idcompras, c.com_fecha, c.com_condicion, dc.monto "
                + "FROM compras c "
                + "INNER JOIN detallepagos dc ON c.idcompras = dc.idcompra "
                + "WHERE c.estado = 'pendiente'";
        try (Connection conn = utilidades.conexion.Enlace(null); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                compramodelo compra = new compramodelo();
                compra.setIdCompra(rs.getString("idcompras"));
                compra.setFecha(rs.getString("com_fecha"));
                compra.setCondicion(rs.getString("com_condicion"));
                compra.setMonto(rs.getString("monto")); // Asegúrate que este método setter esté definido en compramodelo
                lista.add(compra);
            }
        } catch (SQLException ex) {
            Logger.getLogger(compramodelo.class.getName()).log(Level.SEVERE, null, ex);
        }

        return lista;
    }

    public void actualizarEstadoCobro(String idCobro, String nuevoEstado) {
        String sql = "UPDATE cobros SET cob_estado = '" + nuevoEstado + "' WHERE idcobros = '" + idCobro + "'";
        try {
            st = utilidades.conexion.sta(st);
            st.executeUpdate(sql);
            st.close();
        } catch (SQLException ex) {
            Logger.getLogger(cobromodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void revertirEstadoVenta(String idVenta) {
        String sql = "UPDATE ventas SET ven_estado = 'PENDIENTE' WHERE idventas = '" + idVenta + "'";
        try {
            st = utilidades.conexion.sta(st);
            st.executeUpdate(sql);
            st.close();
        } catch (SQLException ex) {
            Logger.getLogger(cobromodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public String obtenerIdVentaAsociada(String idCobro) {
        String idVenta = "";
        String sql = "SELECT idventas FROM detallecobros WHERE cobros_idcobros = '" + idCobro + "'";
        try {
            st = utilidades.conexion.sta(st);
            rs = st.executeQuery(sql);
            if (rs.next()) {
                idVenta = rs.getString("idventas");
            }
            rs.close();
            st.close();
        } catch (SQLException ex) {
            Logger.getLogger(cobromodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
        return idVenta;
    }
}
