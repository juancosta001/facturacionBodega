package utilidades;
 import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
   
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author ALUMNOS
 */
public class conexion {
    static Connection conn = null;
    static Statement st = null;
    static String bd = "programacionv_ja";
    static String usuario = "root";
    static String clave = "";
    static String url = "jdbc:mysql://localhost:3306/" +bd;
    public static Connection Enlace(Connection conn) throws SQLException{
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, usuario, clave);
            System.out.print("Conexion Exitosa");
        } catch(Exception e){
            System.out.print("Error, clase no encontrada" + e);
        }
       return conn;
    }
    
    public static Statement sta(Statement st) throws SQLException{
        conn = Enlace(conn);
        st = conn.createStatement();
        return st;
    }
}
