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
public class modelopersonal {
    private String codigo;
    private String nombre;
    private String apellido;
    private String ci;
    private String telefono;
    private String mensaje;
    Statement st;
    ResultSet rs;

    public String getMensaje() {
        return mensaje;
    }

    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }

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

    public String getCi() {
        return ci;
    }

    public void setCi(String ci) {
        this.ci = ci;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }
    public void guardarpersonal(){
        String sql = "insert into personales(per_nombre,per_apellido,per_ci,per_telefono) "
                + "values('"+ nombre +"','"+ apellido +"','" +ci + "', '"+telefono + "')";
        try {
            st = utilidades.conexion.sta(st);
            st.executeUpdate(sql);
            st.close();
            mensaje="GUARDADO";
        } catch (SQLException ex) {
            Logger.getLogger(modelopersonal.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public List listarpersonal(){
        ArrayList<modelopersonal> lista = new ArrayList<>();
        String sql = "select * from personales order by idpersonales asc";
        
        try {
            st = utilidades.conexion.sta(st);
             rs =st.executeQuery(sql);
            
            while(rs.next()){
                modelopersonal modelo = new modelopersonal();
                modelo.setCodigo(rs.getString("idpersonales"));
                modelo.setNombre(rs.getString("per_nombre"));
                modelo.setApellido(rs.getString("per_apellido"));
                modelo.setCi(rs.getString("per_ci"));
                modelo.setTelefono(rs.getString("per_telefono"));
                lista.add(modelo);
            }
            st.close();
            rs.close();
        } catch (SQLException ex) {
            Logger.getLogger(modelopersonal.class.getName()).log(Level.SEVERE, null, ex);
        }
        return lista;
    }
    
    
    public void modificarpersonal(){
    String sql = "update personales set per_nombre='"+nombre+"',per_apellido='"+apellido+"', per_ci='"+ ci +"',per_telefono='"+ telefono +"' where idpersonales ='" + codigo +"'" ;
        try {
            st = utilidades.conexion.sta(st);
           st.executeUpdate(sql);
             st.close(); 
             mensaje="Modificado";
        } catch (SQLException ex) {
            Logger.getLogger(modelopersonal.class.getName()).log(Level.SEVERE, null, ex);
        }
}
    public void eliminarpersonal(){
        String sql = "delete from personales where idpersonales ='" + codigo +"'";
        try {
             st = utilidades.conexion.sta(st);
             st.executeUpdate(sql);
             st.close(); 
        } catch (SQLException ex) {
            Logger.getLogger(modelopersonal.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    public List listarid(String id){
        ArrayList <modelopersonal> list = new ArrayList<>();
        String sql = "select idpersonales,per_nombre,per_apellido,per_ci,per_telefono from personales where idpersonales ='" + id +"'";
        
        try {
            st = utilidades.conexion.sta(st);
            rs = st.executeQuery(sql);
          while(rs.next()){
                modelopersonal modelo = new modelopersonal();
                modelo.setCodigo(rs.getString("idpersonales"));
                modelo.setNombre(rs.getString("per_nombre"));
                modelo.setApellido(rs.getString("per_apellido"));
                modelo.setCi(rs.getString("per_ci"));
                modelo.setTelefono(rs.getString("per_telefono"));
                list.add(modelo);
            }
            st.close(); 
            rs.close();
           } catch (SQLException ex) {
               Logger.getLogger(modelopersonal.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public String obtenerUltimoCodigo() {
    String ultimoCodigo = "";
    String sql = "SELECT MAX(idpersonales) AS ultimo_codigo FROM personales";
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
        Logger.getLogger(modelopersonal.class.getName()).log(Level.SEVERE, null, ex);
    }
    
    return ultimoCodigo;
}


}
