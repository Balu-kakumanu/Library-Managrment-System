<%@page import="java.sql.*"%>
<%
String login=request.getParameter("login");
String vercode=request.getParameter("vercode");
String vercode1=(String)session.getAttribute("vercode");
if(session.getAttribute("alogin")==null)
{
	session.setAttribute("alogin",null);
}
if(login!=null)
{
	 //code for captcha verification
	if(!vercode.equals(vercode1))  
	{                       
        	out.println( "<script>alert('Incorrect verification code');</script>") ;
    	} 
        else {
                String username=request.getParameter("username");
                String password=request.getParameter("password");
        try{

            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/library","root","admin");
            PreparedStatement ps=conn.prepareStatement("select UserName, Password from admin where UserName='"+username+"' AND Password='"+password+"'");
            ResultSet rs=ps.executeQuery();

        if(rs.next())
        {
            session.setAttribute("alogin",username);

            out.println("<script type='text/javascript'> document.location ='admin/dashboard.jsp'; </script>");
        } 
        else
        {
            out.println("<script>alert('Invalid Details');</script>");
        }
    }
	catch(Exception e)
    {
        out.println(e);
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
    <title>Online Library Management System</title>
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
<h4 class="header-line">ADMIN LOGIN FORM</h4>
</div>
</div>
             
<!--LOGIN PANEL START-->           
<div class="row">
<div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3" >
<div class="panel panel-info">
<div class="panel-heading">
 LOGIN FORM
</div>
<div class="panel-body">
<form role="form" method="post">

<div class="form-group">
<label>Enter Username</label>
<input class="form-control" type="text" name="username" autocomplete="off" required />
</div>
<div class="form-group">
<label>Password</label>
<input class="form-control" type="password" name="password" autocomplete="off" required />
</div>
 <div class="form-group">
<label>Verification code : </label>
<input type="text"  name="vercode" maxlength="6" autocomplete="off" required style="width: 150px; height: 25px;" />&nbsp;<img src="Captcha.jpg">
</div>  

 <button type="submit" name="login" value="login" class="btn btn-info">LOGIN </button>
</form>
 </div>
</div>
</div>
</div>  
<!---LOGIN PABNEL END-->            
             
 
    </div>
    </div>
     <!-- CONTENT-WRAPPER SECTION END-->
	<jsp:include page="includes/footer.jsp" />
      <!-- FOOTER SECTION END-->
    <script src="assets/js/jquery-1.10.2.js"></script>
    <!-- BOOTSTRAP SCRIPTS  -->
    <script src="assets/js/bootstrap.js"></script>
      <!-- CUSTOM SCRIPTS  -->
    <script src="assets/js/custom.js"></script>
</script>
</body>
</html>
