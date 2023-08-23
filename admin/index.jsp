<%@page import="java.sql.*"%>

<%
    PreparedStatement ps = null;
    Connection conn = null;
    ResultSet rs = null;
    conn = (Connection) application.getAttribute("connection");
    String msg = null;
    String error = null;
%>

<%

if (session.getAttribute("alogin") == null) {
    response.sendRedirect("../index.jsp");
} else {
    String changeValue = request.getParameter("change");
    if (changeValue != null && changeValue.equals("change")) {
        Connection con = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/library", "root", "admin");

            String password = request.getParameter("password");
            String newpassword = request.getParameter("newpassword");
            String username = (String) session.getAttribute("alogin");
            String sql = "SELECT Password FROM admin WHERE UserName=? AND Password=?";
            ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            rs = ps.executeQuery();

            if (rs.next()) {
                String sql1 = "UPDATE admin SET Password=? WHERE UserName=?";
                ps = con.prepareStatement(sql1);
                ps.setString(1, newpassword);
                ps.setString(2, username);
                ps.executeUpdate();
                msg = "Your password has been successfully changed";
                error = null;
            } else {
                error = "Your current password is wrong";
                msg = null;
            }
        } catch (Exception e) {
            System.out.println(e);
        } finally {
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    // handle the exception if needed
                }
            }
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    // handle the exception if needed
                }
            }
        }
    }
}
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Online Library Management System | </title>
    <!-- BOOTSTRAP CORE STYLE  -->
    <link href="assets/css/bootstrap.css" rel="stylesheet" />
    <!-- FONT AWESOME STYLE  -->
    <link href="assets/css/font-awesome.css" rel="stylesheet" />
    <!-- CUSTOM STYLE  -->
    <link href="assets/css/style.css" rel="stylesheet" />
    <!-- GOOGLE FONT -->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
    <style>
        .errorWrap {
            padding: 10px;
            margin: 0 0 20px 0;
            background: #fff;
            border-left: 4px solid #dd3d36;
            -webkit-box-shadow: 0 1px 1px 0 rgba(0, 0, 0, .1);
            box-shadow: 0 1px 1px 0 rgba(0, 0, 0, .1);
        }

        .succWrap {
            padding: 10px;
            margin: 0 0 20px 0;
            background: #fff;
            border-left: 4px solid #5cb85c;
            -webkit-box-shadow: 0 1px 1px 0 rgba(0, 0, 0, .1);
            box-shadow: 0 1px 1px 0 rgba(0, 0, 0, .1);
        }
    </style>
</head>
<body>
    <div class="navbar navbar-inverse set-radius-zero">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#" style="color:#fff; font-size:24px;4px; line-height:24px; ">
                    <img src="path/to/your/logo.png" alt="Logo" style="height: 24px; width: auto; margin-right: 10px;">
                    Online Library Management System
                </a>
            </div>
            <div class="right-div">
                <a href="../logout.jsp" class="btn btn-danger pull-right">LOG ME OUT</a>
            </div>
        </div>
    </div>

    <section class="menu-section">
        <div class="container">
            <div class="row ">
                <div class="col-md-12">
                    <div class="navbar-collapse collapse ">
                        <ul id="menu-top" class="nav navbar-nav navbar-right">
                            <li>
                                <a href="../admin/dashboard.jsp">DASHBOARD</a>
                            </li>
                            <li>
                                <a href="../admin/books.jsp">BOOKS</a>
                            </li>
                            <li>
                                <a href="../admin/requested.jsp">REQUESTS</a>
                            </li>
                            <li>
                                <a href="../admin/issued.jsp">ISSUES</a>
                            </li>
                            <li>
                                <a href="../admin/return.jsp">RETURN</a>
                            </li>
                            <li>
                                <a class="menu-top-active" href="../admin/changepassword.jsp">CHANGE PASSWORD</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- CONTENT-WRAPPER SECTION -->
    <div class="content-wrapper">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <h4 class="page-head-line">Change Password</h4>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            Change Password
                        </div>
                        <div class="panel-body">
                            <% if (msg != null) { %>
                                <div class="succWrap">
                                    <strong>SUCCESS</strong>: <%= msg %>
                                </div>
                            <% } else if (error != null) { %>
                                <div class="errorWrap">
                                    <strong>ERROR</strong>: <%= error %>
                                </div>
                            <% } %>
                            <form role="form" method="post" onSubmit="return valid();">
                                <div class="form-group">
                                    <label>Current Password:</label>
                                    <input class="form-control" type="password" name="password" autocomplete="off" required />
                                </div>
                                <div class="form-group">
                                    <label>New Password:</label>
                                    <input class="form-control" type="password" name="newpassword" autocomplete="off" required />
                                </div>
                                <button type="submit" name="change" value="change" class="btn btn-info">Change </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- CONTENT-WRAPPER SECTION END-->
    <footer>
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    &copy; 2023 Online Library Management System | Designed by : <a href="http://www.binarytheme.com/" target="_blank">www.binarytheme.com</a>
                </div>
            </div>
        </div>
    </footer>
    <!-- FOOTER SECTION END-->
    <!-- CORE JQUERY  -->
    <script src="assets/js/jquery-1.10.2.js"></script>
    <!-- BOOTSTRAP SCRIPTS  -->
    <script src="assets/js/bootstrap.js"></script>
</body>
</html>
