<%-- 
    Document   : rptpersonal
    Created on : 24 abr 2024, 1:40:58
    Author     : juana
--%>

<%@page import="net.sf.jasperreports.engine.JasperExportManager"%>
<%@page import="net.sf.jasperreports.engine.JasperFillManager"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="utilidades.conexion"%>
<%@page import="java.sql.Connection"%>
<%@page import="net.sf.jasperreports.engine.JasperPrint"%>
<%@page contentType="application/pdf"%>
<%
    
    String dirPath="/rpt";
    String realPath=this.getServletContext().getRealPath(dirPath);
    String jasperReport="cobros.jasper";
    JasperPrint print=null;
    Connection conn=null;
    
    try{
        conn = utilidades.conexion.Enlace(conn);
        print =JasperFillManager.fillReport(realPath+"//"+jasperReport, null,conn);
        response.setContentType("application/pdf");
        JasperExportManager.exportReportToPdfStream(print, response.getOutputStream());
        response.getOutputStream().flush();
        response.getOutputStream().close();
    }catch(Exception ex){
      //  ex.printStackTrace();
       // System.out.println(ex.getMessage());
    }
    finally{
        if(conn!=null){
            conn.close();
        }
    }
%>