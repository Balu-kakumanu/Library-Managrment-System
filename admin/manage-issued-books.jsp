<%@page import="java.sql.*"%>
<%
	PreparedStatement ps;
ResultSet rs = null;

String url = "jdbc:mysql://localhost:3306/library","root","admin";
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

if(session.getAttribute("alogin")==null)
{ 
	response.sendRedirect("../index.jsp");
}
else
{

%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Online Library Management System | Manage Issued Books</title>
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
                <h4 class="header-line">Manage Issued Book</h4>
    </div>
     <div class="row">
    <% String error=(String)session.getAttribute("error");
	if(error!=null)
    {%>
<div class="col-md-6">
<div class="alert alert-danger" >
 <strong>Error :</strong> 
 <%=error%>
<% session.setAttribute("error",null); %>
</div>
</div>
<% } %>
<% 
	String msg=(String)session.getAttribute("msg");
if(msg!=null)
{%>
<div class="col-md-6">
<div class="alert alert-success" >
 <strong>Success :</strong> 
 <%=msg%>
<% session.setAttribute("msg",null); %>
</div>
</div>
<% } %>

   <% 
	String delmsg=(String)session.getAttribute("delmsg");	
if(delmsg!=null)
    {%>
<div class="col-md-6">
<div class="alert alert-success" >
 <strong>Success :</strong> 
 <%=delmsg%>
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
                          Issued Books 
                        </div>
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Student Name</th>
                                            <th>Book Name</th>
                                            <th>ISBN </th>
                                            <th>Issued Date</th>
                                            <th>Return Date</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
<%
	String url = "jdbc:mysql://localhost:3306/library","root","admin";
String username = "your_username";
String password = "your_password";

try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection(url, username, password);

    String sql = "SELECT tblstudents.FullName,tblbooks.BookName,tblbooks.ISBNNumber,tblissuedbookdetails.IssuesDate,tblissuedbookdetails.ReturnDate,tblissuedbookdetails.id as rid from  tblissuedbookdetails join tblstudents on tblstudents.StudentId=tblissuedbookdetails.StudentId join tblbooks on tblbooks.id=tblissuedbookdetails.BookId order by tblissuedbookdetails.id desc";
    PreparedStatement ps = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
    ResultSet rs = ps.executeQuery();

    int cnt = 1;
    while (rs.next()) {
        // your code here
    }
} catch (SQLException | ClassNotFoundException e) {
    e.printStackTrace();
}


 %>                                      
                                        <tr class="odd gradeX">
                                            <td class="center"><%=cnt%></td>
                                            <td class="center"><%=rs.getString("FullName")%></td>
                                            <td class="center"><%=rs.getString("BookName")%></td>
                                            <td class="center"><%=rs.getString("ISBNNumber")%></td>
                                            <td class="center"><%=rs.getString("IssuesDate")%></td>
                                            <td class="center"><% if(rs.getString("ReturnDate")==null)
                                            {
                                                out.println("Not Return Yet");
                                            } else {


                                            out.println(rs.getString("ReturnDate"));
						}
                                            %></td>
                                            <td class="center">

                                            <a href="update-issue-bookdeails.jsp?rid=<%=rs.getInt("rid")%>"><button class="btn btn-primary"><i class="fa fa-edit "></i> Edit</button> 
                                         
                                            </td>
                                        </tr>
 <% cnt=cnt+1;} %>                                      
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
<% } %>
