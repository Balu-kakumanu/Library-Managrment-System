<%@page import="java.sql.*,java.text.DateFormat,java.text.SimpleDateFormat,java.util.Date"%>
<%@page errorPage="error.jsp"%>
<%!
    public static String getDate() {
        DateFormat df = new SimpleDateFormat("d-MMM-yyyy");
        String exam_date = df.format(new Date());
        return exam_date;
    }
%>

<%
String email = (String) session.getAttribute("login");
if (email == null) {
    response.sendRedirect("index.jsp");
} else {
    String updateValue = request.getParameter("update");
    if (updateValue != null && updateValue.equals("update")) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/library", "root", "admin");

            String sid = (String) session.getAttribute("stdid");
            String fname = request.getParameter("fullname");
            String mobileno = request.getParameter("mobileno");

            String sql = "update tblstudents set FullName=?,MobileNumber=?,UpdationDate=? where StudentId=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, fname);
            ps.setString(2, mobileno);
            ps.setString(3, getDate());
            ps.setString(4, sid);
            ps.executeUpdate();

            out.println("<script>alert('Your profile has been updated')</script>");
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
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
    <!--[if IE]>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <![endif]-->
    <title>Online Library Management System | Student Signup</title>
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
    <div class="content-wrapper">
         <div class="container">
        <div class="row pad-botm">
            <div class="col-md-12">
                <h4 class="header-line">My Profile</h4>

            </div>

        </div>
             <div class="row">

<div class="col-md-9 col-md-offset-1">
               <div class="panel panel-danger">
                        <div class="panel-heading">
                           My Profile
                        </div>
                        <div class="panel-body">
                            <form name="signup" method="post">
<%
try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/library", "root", "admin");
    String sid = (String) session.getAttribute("stdid");
    String sql = "SELECT StudentId,FullName,EmailId,MobileNumber,RegDate,UpdationDate,Status from tblstudents where StudentId=? ";
    PreparedStatement ps = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
    ps.setString(1, sid);
    ResultSet resultSet = ps.executeQuery();

    if (resultSet.next()) {
%>
    <label>Student ID : </label>
    <%= resultSet.getString("StudentId") %>

    <div class="form-group">
        <label>Reg Date : </label>
        <%= resultSet.getString("RegDate") %>
    </div>

    <div class="form-group">
        <label>Updation Date : </label>
        <%= resultSet.getString("UpdationDate") %>
    </div>

    <div class="form-group">
        <label>Profile Status : </label>
        <% if (resultSet.getInt("Status") == 1) { %>
            <span style="color: green">Active</span>
        <% } else { %>
            <span style="color: red">Blocked</span>
        <% } %>
    </div>

    <div class="form-group">
        <label>Enter Full Name</label>
        <input class="form-control" type="text" name="fullname" value="<%= resultSet.getString("FullName") %>" autocomplete="off" required />
    </div>

    <div class="form-group">
        <label>Mobile Number :</label>
        <input class="form-control" type="text" name="mobileno" maxlength="10" value="<%= resultSet.getString("MobileNumber") %>" autocomplete="off" required />
    </div>

    <div class="form-group">
        <label>Enter Email</label>
        <input class="form-control" type="email" name="email" id="emailid" value="<%= resultSet.getString("EmailId") %>" autocomplete="off" required readonly />
    </div>

    <button type="submit" name="update" value="update" class="btn btn-primary" id="submit">Update Now </button>
<%
    }
} catch (Exception e) {
    e.printStackTrace();
} finally {
    // any necessary cleanup code
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
<jsp:include page="includes/footer.jsp" />
<script src="assets/js/jquery-1.10.2.js"></script>
<!-- BOOTSTRAP SCRIPTS  -->
<script src="assets/js/bootstrap.js"></script>
<!-- CUSTOM SCRIPTS  -->
<script src="assets/js/custom.js"></script>

</body>
</html>
