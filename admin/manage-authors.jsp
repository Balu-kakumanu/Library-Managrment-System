<%@page import="java.sql.*"%>
<%
    PreparedStatement ps = null; // Declare and initialize the ps variable
    ResultSet rs = null;
    Connection conn = null;

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
    if(session.getAttribute("alogin")==null) {
        response.sendRedirect("../index.jsp");
    } else {
        String id=request.getParameter("del");
        if(id!=null) {
            try {
                String authorId = request.getParameter("id");
                String sql = "DELETE FROM tblauthors WHERE id = ?";
                ps = conn.prepareStatement(sql);
                ps.setInt(1, Integer.parseInt(authorId));
                ps.executeUpdate();
                session.setAttribute("delmsg", "Author deleted successfully");
                response.sendRedirect("manage-authors.jsp");

            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                if (ps != null) {
                    try {
                        ps.close();
                    } catch (SQLException e) { /* ignored */ }
                }
                if (conn != null) {
                    try {
                        conn.close();
                    } catch (SQLException e) { /* ignored */ }
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
    <title>Online Library Management System | Manage Authors</title>
    <!-- BOOTSTRAP CORE STYLE  -->
    <link href="assets/css/bootstrap.css" rel="stylesheet" />
    <!-- FONT AWESOME STYLE  -->
    <link href="assets/css/font-awesome.css" rel="stylesheet" />
    <!-- DATATABLE STYLE  -->
    <link href="assets/js/dataTables/dataTables.bootstrap.css" rel="stylesheet" />
    <!-- CUSTOM STYLE  -->
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
                    <h4 class="header-line">Manage Authors</h4>
                </div>
                <div class="row">
                    <% String error=(String)session.getAttribute("error");
                    if(error!=null) { %>
                        <div class="col-md-6">
                            <div class="alert alert-danger" >
                                <strong>Error :</strong>
                                <%=error%>
                                <% session.setAttribute("error",null); %>
                            </div>
                        </div>
                    <% } %>
                    <% String msg=(String)session.getAttribute("delmsg");
                    if(msg!=null) { %>
                        <div class="col-md-6">
                            <div class="alert alert-success" >
                                <strong>Success :</strong>
                                <%=msg%>
                                <% session.setAttribute("delmsg",null); %>
                            </div>
                        </div>
                    <% } %>
                </div>
                <!--End Error & Success Msg-->
                <div class="row">
                    <div class="col-md-12">
                        <!-- Advanced Tables -->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                Authors Listing
                            </div>
                            <div class="panel-body">
                                <div class="table-responsive">
                                    <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Author</th>
                                                <th>Creation Date</th>
                                                <th>Updation Date</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% try {
                                                ps=conn.prepareStatement("SELECT * FROM tbl_authors");
                                                rs=ps.executeQuery();
                                                int count=1;
                                                while(rs.next()) {
                                                    String authorId = rs.getString("author_id");
                                                    String authorName = rs.getString("author_name");
                                                    String creationDate = rs.getString("creation_date");
                                                    String updationDate = rs.getString("updation_date");
                                            %>
                                            <tr class="odd gradeX">
                                                <td><%=count%></td>
                                                <td><%=authorName%></td>
                                                <td><%=creationDate%></td>
                                                <td class="center"><%=updationDate%></td>
                                                <td class="center">
                                                    <a href="manage-authors.jsp?del=<%=rs.getInt("author_id")%>" onclick="return confirm('Are you sure you want to delete?');">
                                                        <button class="btn btn-danger">Delete</button>
                                                    </a>
                                                </td>
                                            </tr>
                                            <% count++; }
                                            rs.close();
                                            ps.close();
                                            } catch (SQLException e) {
                                                // Handle any SQL errors
                                                e.printStackTrace();
                                            } finally {
                                                // Close the resources
                                                if (conn != null) {
                                                    try {
                                                        conn.close();
                                                    } catch (SQLException e) { /* ignored */ }
                                                }
                                            }
                                            %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <!--End Advanced Tables -->
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- CONTENT-WRAPPER SECTION END-->
    <jsp:include page="includes/footer.jsp" />
    <!-- FOOTER SECTION END-->
    <!-- CORE JQUERY SCRIPTS -->
    <script src="assets/js/jquery-1.11.1.js"></script>
    <!-- BOOTSTRAP SCRIPTS  -->
    <script src="assets/js/bootstrap.js"></script>
    <!-- DATATABLE SCRIPTS  -->
    <script src="assets/js/dataTables/jquery.dataTables.js"></script>
    <script src="assets/js/dataTables/dataTables.bootstrap.js"></script>
    <script>
        $(document).ready(function () {
            $('#dataTables-example').dataTable();
        });
    </script>
    <!-- CUSTOM SCRIPTS  -->
    <script src="assets/js/custom.js"></script>
</body>
</html>
