<%@ page import="java.io.*, java.sql.*, java.text.DateFormat, java.text.SimpleDateFormat, java.util.Date" %>

<%
    if (session.getAttribute("alogin") == null) {
        response.sendRedirect("../index.jsp");
    } else {
        String create = request.getParameter("create");
        if (create != null) {
            Connection con = null;
            PreparedStatement psInsert = null;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/library", "root", "admin");

                String category = request.getParameter("category");
                String status = request.getParameter("status");
                String sql = "INSERT INTO tblcategory(CategoryName, Status, CreationDate) VALUES(?,?,?)";
                psInsert = con.prepareStatement(sql);
                psInsert.setString(1, category);
                psInsert.setInt(2, Integer.parseInt(status));
                psInsert.setString(3, getDate());
                int i = psInsert.executeUpdate();

                if (i == 0) {
                    session.setAttribute("error", "Something went wrong. Please try again");
                    response.sendRedirect("manage-categories.jsp");
                } else {
                    session.setAttribute("msg", "Category listed successfully");
                    response.sendRedirect("manage-categories.jsp");
                }
            } catch (Exception e) {
                System.out.println(e);
            } finally {
                if (psInsert != null) {
                    psInsert.close();
                }
                if (con != null) {
                    con.close();
                }
            }
        }
    }
%>

<%!
    String getDate() {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date = new Date();
        return dateFormat.format(date);
    }
%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Online Library Management System | Add Categories</title>
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
    <%@include file="includes/header.jsp" %>
    <div class="content-wra">
        <div class="content-wrapper">
            <div class="container">
                <div class="row pad-botm">
                    <div class="col-md-12">
                        <h4 class="header-line">Add Category</h4>
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
                                    <div class="form-group">
                                        <label>Category Name</label>
                                        <input class="form-control" type="text" name="category" autocomplete="off" required />
                                    </div>
                                    <div class="form-group">
                                        <label>Status</label>
                                        <div class="radio">
                                            <label>
                                                <input type="radio" name="status" id="status" value="1" checked />Active
                                            </label>
                                        </div>
                                        <div class="radio">
                                            <label>
                                                <input type="radio" name="status" id="status" value="0">Inactive
                                            </label>
                                        </div>
                                    </div>
                                    <button type="submit" name="create" class="btn btn-info">Add</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- CONTENT-WRAPPER SECTION END-->
    <%@include file="includes/footer.jsp" %>
</body>
</html>
