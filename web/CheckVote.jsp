<%@page import="QRVoting.SQLconnection"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.Base64" %>
<%

    String qrValue = request.getParameter("qrValue");
    String imageData = request.getParameter("imageData");
    String cid = (String) session.getAttribute("scid");
    String eid = (String) session.getAttribute("eid");
    String uid = session.getAttribute("uid").toString();
    System.out.println(cid);
    System.out.println(qrValue);
    System.out.println(imageData);

    // Convert Data URL to byte array and set as BLOB parameter
    Connection con = SQLconnection.getconnection();
    Statement st = con.createStatement();
    Statement st1 = con.createStatement();
    Statement st2 = con.createStatement();
    try {

        ResultSet rs1 = st1.executeQuery("SELECT * FROM users where  unique_id='" + qrValue + "' AND ustatus='Active' and id='"+uid+"'");
        if (rs1.next()) {
            String uname = (String) session.getAttribute("uname");
            System.out.println(" \n candidate id :" + cid + "\n user id:" + uid);
            
                ResultSet rs = st2.executeQuery("Select * from add_candidate where id ='" + cid + "' ");
                if (rs.next()) {
                    String election_name = rs.getString("election_name");
                    String candidate_name = rs.getString("candidate_name");

                    DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
                    Date date = new Date();
                    String time = dateFormat.format(date);
                    System.out.println("Date and Time : " + time);
                    System.out.println("election_name : " + election_name);
                    System.out.println("candidate_name : " + candidate_name);
                    String insertQuery = "INSERT INTO vote (election_name, cid, candidate_name, uname, uid, time, ustatus,imageData,eid) VALUES (?, ?, ?, ?, ?, ?,?,?,?)";
                    // Create a prepared statement
                    PreparedStatement preparedStatement = con.prepareStatement(insertQuery);

                    // Set the parameters for the prepared statement
                    preparedStatement.setString(1, election_name);
                    preparedStatement.setString(2, cid);
                    preparedStatement.setString(3, candidate_name);
                    preparedStatement.setString(4, uname);
                    preparedStatement.setString(5, uid);
                    preparedStatement.setString(6, time);
                   
                    preparedStatement.setString(7, "1");
                    byte[] imageBytes = Base64.getDecoder().decode(imageData.split(",")[1]);
                    preparedStatement.setBytes(8, imageBytes); 
                    preparedStatement.setString(9, eid);
                    // Execute the prepared statement
                    int i = preparedStatement.executeUpdate();
                    if (i != 0) {
                        response.sendRedirect("Elections.jsp?voted_successfully");
                    }
                    else{
                     response.sendRedirect("Elections.jsp?failed");
                    }
                    } else {
                    response.sendRedirect("Elections.jsp?failed");

                }
        
        
        
        } else {
            response.sendRedirect("Elections.jsp?LogFailed");

        }
        rs1.close();
        con.close();
    } catch (Exception ex) {
        ex.printStackTrace();
    }
%>

