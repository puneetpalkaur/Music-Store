<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Music Store</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<link href="template.css" rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato">
<link rel="stylesheet" href="template.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://www.w3schools.com/lib/w3.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body onload="searchCustomerMethod()" >
       
<%
//allow access only if session exists
String user = null;
if(session.getAttribute("user") == null)
{
/* 	request.getSession().setAttribute("loginErrorMessage", "Please login to view profile!");
	request.getRequestDispatcher("/index.jsp").forward(request, response); */
}
else user = (String) session.getAttribute("user");
String userName = null;
String sessionID = null;
Cookie[] cookies = request.getCookies();
if(cookies !=null){
for(Cookie cookie : cookies){
	if(cookie.getName().equals("user")) userName = cookie.getValue();
	if(cookie.getName().equals("JSESSIONID")) sessionID = cookie.getValue();
}
}
else
{
	sessionID = session.getId();
}
%>
<div class="w3-top">
<div class="w3-display-container w3-center" style="display: none; color:white;">
 
 </div>
  <div class="w3-bar w3-black w3-card" >
    <a class="w3-bar-item w3-button w3-padding-large w3-hide-medium w3-hide-large w3-right" href="javascript:void(0)" onclick="myFunction()" title="Toggle Navigation Menu"><i class="fa fa-bars"></i></a>
    <a href="index.jsp" class="w3-bar-item w3-button w3-padding-large">HOME</a>
    <a href="DisplayShoppingCart.jsp" class="w3-bar-item w3-button w3-padding-large w3-hide-small">SHOPPING CART</a>
    <a href="viewprofile.jsp" class="w3-bar-item w3-button w3-padding-large w3-hide-small">PROFILE</a>
    <a href="contact.jsp" class="w3-bar-item w3-button w3-padding-large w3-hide-small">CONTACT</a>
       <%if(session.getAttribute("user") == null)
 {
		%>
		 <a href="login.jsp" class="w3-bar-item w3-button w3-padding-large w3-hide-small" style="float:right;">LOGIN</a>
		<%
	} 
 else
 {
	 %>
	<form name="loginForm" method="post" action="Logout">
 			<input class="w3-bar-item w3-button w3-padding-large w3-hide-small" style="float:right;" type="submit" name="Logout" value="LOGOUT" />
            </form> 
	<%
 }
	%>  
    
    
  </div>
</div>

<!-- Page content -->
  <!-- The Band Section -->
  <div class="bgimg w3-black" id="tour">
  <div class=" w3-container w3-content w3-center w3-padding-64" style="max-width:800px" id="band">
  
 <h2 class="w3-wide">THE MUSIC STORE</h2>
   <p class="w3-opacity"><i> Search your favorite Music, Artist, Album.</i></p>
    <br/>
  
     <%if(userName != null)
 {
		%>
		  <p class="w3-left"> <h3>Hi <%=userName.substring(0,1).toUpperCase()+userName.substring(1,userName.indexOf('@'))   %>!</h3></p>
		<%
	} %>
  
   
   <br/>
    <br/>
    </div>

      <p class="w3-opacity w3-center"><i></i></p><br>
<br>


</div>

	<div class="w3-center" style="text-align:center">

<%@ page import="java.net.*,java.text.*,shop.cart.*,java.sql.Connection,java.sql.DriverManager,java.sql.Statement,java.sql.ResultSet" %>
		<%!
		String firstName = "";
		String lastName = "";
		String address = "";
		String email = "";
		String city = "";
		String state = "";
		String country = "";
		String postalCode = "";
		String phone = "";
		String fax = "";
		String company = "";
		String error= "Log in to View Profile";
		public void searchCustomerMethod()
		{
			System.out.print("running search cust method");
		%>
		<%
		if(user != null)
		{
			
			System.out.println(" user is "+user);
			DriverManager.registerDriver(new com.mysql.jdbc.Driver ());
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/chinook", "root", "Pass");
			 System.out.println(" connected");
	        Statement st = null;
			ResultSet rs = null;
			st = conn.createStatement();
			System.out.println(" connected 1");
			rs = st.executeQuery("select * from employee where Email LIKE '"+user+"'");
			 if (rs.next()) 
			 { 
			   //get values from database
			   System.out.println(" get values from database");
		       firstName = rs.getString("FirstName")!=null?rs.getString("FirstName"):"";
		       lastName = rs.getString("LastName")!=null?rs.getString("LastName"):"";
		       address = rs.getString("Address")!=null?rs.getString("Address"):"";
		       city = rs.getString("City")!= null?rs.getString("City"):"";
		       state = rs.getString("State")!=null?rs.getString("State"):"";
		       postalCode = rs.getString("PostalCode")!=null?rs.getString("PostalCode"):"";
		       country = rs.getString("Country")!=null?rs.getString("Country"):"";
		       phone = rs.getString("Phone")!=null?rs.getString("Phone"):"";
		    
		       fax = rs.getString("Fax")!= null?rs.getString("Fax"):"";
			    System.out.println(" set values for attributes");
		      request.setAttribute("firstName",firstName);
		      request.setAttribute("lastName", lastName);
		      request.setAttribute("email", user);
		      request.setAttribute("address", address);
		      request.setAttribute("city", city);
		      request.setAttribute("state", state);
		      request.setAttribute("postalCode", postalCode);
		      request.setAttribute("country", country);
		      request.setAttribute("phone", phone);
		      request.setAttribute("fax", fax);
		   
		      %>
		      <table style="text-align:left;">
<tr><td>Email Address:</td><td><%=email%>
</td>

</tr>



<tr><td>First Name:</td><td><%=firstName%>
</td> 
</tr>
<tr><td>Last Name:</td><td><%=lastName%>
</td> 
</tr>

</tr>
<tr><td>Address:</td><td><%=address%></td>
</tr>

<tr><td>City:</td><td><%=city%></td></tr>
    <td>State:</td>
    <td><%=state%></td></tr>
<tr><td>Postal Code:</td>
    <td><%=postalCode%></td></tr>
<tr><td>Country:</td><td><%=country%></td></tr>
<tr><td>Phone:</td><td><%=phone%></td></tr>
<tr><td>Fax :</td><td><%=fax%></td></tr>

<tr></tr>

</table>
		      <%
			 }
			 else
			 {
				%>  <div style="color: white; font-size: 20px"> <% request.setAttribute("error", error); %></div>
				 <%
			 }
		     
		}
	 %>
		<%! }%>
<%@ page language="java" import="shop.cart.*,java.util.*,java.text.*" %>


<p>

<p>

<p>

  <h2 class="w3-wide w3-center"><%=error %></h2>





	  </div>
            
            <div class="templatemo_right_panel_fullwidth">
                <div id="news_section">
                  
                </div> <!-- end of news -->
                
                
			</div>                
    
<jsp:include page="footer.jsp"></jsp:include>
<!-- need to encode all the URLs where we want session information to be passed 
<a href="<%=response.encodeURL("viewprofile.jsp") %>">Checkout Page</a>
<form action="<%=response.encodeURL("LogoutServlet")%>" method="post">
<input type="submit" value="Logout" >
</form> -->

</body>
</html>
