<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="QRVoting.SQLconnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <title>QR Based Online Election System</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="Free HTML Templates" name="keywords">
        <meta content="Free HTML Templates" name="description">

        <!-- Favicon -->
        <link href="img/favicon.ico" rel="icon">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Roboto:wght@500;700&display=swap" rel="stylesheet"> 

        <!-- Icon Font Stylesheet -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
        <link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />
        <link href="lib/lightbox/css/lightbox.min.css" rel="stylesheet">

        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/bootstrap.min.css" rel="stylesheet">

        <!-- Template Stylesheet -->
        <link href="css/style.css" rel="stylesheet">
        <link href="css/table.css" rel="stylesheet">
    </head>
    <script>
        var loadFile = function (event) {
            var reader = new FileReader();
            reader.onload = function () {
                var output = document.getElementById('output');
                output.src = reader.result;
            };
            reader.readAsDataURL(event.target.files[0]);
        };
    </script>
    <%
        if (request.getParameter("Election_added") != null) {%>
    <script>alert('Election Added');</script>  
    <%}
    %>
    <body>

        <!-- Navbar Start -->
        <div class="container-fluid sticky-top bg-dark bg-light-radial shadow-sm px-5 pe-lg-0">
            <nav class="navbar navbar-expand-lg bg-dark bg-light-radial navbar-dark py-3 py-lg-0">
                <a href="#" class="navbar-brand">
                    <h1 class="m-0 text-uppercase text-white" style="font-size: 22px"><i class="bi bi-hand-index text-primary me-2"></i>Voting System</h1>
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarCollapse">
                    <div class="navbar-nav ms-auto py-0">
                        <a href="User_Home.jsp" class="nav-item nav-link">Home</a>
                        <a href="DownloadSlip.jsp" class="nav-item nav-link">Download Vote Slip</a>
                        <a href="Elections.jsp" class="nav-item nav-link">Elections</a>
                        <a href="Vresults.jsp" class="nav-item nav-link active">View Results</a>
                        <a href="logout.jsp" class="nav-item nav-link btn btn-danger">Logout</a>
                    </div>
                </div>
            </nav>
        </div>
        <!-- Navbar End -->
        <div class="container-fluid page-header">
        </div>


        <!-- Page Header Start -->
        <div class="container-fluid page-header">
        </div>
        <!-- Page Header Start -->
        <!-- Contact Start -->
        <div class="container-fluid py-6 px-5">
            <div class="text-center mx-auto mb-5" style="max-width: 600px;">
                <h1 class="display-5 text-uppercase mb-4"><span class="text-primary"><h2><%=request.getParameter("election_name")%> ELECTION RESULTS</h2></span></h1>
            </div>
            <div class="row gx-0 align-items-center">
                <center>
    <div class="col-lg-6">
        <div class="contact-form bg-light p-5">
            <div class="row">
                <div class="col-md-12">
                    <%
                        String ename = request.getParameter("election_name");
                        String uid = (String) session.getAttribute("uid");
                        Connection conn = null;
                        Statement st6 = null;
                        ResultSet rt6 = null;

                        try {
                            conn = SQLconnection.getconnection();
                            st6 = conn.createStatement();
                            rt6 = st6.executeQuery("SELECT uid FROM vote WHERE uid = '" + uid + "' AND election_name = '" + ename + "' ");
                            if (!rt6.next()) {
                    %>
                    <div>
                        <br><br>
                        <h3 style="color: red">Your Vote is not registered. Kindly Vote.</h3>
                    </div>
                    <%
                            } else {
                    %>
                    <table id="naresh">
                        <tr>
                            <th>Candidate Profile</th>
                            <th>Candidate Name</th>
                            <th>Party Name</th>
                            <th>Total Votes</th>
                        </tr>
                        <%
                            Map<String, Integer> map = new HashMap<>();
                            int max = Integer.MIN_VALUE;
                            String winnerName = null;
                            List<String> winners = new ArrayList<>();
                            Statement st = null, st1 = null, st2 = null;
                            ResultSet rs = null, rs1 = null, rs2 = null;
                            
                            try {
                                st = conn.createStatement();
                                st1 = conn.createStatement();
                                st2 = conn.createStatement();
                                
                                rs1 = st2.executeQuery("SELECT * FROM add_candidate WHERE election_name = '" + ename + "' ");
                                if (!rs1.next()) {
                                    response.sendRedirect("View_results.jsp?No_candidate_added");
                                } else {
                                    rs = st1.executeQuery("SELECT * FROM add_candidate WHERE election_name = '" + ename + "' ");
                                    while (rs.next()) {
                                        String cid = rs.getString("id");
                                        String cname = rs.getString("candidate_name");

                                        rs2 = st.executeQuery("SELECT count(id) as range_val FROM vote WHERE cid = '" + cid + "'");
                                        if (rs2.next()) {
                                            int val = rs2.getInt("range_val");
                                            map.put(cname, val);

                                            if (val > max) {
                                                max = val;
                                                winnerName = cname;
                                                winners.clear();
                                                winners.add(cname);
                                            } else if (val == max) {
                                                winners.add(cname);
                                            }
                        %>
                        <tr>
                            <td><a href="view_profile1.jsp?cid=<%=rs.getString("id")%>"><img style="border-radius: 50%;" src="Getimage?id=<%=rs.getString("id")%>" width="120" height="120"></a></td>
                            <td><font style="font-family: serif; font-size: 24px; color: black"><%=rs.getString("candidate_name")%></font></td>
                            <td><font style="font-family: serif; font-size: 24px; color: black"><%=rs.getString("party_name")%></font></td>
                            <td><font style="font-family: serif; font-size: 24px; color: black" size="3"><strong><%=rs2.getInt("range_val")%></strong></font></td>
                        </tr>
                        <%
                                        }
                                    }
                                }
                        %>
                    </table>
                    <%
                                if (winners.size() == 1) {
                    %>
                    <div>
                        <br><br><br>
                        <h3><%=ename%> Election Is Won By <%=winnerName.toUpperCase()%></h3>
                    </div>
                    <%
                                } else if (winners.size() > 1) {
                    %>
                    <div>
                        <br><br><br>
                        <h3><%=ename%> Election Result: It's a tie between <%=String.join(", ", winners).toUpperCase()%></h3>
                    </div>
                    <%
                                } else {
                    %>
                    <div>
                        <br><br><br>
                        <h3><%=ename%> Result Pending...</h3>
                    </div>
                    <%
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                if (rs != null) rs.close();
                                if (rs1 != null) rs1.close();
                                if (rs2 != null) rs2.close();
                                if (st != null) st.close();
                                if (st1 != null) st1.close();
                                if (st2 != null) st2.close();
                            }
                        } 
                    } catch (Exception ex) {
                        ex.printStackTrace();
                    } finally {
                        if (rt6 != null) rt6.close();
                        if (st6 != null) st6.close();
                        if (conn != null) conn.close();
                    }
                    %>
                </div>
                <br><br><br>
            </div>
        </div>
    </div>
</center>

            </div>
        </div>
        <!-- Contact End -->


        <!-- Footer Start -->
        <div class="footer container-fluid position-relative bg-dark bg-light-radial text-white-50 px-5">
        </div>
        <div class="container-fluid bg-dark bg-light-radial text-white border-top border-primary px-0">
            <div class="d-flex flex-column flex-md-row justify-content-between">
                <div class="py-4 px-5 text-center text-md-start">
                    <p class="mb-0">&copy; <a class="text-primary" href="#"></a>All Rights Reserved.</p>
                </div>
                <div class="py-4 px-5 bg-primary footer-shape position-relative text-center text-md-end">
                    <p class="mb-0"><a class="text-dark" href="#">QR Voting</a></p>
                </div>
            </div>
        </div>
        <!-- Footer End -->


        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>


        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/waypoints/waypoints.min.js"></script>
        <script src="lib/owlcarousel/owl.carousel.min.js"></script>
        <script src="lib/tempusdominus/js/moment.min.js"></script>
        <script src="lib/tempusdominus/js/moment-timezone.min.js"></script>
        <script src="lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>
        <script src="lib/isotope/isotope.pkgd.min.js"></script>
        <script src="lib/lightbox/js/lightbox.min.js"></script>

        <!-- Template Javascript -->
        <script src="js/main.js"></script>
    </body>

</html>
