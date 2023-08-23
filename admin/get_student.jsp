<%@page import="java.sql.*"%>
<%
	PreparedStatement ps;
ResultSet rs = null;

String url = "jdbc:mysql://localhost:3306/library","root","admin";
String username = "your_username";
String password = "your_password";

try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection(url, username, password);
    application.setAttribute("connection", conn);

} catch (SQLException | ClassNotFoundException e) {
    e.printStackTrace();
}

%>

<%
String studentid=request.getParameter("studentid");

if(studentid!=null)
{
	studentid=studentid.toUpperCase();
 
	String sql ="SELECT FullName,Status FROM tblstudents WHERE StudentId=?";
	ps=conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	ps.setString(1,studentid);
	rs=ps.executeQuery();

	if(rs.next())
	{
		if(Integer.parseInt(rs.getString("Status"))==0)
		{
			out.println("<span style='color:red'> Student ID Blocked </span> .<br />");
			out.println("<b>Student Name-</b> "+rs.getString("FullName"));	
			out.println("<script>$('#submit').prop('disabled',true);</script>");
		}
		else 
		{
  
			out.println("<span style='color:green'>"+rs.getString("FullName")+"</span>");
			out.println("<script>$('#submit').prop('disabled',false);</script>");

		}
	}
	else
	{
  
		out.println("<span style='color:red'> Invaid Student Id. Please Enter Valid Student id .</span>");
		out.println("<script>$('#submit').prop('disabled',true);</script>");
	}
}

%>
