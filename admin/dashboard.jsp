<%@ page import="java.sql.*" %>

<%
if (session.getAttribute("alogin") == null) {
    response.sendRedirect("../index.jsp");
} else {
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <!--[if IE]>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <![endif]-->
    <title>Online Library Management System | Admin Dash Board</title>
    <!-- BOOTSTRAP CORE STYLE -->
    <link href="assets/css/bootstrap.css" rel="stylesheet" />
    <!-- FONT AWESOME STYLE -->
    <link href="assets/css/font-awesome.css" rel="stylesheet" />
    <!-- CUSTOM STYLE -->
    <link href="assets/css/style.css" rel="stylesheet" />
    <!-- GOOGLE FONT -->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
</head>

<body>
    <!------MENU SECTION START-->
    <jsp:include page="includes/header.jsp" />
    <!-- MENU SECTION END-->

    <div class="content-wrapper">
        <div class="container">
            <div class="row pad-botm">
                <div class="col-md-12">
                    <h4 class="header-line">ADMIN DASHBOARD</h4>
                </div>
            </div>

            <div class="row">
                <div class="col-md-3 col-sm-3 col-xs-6">
                    <div class="alert alert-success back-widget-set text-center">
                        <i class="fa fa-book fa-5x"></i>
                        <%
                        int listedBooks = 0;
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/library", "root", "admin");
                            PreparedStatement ps = conn.prepareStatement("SELECT COUNT(id) AS totalBooks FROM tblbooks");
                            ResultSet rs1 = ps.executeQuery();

                            if (rs1.next()) {
                                listedBooks = rs1.getInt("totalBooks");
                            }

                            conn.close();
                        } catch (Exception e) {
                            out.println(e);
                        }
                        %>
                        <div class="book-list">
                            <h3><%= listedBooks %></h3>
                        </div>
                        <h4>Listed Books</h4>
                    </div>
                </div>

                <div class="col-md-3 col-sm-3 col-xs-6">
                    <div class="alert alert-warning back-widget-set text-center">
                        <i class="fa fa-recycle fa-5x"></i>
                        <%
                        int issuedBooks = 0;
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/library", "root", "admin");
                            PreparedStatement ps = conn.prepareStatement("SELECT COUNT(id) AS totalIssuedBooks FROM tblissuedbookdetails");
                            ResultSet rs2 = ps.executeQuery();

                            if (rs2.next()) {
                                issuedBooks = rs2.getInt("totalIssuedBooks");
                            }

                            conn.close();
                        } catch (Exception e) {
                            out.println( );
                        }
                        %>
                        <div class="book-list">
                            <h3><%= issuedBooks %></h3>
                        </div>
                        <h4>Issued Books</h4>
                    </div>
                </div>

                <div class="col-md-3 col-sm-3 col-xs-6">
                    <div class="alert alert-info back-widget-set text-center">
                        <i class="fa fa-reply-all fa-5x"></i>
                        <%
                        int returnedBooks = 0;
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/library", "root", "admin");
                            PreparedStatement ps = conn.prepareStatement("SELECT COUNT(id) AS totalReturnedBooks FROM tblissuedbookdetails WHERE returnstatus='Returned'");
                            ResultSet rs3 = ps.executeQuery();

                            if (rs3.next()) {
                                returnedBooks = rs3.getInt("totalReturnedBooks");
                            }

                            conn.close();
                        } catch (Exception e) {
                            out.println( );
                        }
                        %>
                        <div class="book-list">
                            <h3><%= returnedBooks %></h3>
                        </div>
                        <h4>Returned Books</h4>
                    </div>
                </div>

                <div class="col-md-3 col-sm-3 col-xs-6">
                    <div class="alert alert-danger back-widget-set text-center">
                        <i class="fa fa-users fa-5x"></i>
                        <%
                        int registeredStudents = 0;
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/library", "root", "admin");
                            PreparedStatement ps = conn.prepareStatement("SELECT COUNT(id) AS totalStudents FROM tblstudent");
                            ResultSet rs4 = ps.executeQuery();

                            if (rs4.next()) {
                                registeredStudents = rs4.getInt("totalStudents");
                            }

                            conn.close();
                        } catch (Exception e) {
                            out.println( );
                        }
                        %>
                        <div class="book-list">
                            <h3><%= registeredStudents %></h3>
                        </div>
                        <h4>Registered Students</h4>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!------MENU SECTION START-->
    <jsp:include page="includes/footer.jsp" />
    <!-- MENU SECTION END-->

    <!-- CORE JQUERY SCRIPTS -->
    <script src="assets/js/jquery-1.11.1.js"></script>
    <!-- BOOTSTRAP SCRIPTS -->
    <script src="assets/js/bootstrap.js"></script>
    <!-- CUSTOM SCRIPTS -->
    <script src="assets/js/custom.js"></script>
</body>
</html>
<%
}
%>
