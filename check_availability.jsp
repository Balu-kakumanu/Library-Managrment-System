<%@page errorPage="error.jsp"%>
<%@page import="java.sql.*"%>

<% 
// code user email availablity
String emailid=request.getParameter("emailid");
if(emailid!=null) {

	int index1=emailid.indexOf("@");
	int index2=emailid.lastIndexOf(".");
	if (index1==-1 || index2==-1 || index1>index2)
	{

		out.println("error : You did not enter a valid email.");
	}
	else 
	{
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/library", "root", "admin");
			String sql ="SELECT EmailId FROM tblstudents WHERE EmailId=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, emailid);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				out.println("<span style='color:red'> Email already exists .</span>");
				out.println("<script>$('#submit').prop('disabled',true);</script>");
			} else {
				out.println("<span style='color:green'> Email available for Registration .</span>");
				out.println("<script>$('#submit').prop('disabled',false);</script>");
			}
			conn.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
		e.printStackTrace();
		}
	}
}

%>
