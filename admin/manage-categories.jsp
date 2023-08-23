<%@ page import="java.sql.*" %>
<%
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String url = "jdbc:mysql://localhost:3306/library";
    String username = "root";
    String password = "admin";

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, password);
        application.setAttribute("connection", conn);
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    }
%>

<%
if (session.getAttribute("alogin") == null) {
    response.sendRedirect("../index.jsp");
} else {
    String id = request.getParameter("del");
    if (id != null) {
        try {
            String sql = "DELETE FROM tblcategory WHERE id = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(id));
            ps.executeUpdate();

            session.setAttribute("delmsg", "Category deleted successfully");
            response.sendRedirect("manage-categories.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (ps != null) {
                try {
                    ps.close();
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
    <title>Online Library Management System | Manage Categories</title>
    <!-- BOOTSTRAP CORE STYLE  -->
    <link href="assets/css/bootstrap.css" rel="stylesheet" />
    <!-- FONT AWESOME STYLE  -->
    <link href="assets/css/font-awesome.css" rel="stylesheet" />
    <!-- DATATABLE STYLE  -->
    <link href="assets/css/dataTables.bootstrap.css" rel="stylesheet" />
    <!-- CUSTOM STYLE  -->
    <link href="assets/css/style.css" rel="stylesheet" />
    <!-- GOOGLE FONT -->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
</head>
<body>
    <!-- MENU SECTION START -->
    <jsp:include page="includes/header.jsp" />
    <!-- MENU SECTION END -->
    <div class="content-wrapper">
        <div class="container">
            <div class="row pad-botm">
                <div class="col-md-12">
                    <h4 class="header-line">Manage Categories</h4>
                </div>
            </div>
            <div class="row">
                <% String error = (String) session.getAttribute("error");
                if (error != null) { %>
                    <div class="col-md-6">
                        <div class="alert alert-danger">
                            <strong>Error:</strong>
                            <%= error %>
                            <% session.setAttribute("error", null); %>
                        </div>
                    </div>
                <% } %>
                <% String msg = (String) session.getAttribute("msg");
                if (msg != null) { %>
                    <div class="col-md-6">
                        <div class="alert alert-success">
                            <strong>Success:</strong>
                            <%= msg %>
                            <% session.setAttribute("msg", null); %>
                        </div>
                    </div>
                <% } %>
                <% String updatemsg = (String) session.getAttribute("updatemsg");
                if (updatemsg != null) { %>
                    <div class="col-md-6">
                        <div class="alert alert-success">
                            <strong>Success:</strong>
                            <%= updatemsg %>
                            <% session.setAttribute("updatemsg", null); %>
                        </div>
                    </div>
                <% } %>
            </div>
            <!-- Manage Categories Table -->
            <div class="row">
                <div class="col-md-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            List of Categories
                        </div>
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Category Name</th>
                                            <th>Edit</th>
                                            <th>Delete</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% try {
                                            String selectQuery = "SELECT * FROM tblcategory";
                                            ps = conn.prepareStatement(selectQuery);
                                            rs = ps.executeQuery();

                                            int count = 1;
                                            while (rs.next()) {
                                                String categoryId = rs.getString("id");
                                                String categoryName = rs.getString("categoryname");
                                        %>
                                        <tr class="odd gradeX">
                                            <td><%= count %></td>
                                            <td><%= categoryName %></td>
                                            <td class="center">
                                                <a href="edit-category.jsp?catid=<%= categoryId %>" class="btn btn-primary">Edit</a>
                                            </td>
                                            <td class="center">
                                                <a href="manage-categories.jsp?del=<%= categoryId %>" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this category?')">Delete</a>
                                            </td>
                                        </tr>
                                        <% count++;
                                            }
                                        } catch (SQLException e) {
                                            e.printStackTrace();
                                        } finally {
                                            if (rs != null) {
                                                try {
                                                    rs.close();
                                                } catch (SQLException e) {
                                                    e.printStackTrace();
                                                }
                                            }
                                            if (ps != null) {
                                                try {
                                                    ps.close();
                                                } catch (SQLException e) {
                                                    e.printStackTrace();
                                                }
                                            }
                                        }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- End Manage Categories Table -->
        </div>
    </div>
    <!-- CONTENT-WRAPPER SECTION END -->
    <jsp:include page="includes/footer.jsp" />
    <!-- FOOTER SECTION END -->
    <!-- CORE JQUERY SCRIPTS -->
    <script src="assets/js/jquery-1.11.1.js"></script>
    <!-- BOOTSTRAP SCRIPTS  -->
    <script src="assets/js/bootstrap.js"></script>
    <!-- DATATABLE SCRIPTS  -->
    <script src="assets/js/jquery.dataTables.min.js"></script>
    <script src="assets/js/dataTables.bootstrap.min.js"></script>
    <!-- CUSTOM SCRIPTS  -->
    <script src="assets/js/custom.js"></script>
    <script>
        $(document).ready(function () {
            $('#dataTables-example').dataTable();
        });
    </script>
</body>
</html>
