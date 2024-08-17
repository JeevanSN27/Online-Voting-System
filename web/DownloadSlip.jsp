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
    </head>
    <style>
        .id-card-holder {
            width: 400px;
            padding: 4px;
            margin: 0 auto;
            background-color: #00802f;
            border-radius: 5px;
            position: relative;
        }

        .id-card {
            background-color: #fff;
            padding: 10px;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0 0 1.5px 0px #00802f;
        }
        .id-card img {
            margin: 0 auto;
        }
        .header img {
            width: 100px;
            margin-top: 15px;
        }
        .photo img {
            width: 90px;
            margin-top: 15px;
        }
        h2 {
            font-size: 15px;
            margin: 5px 0;
        }
        h3 {
            font-size: 12px;
            margin: 2.5px 0;
            font-weight: 300;
        }
        .qr-code img {
            width: 250px;
        }
        .id-card-hook {
            background-color: #000;
            width: 70px;
            margin: 0 auto;
            height: 15px;
            border-radius: 5px 5px 0 0;
        }
        .id-card-hook:after {
            content: '';
            background-color: #d7d6d3;
            width: 47px;
            height: 6px;
            display: block;
            margin: 0px auto;
            position: relative;
            top: 6px;
            border-radius: 4px;
        }
        .id-card-tag-strip {
            width: 45px;
            height: 40px;
            background-color: #00802f;
            margin: 0 auto;
            border-radius: 5px;
            position: relative;
            top: 9px;
            z-index: 1;
            border: 1px solid #0041ad;
        }
        .id-card-tag-strip:after {
            content: '';
            display: block;
            width: 100%;
            height: 1px;
            background-color: #c1c1c1;
            position: relative;
            top: 10px;
        }
        .id-card-tag {
            width: 0;
            height: 0;
            border-left: 100px solid transparent;
            border-right: 100px solid transparent;
            border-top: 100px solid #00802f;
            margin: -10px auto -30px auto;
        }
        .id-card-tag:after {
            content: '';
            display: block;
            width: 0;
            height: 0;
            border-left: 50px solid transparent;
            border-right: 50px solid transparent;
            border-top: 100px solid #00802f;
            margin: -10px auto -30px auto;
            position: relative;
            top: -130px;
            left: -50px;
        }
    </style>
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
                        <a href="DownloadSlip.jsp" class="nav-item nav-link active">Download Vote Slip</a>
                        <a href="Elections.jsp" class="nav-item nav-link">Elections</a>
                        <a href="Vresults.jsp" class="nav-item nav-link">View Results</a>
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

        <%
            String uid = session.getAttribute("uid").toString();
            Connection con = SQLconnection.getconnection();
            Statement st = con.createStatement();

            ResultSet rs = st.executeQuery("SELECT * FROM users WHERE id = '" + uid + "'  ");
            rs.next();
        %>
        <!-- Contact Start -->
        <div class="container-fluid py-6 px-5">
            <div class="text-center mx-auto mb-5" style="max-width: 600px;">
                <h1 class="display-5 text-uppercase mb-4"><span class="text-primary">Voting Slip</span></h1>
            </div>
            <div class="row gx-0 align-items-center">
                <center><div class="col-lg-6">
                        <div class="id-card-holder" id="content">
                            <div class="id-card">
                                <div class="header">
                                    <h2>Voting Slip</h2>
                                </div>
                                <h1><%=rs.getString("name")%></h1>
                                <h2>Voter ID: <%=rs.getString("id")%></h2>
                                <div class="qr-code">
                                    <img src="qrpic.jsp?uid=<%=uid%>">
                                </div>
                                <hr>

                            </div>
                        </div>
                        <br><br>
                        <center><button class="btn btn-primary text-center"  id="downloadBtn" >Download</button></center>
                    </div></center>
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
        <script src="js/html2canvas.hertzen.com_dist_html2canvas.min.js"></script>
        <script>
        const contentDiv = document.getElementById('content');
        const downloadBtn = document.getElementById('downloadBtn');

        downloadBtn.addEventListener('click', () => {
            html2canvas(contentDiv, {
                scale: 2, // Scale for higher resolution
            }).then(canvas => {
                const dataUrl = canvas.toDataURL('image/jpeg', 0.8);

                const downloadLink = document.createElement('a');
                downloadLink.href = dataUrl;
                downloadLink.download = 'Voting.png';
                downloadLink.click();
            });
        });

        </script>
        <!-- Template Javascript -->
        <script src="js/main.js"></script>
    </body>

</html>
