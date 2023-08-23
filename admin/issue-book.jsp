<%@page import="java.sql.*,java.text.DateFormat,java.text.SimpleDateFormat,java.util.Date"%>
<%!
    public static String getDate() {
        DateFormat df = new SimpleDateFormat("d-MMM-yyyy");
        String exam_date = df.format(new Date());
        return exam_date;
    }
%>
<%
    PreparedStatement ps = null;
    Connection conn = null;
    ResultSet rs = null;
    conn = (Connection) application.getAttribute("connection");

    if (session.getAttribute("alogin") == null) {
        response.sendRedirect("../index.jsp");
    } else {
        String issue = request.getParameter("issue");
        if (issue != null) {
            try {
                // Get the parameter values from the request
                String studentid = request.getParameter("studentid");
                String bookid = request.getParameter("bookdetails");

                // Create the prepared statement with the desired SQL query
                String sql = "INSERT INTO tblissuedbookdetails (StudentID, BookId, IssuesDate) VALUES (?, ?, ?)";
                ps = conn.prepareStatement(sql);

                // Set the parameters for the prepared statement
                ps.setString(1, studentid);
                ps.setInt(2, Integer.parseInt(bookid));
                ps.setString(3, getDate());

                // Execute the update and retrieve the number of affected rows
                int i = ps.executeUpdate();

                if (i > 0) {
                    // Set a message attribute indicating success
                    session.setAttribute("msg", "Book issued successfully");
                    response.sendRedirect("manage-issued-books.jsp");
                } else {
                    // Set an error attribute indicating failure
                    session.setAttribute("error", "Something went wrong. Please try again");
                    response.sendRedirect("manage-issued-books.jsp");
                }

            } catch (SQLException e) {
                out.println(e); // Handle any SQL errors
            } finally {
                try {
                    if (ps != null) {
                        ps.close();
                    }
                } catch (SQLException e) {
                    out.println(e);
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
    <title>Online Library Management System | Issue a new Book</title>
    <!-- BOOTSTRAP CORE STYLE  -->
    <link href="assets/css/bootstrap.css" rel="stylesheet" />
    <!-- FONT AWESOME STYLE  -->
    <link href="assets/css/font-awesome.css" rel="stylesheet" />
    <!-- CUSTOM STYLE  -->
    <link href="assets/css/style.css" rel="stylesheet" />
    <!-- GOOGLE FONT -->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
    <script>
        // function for get student name
        function getstudent() {
            $("#loaderIcon").show();
            jQuery.ajax({
                url: "get_student.jsp",
                data: 'studentid=' + $("#studentid").val(),
                type: "POST",
                success: function (data) {
                    $("#get_student_name").html(data);
                    $("#loaderIcon").hide();
                },
                error: function () { }
            });
        }

        //function for book details
        function getbook() {
            $("#loaderIcon").show();
            jQuery.ajax({
                url: "get_book.jsp",
                data: 'bookid=' + $("#bookid").val(),
                type: "POST",
                success: function (data) {
                    $("#get_book_name").html(data);
                    $("#loaderIcon").hide();
                },
                error: function () { }
            });
        }
    </script>
    <style type="text/css">
        .others {
            color: red;
        }
    </style>
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
                        <h4 class="header-line">Issue a New Book</h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-10 col-sm-6 col-xs-12 col-md-offset-1">
                        <div class="panel panel-info">
                            <div class="panel-heading">
                                Issue a New Book
                            </div>
                            <div class="panel-body">
                                <form role="form" method="post">
                                    <div class="form-group">
                                        <label>Student ID<span style="color:red;">*</span></label>
                                        <input class="form-control" type="text" name="studentid" id="studentid" onBlur="getstudent()" autocomplete="off" required />
                                    </div>
                                    <div class="form-group">
                                        <span id="get_student_name" style="font-size:16px;"></span>
                                    </div>
                                    <div class="form-group">
                                        <label>ISBN Number or Book Title<span style="color:red;">*</span></label>
                                        <input class="form-control" type="text" name="bookid" id="bookid" onBlur="getbook()" required="required" />
                                    </div>
                                    <div class="form-group">
                                        <select class="form-control" name="bookdetails" id="get_book_name" readonly>
                                        </select>
                                    </div>
                                    <button type="submit" name="issue" value="issue" id="submit" class="btn btn-info">Issue Book</button>
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
