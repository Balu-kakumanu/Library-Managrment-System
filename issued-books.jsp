<%@page import="java.sql.*"%>
<%

String email = (String) session.getAttribute("login");
if (email == null) {
    response.sendRedirect("index.jsp");
} else {
    String id = request.getParameter("del");
    if (id != null) {
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/library", "root", "admin");
            PreparedStatement ps = conn.prepareStatement("DELETE from tblbooks WHERE id=?");
            ps.setInt(1, Integer.parseInt(id));
            int i = ps.executeUpdate();

            if (i > 0) {
                session.setAttribute("delmsg", "Category deleted successfully");
                response.sendRedirect("manage-books.jsp");
            }
        } catch (SQLException e) {
            System.out.println("Error connecting to database: " + e.getMessage());
        }
    }
}
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
    <meta name="description" content=""/>
    <meta name="author" content=""/>
    <title>Online Library Management System | Manage Issued Books</title>
    <!-- BOOTSTRAP CORE STYLE  -->
    <link href="assets/css/bootstrap.css" rel="stylesheet"/>
    <!-- FONT AWESOME STYLE  -->
    <link href="assets/css/font-awesome.css" rel="stylesheet"/>
    <!-- DATATABLE STYLE  -->
    <link href="assets/js/dataTables/dataTables.bootstrap.css" rel="stylesheet"/>
    <!-- CUSTOM STYLE  -->
    <link href="assets/css/style.css" rel="stylesheet"/>
    <!-- GOOGLE FONT -->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'/>

</head>
<body>
<!------MENU SECTION START-->
<jsp:include page="includes/header.jsp"/>
<!-- MENU SECTION END-->
<div class="content-wrapper">
    <div class="container">
        <div class="row pad-botm">
            <div class="col-md-12">
                <h4 class="header-line">Manage Issued Books</h4>
            </div>


            <div class="row">
                <div class="col-md-12">
                    <!-- Advanced Tables -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Issued Books
                        </div>
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover"
                                       id="dataTables-example">
                                    <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Book Name</th>
                                        <th>ISBN</th>
                                        <th>Issued Date</th>
                                        <th>Return Date</th>
                                        <th>Fine in (USD)</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <%
                                        try {
                                            // Create a connection to the database
                                            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/library", "root", "admin");

                                            // Get the student id from the session
                                            String sid = (String) session.getAttribute("stdid");

                                            // Create the SQL query
                                            String sql = "SELECT tblbooks.BookName, tblbooks.ISBNNumber, tblissuedbookdetails.IssuesDate, tblissuedbookdetails.ReturnDate, tblissuedbookdetails.id as rid, tblissuedbookdetails.fine " +
                                                    "FROM tblissuedbookdetails JOIN tblstudents ON tblstudents.StudentId = tblissuedbookdetails.StudentID " +
                                                    "JOIN tblbooks ON tblbooks.id = tblissuedbookdetails.BookID " +
                                                    "WHERE tblstudents.StudentEmail=?";

                                            // Prepare the statement
                                            PreparedStatement ps = conn.prepareStatement(sql);
                                            ps.setString(1, email);

                                            // Execute the query
                                            ResultSet rs = ps.executeQuery();

                                            int cnt = 1; // Initialize the counter

                                            // Iterate over the result set and display the data
                                            while (rs.next()) {
                                                String bookName = rs.getString("BookName");
                                                String isbn = rs.getString("ISBNNumber");
                                                String issueDate = rs.getString("IssuesDate");
                                                String returnDate = rs.getString("ReturnDate");
                                                String fine = rs.getString("fine");
                                                String rid = rs.getString("rid");
                                    %>
                                    <tr class="odd gradeX">
                                        <td class="center"><%= cnt++ %></td>
                                        <td class="center"><%= bookName %></td>
                                        <td class="center"><%= isbn %></td>
                                        <td class="center"><%= issueDate %></td>
                                        <td class="center"><%= returnDate %></td>
                                        <td class="center"><%= fine %></td>
                                        <td class="center">
                                            <a href="manage-books.jsp?del=<%= rid %>">Delete</a>
                                        </td>
                                    </tr>
                                    <%
                                            }
                                            rs.close();
                                            conn.close();
                                        } catch (SQLException e) {
                                            System.out.println("Error connecting to database: " + e.getMessage());
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
<jsp:include page="includes/footer.jsp"/>
<!-- FOOTER SECTION END-->
<!-- CORE JQUERY SCRIPTS -->
<script src="assets/js/jquery-1.11.1.js"></script>
<!-- BOOTSTRAP SCRIPTS  -->
<script src="assets/js/bootstrap.js"></script>
<!-- DATATABLE SCRIPTS  -->
<script src="assets/js/dataTables/jquery.dataTables.js"></script>
<script src="assets/js/dataTables/dataTables.bootstrap.js"></script>
<!-- CUSTOM SCRIPTS  -->
<script src="assets/js/custom.js"></script>
</body>
</html>
