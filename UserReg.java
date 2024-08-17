/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package QRVoting;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author NARESH
 */
@MultipartConfig(maxFileSize = 500 * 1024) // Max file size for voter ID image (500 KB)
public class UserReg extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String name = request.getParameter("name");
            String dob = request.getParameter("dob");
            String gender = request.getParameter("gender");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String aadhaar = request.getParameter("Aadhaar");
            String password = request.getParameter("pass");
            InputStream voterIdInputStream = null;
            Part filePart = request.getPart("voterid");

            if (filePart != null) {
                // Get the input stream of the uploaded file
                voterIdInputStream = filePart.getInputStream();
            }

            Connection conn = SQLconnection.getconnection();
            Statement st1 = conn.createStatement();
            ResultSet rs = st1.executeQuery("select * from users where email='" + email + "'");
            int count = 0;
            while (rs.next()) {

                count++;
            }
            if (count > 0) {
                response.sendRedirect("Users.jsp?mailid");
            } else {

                try {

                    // Insert user data into the database
                    String sql = "INSERT INTO users (name, dob, gender, email, phone, address, aadhaar, voterid, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    PreparedStatement statement = conn.prepareStatement(sql);
                    statement.setString(1, name);
                    statement.setDate(2, java.sql.Date.valueOf(dob));
                    statement.setString(3, gender);
                    statement.setString(4, email);
                    statement.setString(5, phone);
                    statement.setString(6, address);
                    statement.setString(7, aadhaar);

                    if (voterIdInputStream != null) {
                        statement.setBlob(8, voterIdInputStream);
                    } else {
                        statement.setNull(8, java.sql.Types.BLOB);
                    }

                    statement.setString(9, password);

                    int rowsInserted = statement.executeUpdate();

                    if (rowsInserted > 0) {
                       response.sendRedirect("Users.jsp?Success");
                    } else {
                        response.sendRedirect("Users.jsp?Failed");
                    }
                } catch (SQLException e) {
                     System.out.println( e.getMessage());
                } finally {
                    if (conn != null) {
                        try {
                            conn.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserReg.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

        // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
        /**
         * Handles the HTTP <code>GET</code> method.
         *
         * @param request servlet request
         * @param response servlet response
         * @throws ServletException if a servlet-specific error occurs
         * @throws IOException if an I/O error occurs
         */
        @Override
        protected void doGet
        (HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            processRequest(request, response);
        }

        /**
         * Handles the HTTP <code>POST</code> method.
         *
         * @param request servlet request
         * @param response servlet response
         * @throws ServletException if a servlet-specific error occurs
         * @throws IOException if an I/O error occurs
         */
        @Override
        protected void doPost
        (HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            processRequest(request, response);
        }

        /**
         * Returns a short description of the servlet.
         *
         * @return a String containing servlet description
         */
        @Override
        public String getServletInfo
        
            () {
        return "Short description";
        }// </editor-fold>

    }
