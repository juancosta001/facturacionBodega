package modelo;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class cobromodelo {
    Statement st;
    ResultSet rs;
    private String codigo, fecha, estado, idclientes, idapertura;

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
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

    public String getIdclientes() {
        return idclientes;
    }

    public void setIdclientes(String idclientes) {
        this.idclientes = idclientes;
    }

    public String getIdapertura() {
        return idapertura;
    }

    public void setIdapertura(String idapertura) {
        this.idapertura = idapertura;
    }

    public void guardarcobro() {
        String sql = "insert into cobros(idcobros, cob_fecha, cob_estado, clientes_idclientes, aperturas_idaperturas) "
                + "values ('" + codigo + "','" + fecha + "','" + estado + "','" + idclientes + "','" + idapertura + "')";
        try {
            st = utilidades.conexion.sta(st);
            st.executeUpdate(sql);
            st.close();
        } catch (SQLException ex) {
            Logger.getLogger(cobromodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void guardardetalle(String idventa, String cobro, String monto) {
        String sql = "insert into detallecobros(ventas_idventas,cobros_idcobros,monto) "
                + "values('" + idventa + "','" + cobro + "','" + monto + "')";
        try {
            st = utilidades.conexion.sta(st);
            st.executeUpdate(sql);
            st.close();
        } catch (SQLException ex) {
            Logger.getLogger(cobromodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public List<facturaventamodelo> obtenerFacturasPendientes(String clienteId) {
    List<facturaventamodelo> facturasPendientes = new ArrayList<>();
    String sql = "SELECT * FROM ventas WHERE idclientes = '" + clienteId + "' AND ven_estado = 'PENDIENTE'";
    try {
        st = utilidades.conexion.sta(st);
        rs = st.executeQuery(sql);
        while (rs.next()) {
            facturaventamodelo factura = new facturaventamodelo();
            factura.setIdfacturacion(rs.getString("idventas"));
            factura.setEstado(rs.getString("ven_estado"));
            factura.setCondicion(rs.getString("ven_condicion"));
            
            // Calcular el monto total a partir del detalle de ventas
            String idVenta = rs.getString("idventas");
            String detalleSql = "SELECT SUM(det_precio * det_cantidad) AS total_monto FROM detalleventas WHERE idventas = '" + idVenta + "'";
            Statement detalleSt = utilidades.conexion.sta(st);
            ResultSet detalleRs = detalleSt.executeQuery(detalleSql);
            if (detalleRs.next()) {
                factura.setMonto(detalleRs.getString("total_monto"));
            }
            detalleRs.close();
            detalleSt.close();

            facturasPendientes.add(factura);
        }
        rs.close();
        st.close();
    } catch (SQLException ex) {
        Logger.getLogger(facturaventamodelo.class.getName()).log(Level.SEVERE, null, ex);
    }
    return facturasPendientes;
}


    // Método para listar cobros
    public List<cobromodelo> listarCobros() {
        List<cobromodelo> listaCobros = new ArrayList<>();
        String sql = "SELECT * FROM cobros";
        try {
            st = utilidades.conexion.sta(st);
            rs = st.executeQuery(sql);
            while (rs.next()) {
                cobromodelo cobro = new cobromodelo();
                cobro.setCodigo(rs.getString("idcobros"));
                cobro.setFecha(rs.getString("cob_fecha"));
                cobro.setEstado(rs.getString("cob_estado"));
                cobro.setIdclientes(rs.getString("clientes_idclientes"));
                cobro.setIdapertura(rs.getString("aperturas_idaperturas"));
                listaCobros.add(cobro);
            }
            rs.close();
            st.close();
        } catch (SQLException ex) {
            Logger.getLogger(cobromodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listaCobros;
    }

    // Método para eliminar cobros
    public void eliminarCobro(String idcobro) {
        String sql = "DELETE FROM cobros WHERE idcobros = '" + idcobro + "'";
        try {
            st = utilidades.conexion.sta(st);
            st.executeUpdate(sql);
            st.close();
        } catch (SQLException ex) {
            Logger.getLogger(cobromodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

  public String obtenerProximoNumeroFactura() {
    String numeroFactura = "";
    String sql = "SELECT MAX(idcobros) AS ultimo_numero FROM cobros";
    try {
        st = utilidades.conexion.sta(st);
        rs = st.executeQuery(sql);
        if (rs.next()) {
            String ultimoNumero = rs.getString("ultimo_numero");
            if (ultimoNumero != null) {
                int ultimo = Integer.parseInt(ultimoNumero);
                int siguiente = ultimo + 1;
                numeroFactura = String.valueOf(siguiente);
            } else {
                numeroFactura = "1"; // Si no hay cobros registrados, empezamos desde 1
            }
        }
        rs.close();
        st.close();
    } catch (SQLException ex) {
        Logger.getLogger(cobromodelo.class.getName()).log(Level.SEVERE, null, ex);
    }
    return numeroFactura;
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
    String sql = "SELECT ventas_idventas FROM detallecobros WHERE cobros_idcobros = '" + idCobro + "'";
    try {
        st = utilidades.conexion.sta(st);
        rs = st.executeQuery(sql);
        if (rs.next()) {
            idVenta = rs.getString("ventas_idventas");
        }
        rs.close();
        st.close();
    } catch (SQLException ex) {
        Logger.getLogger(cobromodelo.class.getName()).log(Level.SEVERE, null, ex);
    }
    return idVenta;
}

}
