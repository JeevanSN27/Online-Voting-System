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
    <%
        if (request.getParameter("Activated") != null) {%>
    <script>alert('Voter Id Added');</script>  
    <%}
    %>
    <%
        if (request.getParameter("Rejected") != null) {%>
    <script>alert('Rejected');</script>  
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
                        <a href="Admin_Home.jsp" class="nav-item nav-link ">Home</a>
                        <a href="Add_election.jsp" class="nav-item nav-link">Add Election</a>
                        <a href="Add_candidate.jsp" class="nav-item nav-link">Add Candidate</a>
                        <a href="View_results.jsp" class="nav-item nav-link">View Results</a>
                        <a href="View_voters.jsp" class="nav-item nav-link  active">View Voters</a>
                         <a href="Check_vote.jsp" class="nav-item nav-link">Check Vote</a>
                        <a href="logout.jsp" class="nav-item nav-link btn btn-danger">Logout</a>
                    </div>
                </div>
            </nav>
        </div>
        <!-- Navbar End -->
        <div class="container-fluid page-header">
        </div>

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
        <!-- Page Header Start -->
        <div class="container-fluid page-header">
        </div>

        <!-- Contact Start -->
        <div class="container-fluid py-6 px-5">
            <div class="text-center mx-auto mb-5" style="max-width: 600px;">
                <h1 class="display-5 text-uppercase mb-4"><span class="text-primary">Voters</span></h1>
            </div>
            <center><div class="row gx-0 align-items-center">
                <table id="naresh">
                                            <tr>
                                                <th>User ID </th>
                                                <th>Voter ID </th>
                                                <th>Voter ID No</th>
                                                <th>Name </th>
                                                <th>Email </th>
                                                <th>DOB</th>
                                                <th>Address</th>
                                                <th>Phone No</th>
                                                <th>Status</th>
                                                <th>Action</th>
                                            </tr>
                                            <%
                                                Connection con = SQLconnection.getconnection();
                                                Statement st = con.createStatement();
                                                try {
                                                    ResultSet rs = st.executeQuery("SELECT * FROM users");
                                                    while (rs.next()) {
                                            %>
                                            <tr>
                                                <td><%=rs.getString("id")%></td>
                                                <td><img src="userpic.jsp?uid=<%=rs.getString("id")%>" width="100"></td>
                                                <td><%=rs.getString("aadhaar")%></td>
                                                <td><%=rs.getString("name")%></td>
                                                <td><%=rs.getString("email")%></td>
                                                <td><%=rs.getString("dob")%> </td>
                                                <td><%=rs.getString("address")%> </td>
                                                <td><%=rs.getString("phone")%> </td>
                                               <td><%=rs.getString("ustatus")%> </td>
                                                <td ><a href="UserApprove?uid=<%=rs.getString("id")%>&email=<%=rs.getString("email")%>"  class="btn btn-success" style="color: white">Approve</a>&nbsp;
                                                    <a href="UserReject?uid=<%=rs.getString("id")%>"   class="btn btn-danger" style="color: white">&nbsp;Reject</a></td>
                                            </form>
                                            </tr>
                                            <%                                        }
                                                } catch (Exception ex) {
                                                    ex.printStackTrace();
                                                }


                                            %>
                                        </table>
                                <!-- End Contact Content -->
                </div></center>
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