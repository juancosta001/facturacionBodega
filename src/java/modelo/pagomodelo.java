package modelo;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class pagomodelo {
    Statement st;
    ResultSet rs;
    private String codigo, fecha, estado, idproveedores, idapertura;

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

    public String getIdproveedores() {
        return idproveedores;
    }

    public void setIdproveedores(String idproveedores) {
        this.idproveedores = idproveedores;
    }

    public String getIdapertura() {
        return idapertura;
    }

    public void setIdapertura(String idapertura) {
        this.idapertura = idapertura;
    }

    public void guardarpago() {
    String sql = "INSERT INTO pagos(idpagos, pag_fecha, pag_estado, proveedores_idproveedores, aperturas_idaperturas) "
                + "VALUES ('" + codigo + "','" + fecha + "','" + estado + "','" + idproveedores + "','" + idapertura + "')";
    try {
        st = utilidades.conexion.sta(st);
        st.executeUpdate(sql);
        st.close();
    } catch (SQLException ex) {
        Logger.getLogger(pagomodelo.class.getName()).log(Level.SEVERE, null, ex);
    }
}


    public void guardardetalle(String idcompra, String pago, String monto) {
        String sql = "insert into detallepagos(compras_idcompras, pagos_idpagos, monto) "
                + "values('" + idcompra + "','" + pago + "','" + monto + "')";
        try {
            st = utilidades.conexion.sta(st);
            st.executeUpdate(sql);
            st.close();
        } catch (SQLException ex) {
            Logger.getLogger(pagomodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public List<compramodelo> obtenerComprasPendientes(String proveedorId) {
    List<compramodelo> comprasPendientes = new ArrayList<>();
    String sql = "SELECT * FROM compras WHERE idproveedores = '" + proveedorId + "' AND com_estado = 'PENDIENTE'";
    
    System.out.println("SQL Query: " + sql); // Agregamos un log para la consulta SQL
    
    try {
        st = utilidades.conexion.sta(st);
        rs = st.executeQuery(sql);
        while (rs.next()) {
            compramodelo compra = new compramodelo();
            compra.setIdCompra(rs.getString("idcompras"));
            compra.setFecha(rs.getString("com_fecha"));
            compra.setCondicion(rs.getString("com_condicion"));
            
            System.out.println("Compra encontrada - ID: " + compra.getIdCompra()); // Log para la compra encontrada

            // Calcular el monto total a partir del detalle de compras
            String idCompra = rs.getString("idcompras");
            String detalleSql = "SELECT SUM(det_precio * det_cantidad) AS total_monto FROM detalle_compras WHERE idcompras = '" + idCompra + "'";
            
            System.out.println("SQL Detalle: " + detalleSql); // Log para la consulta de detalle
            System.out.println("ID DE LA APERTURA: " + idapertura);
            System.out.println("ID DE LA COMPRA: " + idCompra);// Log para la consulta de detalle
            Statement detalleSt = utilidades.conexion.sta(st);
            ResultSet detalleRs = detalleSt.executeQuery(detalleSql);
            if (detalleRs.next()) {
                compra.setMonto(detalleRs.getString("total_monto"));
                System.out.println("Monto total calculado: " + compra.getMonto()); // Log para el monto calculado
            }
            detalleRs.close();
            detalleSt.close();

            comprasPendientes.add(compra);
        }
        rs.close();
        st.close();
    } catch (SQLException ex) {
        Logger.getLogger(compramodelo.class.getName()).log(Level.SEVERE, null, ex);
        ex.printStackTrace(); // Imprimir stack trace en caso de excepción
    }
    return comprasPendientes;
}


    // Método para listar pagos
    public List<pagomodelo> listarPagos() {
        List<pagomodelo> listaPagos = new ArrayList<>();
        String sql = "SELECT * FROM pagos";
        try {
            st = utilidades.conexion.sta(st);
            rs = st.executeQuery(sql);
            while (rs.next()) {
                pagomodelo pago = new pagomodelo();
                pago.setCodigo(rs.getString("idpagos"));
                pago.setFecha(rs.getString("pag_fecha"));
                pago.setEstado(rs.getString("pag_estado"));
                pago.setIdproveedores(rs.getString("proveedores_idproveedores"));
                pago.setIdapertura(rs.getString("aperturas_idaperturas"));
                listaPagos.add(pago);
            }
            rs.close();
            st.close();
        } catch (SQLException ex) {
            Logger.getLogger(pagomodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listaPagos;
    }

    // Método para eliminar pagos
    public void eliminarPago(String idpago) {
        String sql = "DELETE FROM pagos WHERE idpagos = '" + idpago + "'";
        try {
            st = utilidades.conexion.sta(st);
            st.executeUpdate(sql);
            st.close();
        } catch (SQLException ex) {
            Logger.getLogger(pagomodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public String obtenerProximoNumeroPago() {
        String numeroPago = "";
        String sql = "SELECT MAX(idpagos) AS ultimo_numero FROM pagos";
        try {
            st = utilidades.conexion.sta(st);
            rs = st.executeQuery(sql);
            if (rs.next()) {
                String ultimoNumero = rs.getString("ultimo_numero");
                if (ultimoNumero != null) {
                    int ultimo = Integer.parseInt(ultimoNumero);
                    int siguiente = ultimo + 1;
                    numeroPago = String.valueOf(siguiente);
                } else {
                    numeroPago = "1"; // Si no hay pagos registrados, empezamos desde 1
                }
            }
            rs.close();
            st.close();
        } catch (SQLException ex) {
            Logger.getLogger(pagomodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
        return numeroPago;
    }

    public void actualizarEstadoPago(String idPago, String nuevoEstado) {
        String sql = "UPDATE pagos SET pag_estado = '" + nuevoEstado + "' WHERE idpagos = '" + idPago + "'";
        try {
            st = utilidades.conexion.sta(st);
            st.executeUpdate(sql);
            st.close();
        } catch (SQLException ex) {
            Logger.getLogger(pagomodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void revertirEstadoCompra(String idCompra) {
        String sql = "UPDATE compras SET com_estado = 'PENDIENTE' WHERE idcompras = '" + idCompra + "'";
        try {
            st = utilidades.conexion.sta(st);
            st.executeUpdate(sql);
            st.close();
        } catch (SQLException ex) {
            Logger.getLogger(pagomodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public String obtenerIdCompraAsociada(String idPago) {
        String idCompra = "";
        String sql = "SELECT compras_idcompras FROM detallepagos WHERE pagos_idpagos = '" + idPago + "'";
        try {
            st = utilidades.conexion.sta(st);
            rs = st.executeQuery(sql);
            if (rs.next()) {
                idCompra = rs.getString("compras_idcompras");
            }
            rs.close();
            st.close();
        } catch (SQLException ex) {
            Logger.getLogger(pagomodelo.class.getName()).log(Level.SEVERE, null, ex);
        }
        return idCompra;
    }
}
