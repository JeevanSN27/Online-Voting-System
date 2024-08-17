/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package QRVoting.Elections;

import static QRVoting.QRGEN.QRGen.createQR;
import QRVoting.SQLconnection;
import com.google.zxing.EncodeHintType;
import com.google.zxing.WriterException;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author NARESH
 */
public class UserApprove extends HttpServlet {

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
           String uid = request.getParameter("uid");
            String email = request.getParameter("email");
            String path = "D://QRVoting";
            String pathf = path;
            File newFolder = new File(pathf);

            boolean created = newFolder.mkdirs();

            if (created) {
                System.out.println("Folder was created !");
            } else {
                System.out.println("Unable to create folder");
            }

            Connection conn = SQLconnection.getconnection();
            Statement sto = conn.createStatement();

            try {
                int i = sto.executeUpdate("update users set ustatus='Active' where id='" + uid + "'");
                System.out.println("test print==" + uid);
                if (i != 0) {
                    Random RANDOM = new SecureRandom();
                    int PASSWORD_LENGTH = 10;
                    String letters = "378AIJKLM5CD4NOP126EFGHB9";
                    String uniqueid = "";
                    for (int k = 0; k < PASSWORD_LENGTH; k++) {
                        int index = (int) (RANDOM.nextDouble() * letters.length());
                        uniqueid += letters.substring(index, index + 1);
                    }
                    String uniqueid1 = uniqueid;

                    String pathQR = pathf + "/" + email + ".png";

                    // Encoding charset
                    String charset = "UTF-8";

                    Map<EncodeHintType, ErrorCorrectionLevel> hashMap
                            = new HashMap<EncodeHintType, ErrorCorrectionLevel>();

                    hashMap.put(EncodeHintType.ERROR_CORRECTION,
                            ErrorCorrectionLevel.L);

                    // Create the QR code and save
                    // in the specified folder
                    // as a jpg file
                    createQR(uniqueid1, pathQR, charset, hashMap, 200, 200);
                    System.out.println("QR Code Generated!!! ");
                    String imagePath = pathQR;
                    File file = new File(imagePath);
                    InputStream inputStream = new FileInputStream(file);

                    // Read the image file into a byte array
                    File imageFile = new File(imagePath);
                    byte[] imageData = readImageBytes(imageFile);
                    String updateQuery = "UPDATE users SET image_data = ?,unique_id = ? WHERE id = ?";
                    PreparedStatement preparedStatement = conn.prepareStatement(updateQuery);
                    preparedStatement.setBytes(1, imageData);
                    preparedStatement.setString(2, uniqueid1);
                    preparedStatement.setString(3, uid);
                    preparedStatement.executeUpdate();
                    System.out.println("Image updated in database.");
                    System.out.println("Image saved to database.");
                    response.sendRedirect("View_voters.jsp?Activated");
                } else {
                    System.out.println("failed");
                    response.sendRedirect("View_voters.jsp?Failed");
                }
            } catch (IOException | SQLException ex) {
            } catch (WriterException ex) {
                Logger.getLogger(UserApprove.class.getName()).log(Level.SEVERE, null, ex);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserApprove.class.getName()).log(Level.SEVERE, null, ex);
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private static byte[] readImageBytes(File file) throws IOException {
        FileInputStream fis = new FileInputStream(file);
        byte[] buffer = new byte[(int) file.length()];
        fis.read(buffer);
        fis.close();
        return buffer;
    }
}
