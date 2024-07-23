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

public class modeloproducto {
    private String id;
    private String nombre;
    private String costo; 
    private String precio; 
    private String stock;
    private String stockMinimo;
    private String nombreProveedor;
    private String mensaje;
    private String iva; 
    Statement st;
    ResultSet rs;
    private String proveedor;

    public String getIva() {
        return iva;
    }

    public void setIva(String iva) {
        this.iva = iva;
    }

    public String getProveedor() {
        return proveedor;
    }

    public void setProveedor(String proveedor) {
        this.proveedor = proveedor;
    }

    public String getMensaje() {
        return mensaje;
    }

    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getCosto() {
        return costo;
    }

    public void setCosto(String costo) {
        this.costo = costo;
    }

    public String getPrecio() {
        return precio;
    }

    public void setPrecio(String precio) {
        this.precio = precio;
    }

    public String getStock() {
        return stock;
    }

    public void setStock(String stock) {
        this.stock = stock;
    }

    public String getStockMinimo() {
        return stockMinimo;
    }

    public void setStockMinimo(String stockMinimo) {
        this.stockMinimo = stockMinimo;
    }

    public String getNombreProveedor() {
        return nombreProveedor;
    }

    public void setNombreProveedor(String nombreProveedor) {
        this.nombreProveedor = nombreProveedor;
    }

   



   public void guardarProducto() {
    String sql = "INSERT INTO productos (pro_nombre, pro_costo, pro_precio, pro_stock, pro_minimo, proveedores_idproveedores, iva) "
                + "VALUES ('" + nombre + "', '" + costo + "', '" + precio + "', '" + stock + "', '" + stockMinimo + "', '" + nombreProveedor + "', '" + iva + "')";
    try {
        st = utilidades.conexion.sta(st);
        st.executeUpdate(sql);
        st.close();
        mensaje = "Producto guardado correctamente";
    } catch (SQLException ex) {
        mensaje = "Error al guardar el producto: " + ex.getMessage();
        Logger.getLogger(modeloproducto.class.getName()).log(Level.SEVERE, null, ex);
    }
}


    public List<modeloproducto> listarProductos() {
    ArrayList<modeloproducto> lista = new ArrayList<>();
    String sql = "SELECT p.idproductos, p.pro_nombre, p.pro_costo, p.pro_precio, p.pro_stock, p.pro_minimo, pr.prov_nombre AS nombre_proveedor, p.iva FROM productos p "
                + "INNER JOIN proveedores pr ON p.proveedores_idproveedores = pr.idproveedores order by p.idproductos asc ";

    try {
        st = utilidades.conexion.sta(st);
        rs = st.executeQuery(sql);

        while (rs.next()) {
            modeloproducto producto = new modeloproducto();
            producto.setId(rs.getString("idproductos"));
            producto.setNombre(rs.getString("pro_nombre"));
            producto.setCosto(rs.getString("pro_costo"));
            producto.setPrecio(rs.getString("pro_precio"));
            producto.setStock(rs.getString("pro_stock"));
            producto.setStockMinimo(rs.getString("pro_minimo"));
            producto.setNombreProveedor(rs.getString("nombre_proveedor"));
            producto.setIva(rs.getString("iva"));
            lista.add(producto);
        }
        st.close();
        rs.close();
    } catch (SQLException ex) {
        Logger.getLogger(modeloproducto.class.getName()).log(Level.SEVERE, null, ex);
    }
    return lista;
}


    public String obtenerUltimoCodigo() {
        String ultimoCodigo = "";
        String sql = "SELECT MAX(idproductos) AS ultimo_codigo FROM productos";
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
            Logger.getLogger(modeloproducto.class.getName()).log(Level.SEVERE, null, ex);
        }

        return ultimoCodigo;
    }

    public void eliminarProducto() {
        String sql = "DELETE FROM productos WHERE idproductos = '" + id + "'";
        try {
            st = utilidades.conexion.sta(st);
            st.executeUpdate(sql);
            st.close();
            mensaje = "Producto eliminado correctamente";
        } catch (SQLException ex) {
            mensaje = "Error al eliminar el producto: " + ex.getMessage();
            Logger.getLogger(modeloproducto.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

  public void modificarProducto() {
    String sql = "UPDATE productos SET pro_nombre='" + nombre + "', pro_costo='" + costo + "', pro_precio='" + precio + "', "
                + "pro_stock='" + stock + "', pro_minimo='" + stockMinimo + "', proveedores_idproveedores='" + nombreProveedor + "', iva='" + iva + "' WHERE idproductos='" + id + "'";
    try {
        st = utilidades.conexion.sta(st);
        st.executeUpdate(sql);
        st.close();
        mensaje = "Producto modificado correctamente";
    } catch (SQLException ex) {
        mensaje = "Error al modificar el producto: " + ex.getMessage();
        Logger.getLogger(modeloproducto.class.getName()).log(Level.SEVERE, null, ex);
    }
}

}
