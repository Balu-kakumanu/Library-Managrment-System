<%@ page import="java.sql.*, java.text.DateFormat, java.text.SimpleDateFormat, java.util.Date" %>
<%@ page import="javax.naming.*, javax.sql.*" %>

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

    if (session.getAttribute("alogin") == null) {
        response.sendRedirect("../index.jsp");
    } else {
        // Code for blocking a student
        String inid = request.getParameter("inid");
        if (inid != null) {
            try {
                Connection conn = (Connection) application.getAttribute("connection");
                String id = request.getParameter("inid");
                int status = 0;
                String sql = "UPDATE tblstudents SET Status = ?, UpdationDate = ? WHERE id = ?";
                ps = conn.prepareStatement(sql);
                ps.setInt(1, status);
                ps.setString(2, new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
                ps.setInt(3, Integer.parseInt(id));
                ps.executeUpdate();
                response.sendRedirect("reg-students.jsp");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // Code for activating a student
        String id = request.getParameter("id");
        if (id != null) {
            try {
                Connection conn = (Connection) application.getAttribute("connection");
                int status = 1;
                String sql = "UPDATE tblstudents SET Status = ?, UpdationDate = ? WHERE id = ?";
                ps = conn.prepareStatement(sql);
                ps.setInt(1, status);
                ps.setString(2, new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
                ps.setInt(3, Integer.parseInt(id));
                ps.executeUpdate();
                response.sendRedirect("reg-students.jsp");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Admin Panel</title>
    <!-- Bootstrap Styles -->
    <link href="assets/css/bootstrap.css" rel="stylesheet" />
    <!-- Font Awesome Styles -->
    <link href="assets/css/font-awesome.css" rel="stylesheet" />
    <!-- Custom Styles -->
    <link href="assets/css/custom.css" rel="stylesheet" />
    <!-- DataTables CSS -->
    <link href="assets/js/dataTables/dataTables.bootstrap.css" rel="stylesheet" />
</head>
<body>
    <div id="wrapper">
        <%@ include file="/includes/navbar.jsp" %>
        <!-- NAV TOP -->
        <%@ include file="/includes/sidebar.jsp" %>
        <!-- NAV SIDE -->

        <div id="page-wrapper">
            <div id="page-inner">
                <div class="row">
                    <div class="col-md-12">
                        <h2>Manage Registered Students</h2>
                    </div>
                </div>
                <!-- /. ROW -->
                <hr />

                <div class="row">
                    <div class="col-md-12">
                        <!-- Advanced Tables -->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                Registered Students
                            </div>
                            <div class="panel-body">
                                <div class="table-responsive">
                                    <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                        <thead>
                                            <tr>
                                                <th>Student ID</th>
                                                <th>Student Name</th>
                                                <th>Email</th>
                                                <th>Contact No.</th>
                                                <th>Reg Date</th>
                                                <th>Status</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% 
                                                try {
                                                    Connection conn = (Connection) application.getAttribute("connection");
                                                    String sql = "SELECT * FROM tblstudents";
                                                    ps = conn.prepareStatement(sql);
                                                    rs = ps.executeQuery();

                                                    while (rs.next()) {
                                                        int idVal = rs.getInt("id");
                                                        String studentId = rs.getString("StudentID");
                                                        String studentName = rs.getString("FullName");
                                                        String email = rs.getString("Email");
                                                        String contactNo = rs.getString("MobileNumber");
                                                        String regDate = rs.getString("RegDate");
                                                        int status = rs.getInt("Status");

                                                        out.println("<tr class='odd gradeX'>");
                                                        out.println("<td>" + studentId + "</td>");
                                                        out.println("<td>" + studentName + "</td>");
                                                        out.println("<td>" + email + "</td>");
                                                        out.println("<td>" + contactNo + "</td>");
                                                        out.println("<td>" + regDate + "</td>");
                                                        out.println("<td>");
                                                        if (status == 1) {
                                                            out.println("Active");
                                                        } else {
                                                            out.println("Blocked");
                                                        }
                                                        out.println("</td>");
                                                        out.println("<td>");
                                                        if (status == 1) {
                                                            out.println("<a href='reg-students.jsp?id=" + idVal + "&inid=" + idVal + "' onclick='return confirm(\"Are you sure you want to block this student?\")' title='Block' class='btn btn-danger btn-xs'>Block</a>");
                                                        } else {
                                                            out.println("<a href='reg-students.jsp?id=" + idVal + "' onclick='return confirm(\"Are you sure you want to activate this student?\")' title='Activate' class='btn btn-success btn-xs'>Activate</a>");
                                                        }
                                                        out.println("</td>");
                                                        out.println("</tr>");
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
                        <!--End Advanced Tables -->
                    </div>
                </div>
                <!-- /. ROW  -->
            </div>
            <!-- /. PAGE INNER  -->
        </div>
        <!-- /. PAGE WRAPPER  -->
    </div>
    <!-- /. WRAPPER  -->
    <!-- JS Scripts-->
    <!-- jQuery Js -->
    <script src="assets/js/jquery-1.10.2.js"></script>
    <!-- Bootstrap Js -->
    <script src="assets/js/bootstrap.min.js"></script>
    <!-- Metis Menu Js -->
    <script src="assets/js/jquery.metisMenu.js"></script>
    <!-- DataTables Js -->
    <script src="assets/js/dataTables/jquery.dataTables.js"></script>
    <script src="assets/js/dataTables/dataTables.bootstrap.js"></script>
    <script>
        $(document).ready(function () {
            $('#dataTables-example').dataTable();
        });
    </script>
    <!-- Custom Js -->
    <script src="assets/js/custom-scripts.js"></script>
</body>
</html>
