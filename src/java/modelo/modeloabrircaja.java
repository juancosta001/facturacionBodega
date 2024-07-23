/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ALUMNOS
 */
public class modeloabrircaja {

    private String id;
    private String fecha1;
    private String monto1;
    private String fechac;
    private String montoc;
    private String idusuario;
    Statement st;
    ResultSet rs;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getFecha1() {
        return fecha1;
    }

    public void setFecha1(String fecha1) {
        this.fecha1 = fecha1;
    }

    public String getMonto1() {
        return monto1;
    }

    public void setMonto1(String monto1) {
        this.monto1 = monto1;
    }

    public String getFechac() {
        return fechac;
    }

    public void setFechac(String fechac) {
        this.fechac = fechac;
    }

    public String getMontoc() {
        return montoc;
    }

    public void setMontoc(String montoc) {
        this.montoc = montoc;
    }

    public String getIdusuario() {
        return idusuario;
    }

    public void setIdusuario(String idusuario) {
        this.idusuario = idusuario;
    }

    public void abrircaja() {
        String sql = "INSERT INTO aperturas(ape_fecha,ape_monto,ape_estado,idusuarios)"
                + "VALUES('" + fecha1 + "','" + monto1 + "','ABIERTA','" + idusuario + "')";
        try {
            st = utilidades.conexion.sta(st);
            st.executeUpdate(sql);
            st.close();
        } catch (SQLException ex) {
            Logger.getLogger(modeloabrircaja.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public String validarCaja() {
        String sql = "SELECT * FROM aperturas "
                + "where idusuarios= '" + idusuario + "' AND ape_estado='ABIERTA'";

        String mensaje = "";
        try {
            st = utilidades.conexion.sta(st);
            System.out.println("SQL: " + sql);
            rs = st.executeQuery(sql);
            rs.next();
            if (rs.getRow() == 0) {
                mensaje = "CERRADA";
            } else {
                mensaje = "ABIERTA";
            }
            st.close();
            rs.close();
        } catch (SQLException ex) {
            Logger.getLogger(modeloabrircaja.class.getName()).log(Level.SEVERE, null, ex);
        }
        return mensaje;
    }

    public String obtenerultimapertura() {
        String sql = "SELECT * FROM aperturas "
                + "WHERE idusuarios= '" + idusuario + "' AND ape_estado='ABIERTA'";
        String cod = "";
        try {
            st = utilidades.conexion.sta(st);
            rs = st.executeQuery(sql);
            rs.next();
            cod = rs.getString("idaperturas");
        } catch (SQLException ex) {
            Logger.getLogger(modeloabrircaja.class.getName()).log(Level.SEVERE, null, ex);
        }
        return cod;
    }

    public void cerrarcaja() {
        String sql = "INSERT INTO cierres(cie_fecha, cie_monto, idaperturas) "
                + "VALUES('" + fechac + "', '" + montoc + "', '" + obtenerultimapertura() + "')";
        try {
            st = utilidades.conexion.sta(st);
            st.executeUpdate(sql);
            st.close();
        } catch (SQLException ex) {
            Logger.getLogger(modeloabrircaja.class.getName()).log(Level.SEVERE, null, ex);
        }
       

        sql = "UPDATE aperturas SET ape_estado='CERRADA' WHERE idaperturas='" + obtenerultimapertura() + "'";
        try {
            st = utilidades.conexion.sta(st);
            st.executeUpdate(sql);
            st.close();
        } catch (SQLException ex) {
            Logger.getLogger(modeloabrircaja.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
