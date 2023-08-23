<%@page import="java.sql.*,java.text.DateFormat,java.text.SimpleDateFormat,java.util.Date"%>
<%!
	public static String getDate()
    
	{
        
		DateFormat df=new SimpleDateFormat("d-MMM-yyyy");
        
		String exam_date=df.format(new Date());
         
		return exam_date;
    
	}
%>
<%
	PreparedStatement ps;
        Connection conn;
        ResultSet rs= null;
        ResultSet rs1= null;
        ResultSet rs2= null;
        conn=(Connection)application.getAttribute("connection");
%>

<%

if(session.getAttribute("alogin")==null)
{ 
	response.sendRedirect("../index.jsp");
}
else
{ 
	String update=request.getParameter("update");
	if(update!=null)
	{
        try
         {
            Class.forName("com.mysql.jdbc.Driver");
           Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/library","root","admin");

            String bookname = request.getParameter("bookname");
            String category = request.getParameter("category");
            String author = request.getParameter("author");
            String isbn = request.getParameter("isbn");
            String price = request.getParameter("price");
            String bookid = request.getParameter("bookid");
            String sql = "UPDATE tblbooks SET BookName=?, CatId=?, AuthorId=?, ISBNNumber=?, BookPrice=?, UpdationDate=? WHERE id=?";
           PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, bookname);
            ps.setInt(2, Integer.parseInt(category));
            ps.setInt(3, Integer.parseInt(author));
            ps.setInt(4, Integer.parseInt(isbn));
            ps.setInt(5, Integer.parseInt(price));
            ps.setString(6, getDate());
            ps.setInt(7, Integer.parseInt(bookid));
            int i = ps.executeUpdate();

            session.setAttribute("msg","Book Info updated successfully");
            response.sendRedirect("manage-books.jsp");

            con.close(); 
        }
        catch (Exception e) 
        {
            System.out.println(e);
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
    <title>Online Library Management System | Edit Book</title>
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
    <div class="content-wra">
    <div class="content-wrapper">
         <div class="container">
        <div class="row pad-botm">
            <div class="col-md-12">
                <h4 class="header-line">Add Book</h4>
                
                            </div>

</div>
<div class="row">
<div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
<div class="panel panel-info">
<div class="panel-heading">
Book Info
</div>
<div class="panel-body">
<form role="form" method="post">
<% 
	int bookid=Integer.parseInt(request.getParameter("bookid"));
	try {
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/library","root","admin");
PrepareStatement ps = conn.prepareStatement("SELECT tblbooks.BookName,tblcategory.CategoryName,tblcategory.id as cid,tblauthors.AuthorName,tblauthors.id as athrid,tblbooks.ISBNNumber,tblbooks.BookPrice,tblbooks.id as bookid from tblbooks join tblcategory on tblcategory.id=tblbooks.CatId join tblauthors on tblauthors.id=tblbooks.AuthorId where tblbooks.id=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
ps.setInt(1, bookid);
rs = ps.executeQuery();


int cnt = 1;
} catch (ClassNotFoundException e) {
e.printStackTrace();
} catch (SQLException e) {
e.printStackTrace();
} 
	while(rs.next())
	{

%>  

<div class="form-group">
<label>Book Name<span style="color:red;">*</span></label>
<input class="form-control" type="text" name="bookname" value="<%=rs.getString("BookName")%>" required />
</div>

<div class="form-group">
<label> Category<span style="color:red;">*</span></label>
<select class="form-control" name="category" required="required">
<option value="<%=rs.getString("cid")%>"> <% String catname=rs.getString("CategoryName"); out.println(catname); %></option>
<% 
int status=1;
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/library","root","admin");
PrepareStatement ps = conn.prepareStatement("SELECT * from  tblcategory where Status=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
ps.setInt(1,status);
    rs1=ps.executeQuery();


int cnt = 1;
} catch (ClassNotFoundException e) {
e.printStackTrace();
} catch (SQLException e) {
e.printStackTrace();
} 

	while(rs1.next())
	{

         
		if(catname.equalsIgnoreCase(rs1.getString("CategoryName")))
		{
			continue;
		}	
		else
		{
  %>  
<option value="<%=rs1.getString("id")%>"><%=rs1.getString("CategoryName")%></option>
 <% }} %> 
</select>
</div>


<div class="form-group">
<label> Author<span style="color:red;">*</span></label>
<select class="form-control" name="author" required="required">
<option value="<%=rs.getString("athrid")%>"> <% String athrname=rs.getString("AuthorName"); out.println(athrname); %></option>
<% 
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/library","root","admin");
PrepareStatement ps = conn.prepareStatement("SELECT * from  tblauthors ", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
ps.setInt(1,status);
rs2=ps.executeQuery();
int cnt = 1;
} catch (ClassNotFoundException e) {
e.printStackTrace();
} catch (SQLException e) {
e.printStackTrace();
} 

while(rs2.next())
{

	if(athrname.equalsIgnoreCase(rs2.getString("AuthorName")))
	{
		continue;
	} 
	else
	{

    %>  
<option value="<%=rs2.getString("id")%>"><%=rs2.getString("AuthorName")%></option>
 <% }} %> 
</select>
</div>

<div class="form-group">
<label>ISBN Number<span style="color:red;">*</span></label>
<input class="form-control" type="text" name="isbn" value="<%=rs.getString("ISBNNumber")%>"  required="required" />
<p class="help-block">An ISBN is an International Standard Book Number.ISBN Must be unique</p>
</div>

 <div class="form-group">
 <label>Price in USD<span style="color:red;">*</span></label>
 <input class="form-control" type="text" name="price" value="<%=rs.getString("BookPrice")%>"   required="required" />
 </div>
 <% } %>
<button type="submit" name="update" class="btn btn-info">Update </button>

                                    </form>
                            </div>
                        </div>
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
      <!-- CUSTOM SCRIPTS  -->
    <script src="assets/js/custom.js"></script>
</body>
</html>
<% } %>
