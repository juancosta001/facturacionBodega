/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

/**
 *
 * @author juana
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class modelousuario {
    private String codigo;
    private String nombre;
    private String clave;
    private String tipo;
    private String estado;
    private String personal;
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

    public String getClave() {
        return clave;
    }

    public void setClave(String clave) {
        this.clave = clave;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getPersonal() {
        return personal;
    }

    public void setPersonal(String personal) {
        this.personal = personal;
    }
   public String getNombrePersonal(){
       return personal;
   }
     public void guardarusuario(){
        String sql = "insert into usuarios(usu_nombre,usu_clave,usu_tipo,usu_estado,idpersonales) "
                + "values('"+ nombre +"','"+ clave +"','" +tipo + "', '"+estado + "', '"+ personal +"')";
        try {
            st = utilidades.conexion.sta(st);
            st.executeUpdate(sql);
            st.close();
            mensaje="GUARDADO";
        } catch (SQLException ex) {
            mensaje = "Error al guardar el usuario: " + ex.getMessage();
        Logger.getLogger(modelousuario.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
   public List<modelousuario> listarUsuarios() {
    ArrayList<modelousuario> lista = new ArrayList<>();
    String sql = "SELECT u.idusuarios, u.usu_nombre, u.usu_clave, u.usu_tipo, u.usu_estado, p.per_nombre AS nombre_personal  FROM usuarios u INNER JOIN personales "
            + "p ON u.idpersonales = p.idpersonales";
            
    
    try {
        st = utilidades.conexion.sta(st);
        rs = st.executeQuery(sql);
        
        while(rs.next()){
            modelousuario usuario = new modelousuario();
            usuario.setCodigo(rs.getString("idusuarios"));
            usuario.setNombre(rs.getString("usu_nombre"));
            usuario.setClave(rs.getString("usu_clave"));
            usuario.setTipo(rs.getString("usu_tipo"));
            usuario.setEstado(rs.getString("usu_estado"));
            usuario.setPersonal(rs.getString("nombre_personal"));
            lista.add(usuario);
        }
        st.close();
        rs.close();
    } catch (SQLException ex) {
        Logger.getLogger(modelousuario.class.getName()).log(Level.SEVERE, null, ex);
    }
    return lista;
}

   
    public String obtenerUltimoCodigo() {
    String ultimoCodigo = "";
    String sql = "SELECT MAX(idusuarios) AS ultimo_codigo FROM usuarios";
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
        Logger.getLogger(modelousuario.class.getName()).log(Level.SEVERE, null, ex);
    }
    
    return ultimoCodigo;
}
    public void eliminarusuario(){
    String sql = "delete from usuarios where idusuarios ='" + codigo +"'";
    try {
        st = utilidades.conexion.sta(st);
        st.executeUpdate(sql);
        st.close(); 
        mensaje = "Usuario eliminado correctamente";
    } catch (SQLException ex) {
        mensaje = "Error al eliminar el usuario: " + ex.getMessage();
        Logger.getLogger(modelousuario.class.getName()).log(Level.SEVERE, null, ex);
    }
}
    public void modificarusuario(){
    String sql = "update usuarios set usu_nombre='"+nombre+"', usu_clave='"+clave+"', usu_tipo='"+tipo+"', usu_estado='"+estado+"', idpersonales='"+personal+"' where idusuarios='"+codigo+"'";
    try {
        st = utilidades.conexion.sta(st);
        st.executeUpdate(sql);
        st.close(); 
        mensaje="Usuario modificado correctamente";
    } catch (SQLException ex) {
        mensaje = "Error al modificar el usuario: " + ex.getMessage();
        Logger.getLogger(modelousuario.class.getName()).log(Level.SEVERE, null, ex);
    }
}
}
    
    


