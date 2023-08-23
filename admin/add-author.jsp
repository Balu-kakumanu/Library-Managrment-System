<%@page import="java.sql.*, java.text.DateFormat, java.text.SimpleDateFormat, java.util.Date"%>
<%!
    public static String getDate() {
        DateFormat df = new SimpleDateFormat("d-MMM-yyyy");
        String exam_date = df.format(new Date());
        return exam_date;
    }
%>

<%
    PreparedStatement ps = null;
    Connection conn = null;
    ResultSet rs = null;
    conn = (Connection) application.getAttribute("connection");
%>

<%
    if (session.getAttribute("alogin") == null) {
        response.sendRedirect("../index.jsp");
    } else {
        String create = request.getParameter("create");
        if (create != null) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/library", "root", "admin");

                String author = request.getParameter("author");
                String sql = "INSERT INTO tblauthors(AuthorName, CreationDate) VALUES(?,?)";
                ps = con.prepareStatement(sql);
                ps.setString(1, author);
                ps.setString(2, getDate());
                int i = ps.executeUpdate();

                if (i > 0) {
                    session.setAttribute("msg", "Author Listed successfully");
                    response.sendRedirect("manage-authors.jsp");
                } else {
                    session.setAttribute("error", "Something went wrong. Please try again");
                    response.sendRedirect("manage-authors.jsp");
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (ps != null) {
                    try {
                        ps.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                if (conn != null) {
                    try {
                        conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
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
    <title>Online Library Management System | Add Author</title>
    <!-- BOOTSTRAP CORE STYLE  -->
    <link href="assets/css/bootstrap.css" rel="stylesheet" />
    <!-- FONT AWESOME STYLE  -->
    <link href="assets/css/font-awesome.css" rel="stylesheet" />
    <!-- CUSTOM STYLE  -->
    <link href="assets/css/style.css" rel="stylesheet" />
    <!-- GOOGLE FONT -->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />

</head>
<body>
    <!------MENU SECTION START-->
    <jsp:include page="includes/header.jsp" />
    <!-- MENU SECTION END-->
    <div class="content-wra">
        <div class="content-wrapper">
            <div class="container">
                <div class="row pad-botm">
                    <div class="col-md-12">
                        <h4 class="header-line">Add Author</h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
                        <div class="panel panel-info">
                            <div class="panel-heading">
                                Author Info
                            </div>
                            <div class="panel-body">
                                <form role="form" method="post">
                                    <div class="form-group">
                                        <label>Author Name</label>
                                        <input class="form-control" type="text" name="author" autocomplete="off" required />
                                    </div>
                                    <button type="submit" name="create" value="create" class="btn btn-info">Add</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- CONTENT-WRAPPER SECTION END-->
    <jsp:include page="includes/footer.jsp" />
    <!-- FOOTER SECTION END-->
    <!-- JAVASCRIPT FILES PLACED AT THE BOTTOM TO REDUCE THE LOADING TIME  -->
    <!-- CORE JQUERY  -->
    <script src="assets/js/jquery-1.10.2.js"></script>
    <!-- BOOTSTRAP SCRIPTS  -->
    <script src="assets/js/bootstrap.js"></script>
    <!-- CUSTOM SCRIPTS  -->
    <script src="assets/js/custom.js"></script>
</body>
</html>
<% } %>
