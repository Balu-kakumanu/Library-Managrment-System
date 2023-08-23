<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>

<%
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        String url = "jdbc:mysql://localhost:3306/library";
        String username = "root";
        String password = "admin";

        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, password);
        application.setAttribute("connection", conn);

        // Rest of your code...

    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
        // Handle the exception appropriately
    } finally {
        // Close the database resources in the reverse order of their creation
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
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>

<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>

<%
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        // Get the connection from the data source
        Context initContext = new InitialContext();
        Context envContext = (Context) initContext.lookup("java:/comp/env");
        DataSource ds = (DataSource) envContext.lookup("jdbc/library");
        conn = ds.getConnection();

        // Check if the "del" parameter exists in the request
        if (request.getParameter("del") != null) {
            String bookId = request.getParameter("del");

            try {
                // Create the prepared statement with the desired SQL query
                String sql = "DELETE FROM tblbooks WHERE id = ?";
                ps = conn.prepareStatement(sql);

                // Set the parameter for the prepared statement
                ps.setInt(1, Integer.parseInt(bookId));

                // Execute the delete query
                ps.executeUpdate();

                // Set the success message
                session.setAttribute("delmsg", "Book deleted successfully.");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // Retrieve the book data from the database
        String sql = "SELECT tblbooks.BookName, tblcategory.CategoryName, tblauthors.AuthorName, tblbooks.ISBNNumber, tblbooks.BookPrice, tblbooks.id as bookid " +
                     "FROM tblbooks " +
                     "JOIN tblcategory ON tblcategory.id = tblbooks.CatId " +
                     "JOIN tblauthors ON tblauthors.id = tblbooks.AuthorId";
        ps = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        rs = ps.executeQuery();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Close the resources
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
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
<%@ page import="java.sql.*" %>
<%
    PreparedStatement ps;
    ResultSet rs = null;

    String url = "jdbc:mysql://localhost:3306/library";
    String username = "root";
    String password = "admin";

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection(url, username, password);
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
                // Establish a connection to the database
                Connection conn = DriverManager.getConnection(url, username, password);

                // Get the parameter value from the request
                String bookId = request.getParameter("id");

                // Create the prepared statement with the desired SQL query
                String sql = "DELETE FROM tblbooks WHERE id = ?";
                PreparedStatement ps = conn.prepareStatement(sql);

                // Set the parameter for the prepared statement
                ps.setInt(1, Integer.parseInt(bookId));

                // Execute the update and retrieve the number of affected rows
                ps.executeUpdate();

                // Set a message attribute indicating success
                session.setAttribute("delmsg", "Book deleted successfully");
                response.sendRedirect("manage-books.jsp");

            } catch (SQLException e) {
                // Handle any SQL errors
                e.printStackTrace();
            } finally {
                // Close the resources
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
    <title>Online Library Management System | Manage Books</title>
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
                    <h4 class="header-line">Manage Books</h4>
                </div>
                <div class="row">
                    <% if(session.getAttribute("error")!=null) { %>
                    <div class="col-md-6">
                        <div class="alert alert-danger" >
                            <strong>Error :</strong> 
                            <% out.println(session.getAttribute("error")); %>
                            <% session.setAttribute("error",null); %>
                        </div>
                    </div>
                    <% } %>
                    <% if(session.getAttribute("msg")!=null) { %>
                    <div class="col-md-6">
                        <div class="alert alert-success" >
                            <strong>Success :</strong> 
                            <% out.println(session.getAttribute("msg")); %>
                            <% session.setAttribute("msg",null); %>
                        </div>
                    </div>
                    <% } %>
                    <% if(session.getAttribute("updatemsg")!=null) { %>
                    <div class="col-md-6">
                        <div class="alert alert-success" >
                            <strong>Success :</strong> 
                            <% out.println(session.getAttribute("updatemsg")); %>
                            <% session.setAttribute("updatemsg",null); %>
                        </div>
                    </div>
                    <% } %>
                    <% if(session.getAttribute("delmsg")!=null) { %>
                    <div class="col-md-6">
                        <div class="alert alert-success" >
                            <strong>Success :</strong> 
                            <% out.println(session.getAttribute("delmsg")); %>
                            <% session.setAttribute("delmsg",null); %>
                        </div>
                    </div>
                    <% } %>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <!-- Advanced Tables -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                           Books Listing
                        </div>
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Book Name</th>
                                            <th>Category</th>
                                            <th>Author</th>
                                            <th>ISBN</th>
                                            <th>Price</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% String sql = "SELECT tblbooks.BookName,tblcategory.CategoryName,tblauthors.AuthorName,tblbooks.ISBNNumber,tblbooks.BookPrice,tblbooks.id as bookid from  tblbooks join tblcategory on tblcategory.id=tblbooks.CatId join tblauthors on tblauthors.id=tblbooks.AuthorId";
                                        ps=conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
                                        rs=ps.executeQuery();

                                        int cnt=1;
                                        while(rs.next()) {
                                        %>
                                        <tr class="odd gradeX">
                                            <td class="center"><%=cnt%></td>
                                            <td class="center"><%=rs.getString("BookName")%></td>
                                            <td class="center"><%=rs.getString("CategoryName")%></td>
                                            <td class="center"><%=rs.getString("AuthorName")%></td>
                                            <td class="center"><%=rs.getString("ISBNNumber")%></td>
                                            <td class="center"><%=rs.getString("BookPrice")%></td>
                                            <td class="center">
                                                <a href="edit-book.jsp?bookid=<%=rs.getString("bookid")%>">
                                                    <button class="btn btn-primary"><i class="fa fa-edit"></i> Edit</button>
                                                </a>
                                                <a href="manage-books.jsp?del=<%=rs.getString("bookid")%>" onclick="return confirm('Are you sure you want to delete?');">
                                                    <button class="btn btn-danger"><i class="fa fa-pencil"></i> Delete</button>
                                                </a>
                                            </td>
                                        </tr>
                                        <% cnt=cnt+1;
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

    <!-- CONTENT-WRAPPER SECTION END-->
    <jsp:include page="includes/footer.jsp" />
    <!-- FOOTER SECTION END-->
    <!-- JAVASCRIPT FILES PLACED AT THE BOTTOM TO REDUCE THE LOADING TIME  -->
    <!-- CORE JQUERY  -->
    <script src="assets/js/jquery-1.10.2.js"></script>
    <!-- BOOTSTRAP SCRIPTS  -->
    <script src="assets/js/bootstrap.js"></script>
    <!-- DATATABLE SCRIPTS  -->
    <script src="assets/js/dataTables/jquery.dataTables.js"></script>
    <script src="assets/js/dataTables/dataTables.bootstrap.js"></script>
    <!-- CUSTOM SCRIPTS  -->
    <script src="assets/js/custom.js"></script>
</body>
</html>
<% 
} 
%>
