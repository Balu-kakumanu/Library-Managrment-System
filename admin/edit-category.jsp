<%@page import="java.sql.*,java.text.DateFormat,java.text.SimpleDateFormat,java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Online Library Management System | Edit Categories</title>
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
    <!-- MENU SECTION START-->
    <%@include file="includes/header.jsp" %>
    <!-- MENU SECTION END-->
    <div class="content-wrapper">
        <div class="container">
            <div class="row pad-botm">
                <div class="col-md-12">
                    <h4 class="header-line">Edit category</h4>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            Category Info
                        </div>
                        <div class="panel-body">
                            <form role="form" method="post">
                                <% 
                                    String catid = request.getParameter("catid");
                                    String url = "jdbc:mysql://localhost:3306/library";
                                    String username = "root";
                                    String password = "admin";
                                    String exam_date = "";
                                    try {
                                        DateFormat df = new SimpleDateFormat("d-MMM-yyyy");
                                        exam_date = df.format(new Date());
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    }
                                    try {
                                        Class.forName("com.mysql.jdbc.Driver");
                                        Connection conn = DriverManager.getConnection(url, username, password);
                                        String sql = "SELECT * from tblcategory where id=?";
                                        PreparedStatement ps = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                        ps.setInt(1, Integer.parseInt(catid));
                                        ResultSet rs = ps.executeQuery();
                                        if (rs.next()) {
                                %>
                                <div class="form-group">
                                    <label>Category Name</label>
                                    <input class="form-control" type="text" name="category" value="<%= rs.getString("CategoryName") %>" required />
                                </div>
                                <div class="form-group">
                                    <label>Status</label>
                                    <% if (rs.getInt("Status") == 1) { %>
                                        <div class="radio">
                                            <label>
                                                <input type="radio" name="status" id="status" value="1" checked="checked">Active
                                            </label>
                                        </div>
                                        <div class="radio">
                                            <label>
                                                <input type="radio" name="status" id="status" value="0">Inactive
                                            </label>
                                        </div>
                                    <% } else { %>
                                        <div class="radio">
                                            <label>
                                                <input type="radio" name="status" id="status" value="0" checked="checked">Inactive
                                            </label>
                                        </div>
                                        <div class="radio">
                                            <label>
                                                <input type="radio" name="status" id="status" value="1">Active
                                            </label>
                                        </div>
                                    <% } %>
                                </div>
                                <button type="submit" name="update" class="btn btn-info">Update</button>
                                <% 
                                    rs.close();
                                    conn.close();
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                                %>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- CONTENT-WRAPPER SECTION END-->
    <%@include file="includes/footer.jsp" %>
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
