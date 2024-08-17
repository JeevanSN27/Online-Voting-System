<%@page import="java.time.LocalDate"%>
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
    <%
        String cid = request.getParameter("cid");
        String eid = request.getParameter("eid");
        session.setAttribute("scid", cid);
        session.setAttribute("eid", eid);
        System.out.println("eid"+eid);
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
                        <a href="Admin_Home.jsp" class="nav-item nav-link active">Home</a>
                        <a href="DownloadSlip.jsp" class="nav-item nav-link">Download Vote Slip</a>
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
            LocalDate currentDate = LocalDate.now();
        System.out.println("Current Date: " + currentDate);
            Connection con = SQLconnection.getconnection();
            Statement st5 = con.createStatement();
            try {
                ResultSet rs5 = st5.executeQuery("SELECT * FROM add_election WHERE id = '" + eid + "' AND end_date < '"+currentDate+"'");
                if(rs5.next()==true){
                %>
                <br> <br> <br>
    <center><h1 class="display-5 text-uppercase mb-4"><span class="text-primary">Elections Finished</span></h1></center>
     <br> <br> <br> <br> <br> <br> <br> <br>
                <%
                }
else{%>

        <!-- Contact Start -->
        <div class="container-fluid py-6 px-5">
            <div class="text-center mx-auto mb-5" style="max-width: 600px;">
                <h1 class="display-5 text-uppercase mb-4"><span class="text-primary">Elections</span></h1>
            </div>
            <div class="row gx-0 align-items-center">
                <center><div class="col-lg-6">
                        <div class="contact-form bg-light p-5">
                            <video id="preview"></video>  
                            <br>  <br>  <br>
                        </div>
                    </div></center>
            </div>
        </div>
        <%}
            } catch (Exception ex) {
                ex.printStackTrace();
            }

        %>
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
        <script src="js/rawgit.com_schmich_instascan-builds_master_instascan.min.js"></script>
        <script>
        let scanner = new Instascan.Scanner({video: document.getElementById('preview')});

        scanner.addListener('scan', function (content) {
            console.log('Scanned QR Code:', content);
            capturePicture(content);
        });

        Instascan.Camera.getCameras().then(function (cameras) {
            if (cameras.length > 0) {
                console.log('Available Cameras:', cameras);
                scanner.start(cameras[0]);
            } else {
                console.error('No cameras found.');
            }
        });

        function capturePicture(qrValue) {
            let video = document.getElementById('preview');
            let canvas = document.createElement('canvas');
            canvas.width = video.videoWidth;
            canvas.height = video.videoHeight;
            canvas.getContext('2d').drawImage(video, 0, 0, canvas.width, canvas.height);

            let imageDataURL = canvas.toDataURL('image/png');

            // Create a form element
            let form = document.createElement('form');
            form.method = 'POST'; // Use POST method
            form.action = 'CheckVote.jsp'; // Specify the target URL

            // Create hidden input fields for the QR code and image data
            let qrInput = document.createElement('input');
            qrInput.type = 'hidden';
            qrInput.name = 'qrValue';
            qrInput.value = qrValue;

            let imageInput = document.createElement('input');
            imageInput.type = 'hidden';
            imageInput.name = 'imageData';
            imageInput.value = imageDataURL;



            // Append input fields to the form
            form.appendChild(qrInput);
            form.appendChild(imageInput);

            // Append the form to the document body and submit it
            document.body.appendChild(form);
            form.submit();
        }
        </script>
    </body>

</html>
