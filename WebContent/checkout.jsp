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
<body>
       
<%
//allow access only if session exists
String user = null;
if(session.getAttribute("user") == null)
{
	request.getSession().setAttribute("purchaseErrorMessage", "Please login to complete the purchase!");
	request.getRequestDispatcher("/DisplayShoppingCart.jsp").forward(request, response);
	//response.sendRedirect("DisplayShoppingCart.jsp");
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
            	
            	
 <%@ page language="java" import="shop.cart.*,java.util.*,java.text.*" %>

<%-- Show the header with the shopping cart image --%>
<table border="0">
<tr><td><img src="images/cart4.png" width="50" height="50"><td><h1>Shopping Cart</h1>
</table>

<%
// Get the current shopping cart from the user's session.
    ShoppingCart cart = (ShoppingCart) session.getAttribute("ShoppingCart");

// If the user doesn't have a shopping cart yet, create one.
    if (cart == null)
    {
        cart = new ShoppingCart();
        session.setAttribute("ShoppingCart", cart);
    }

// Get the items from the cart.
    Vector items = cart.getItems();
    double totalPrice = 0;
// If there are no items, tell the user that the cart is empty.
    if (items.size() == 0)
    {
        out.println("<h3>Your shopping cart is empty.</h3>");
    }
    else
    {
%>
<%-- Display the header for the shopping cart table --%>
<br>
<table border=4>
<tr><th>Description</th><th>Quantity</th><th>Price</th></tr>
<%

        int numItems = items.size();
		
// Get a formatter to write out currency values.
        NumberFormat currency = NumberFormat.getCurrencyInstance();

        for (int i=0; i < numItems; i++)
        {
            Item item = (Item) items.elementAt(i);

// Print the table row for the item.
            out.print("<tr><td>");
            out.print(item.description);
            out.print("</td><td>");
            out.print(item.orderQuantity);
            out.print("</td><td>");
            out.print(currency.format(item.price));
            totalPrice = totalPrice +item.price;

        }
        %>
       <tr><th>Total</th><th></th><th><%out.print(currency.format(totalPrice)); %></th></tr>
        <%
        
        
    }
%>
       
</table>  
<h1></h1>
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
		public void searchCustomerMethod()
		{
			System.out.print("running search cust method");
		%>
		<%
		if(request.getParameter("email")!= null)
		{
			email = request.getParameter("email");
			System.out.println(" email is "+email);
			DriverManager.registerDriver(new com.mysql.jdbc.Driver ());
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/chinook", "root", "Pass");
	        Statement st = null;
			ResultSet rs = null;
			st = conn.createStatement();
			rs = st.executeQuery("select * from customer where Email LIKE '"+email+"'");
			 if (rs.next()) 
			 { 
			   //get values from database
		       firstName = rs.getString("FirstName")!=null?rs.getString("FirstName"):"";
		       lastName = rs.getString("LastName")!=null?rs.getString("LastName"):"";
		       address = rs.getString("Address")!=null?rs.getString("Address"):"";
		       city = rs.getString("City")!= null?rs.getString("City"):"";
		       state = rs.getString("State")!=null?rs.getString("State"):"";
		       postalCode = rs.getString("PostalCode")!=null?rs.getString("PostalCode"):"";
		       country = rs.getString("Country")!=null?rs.getString("Country"):"";
		       phone = rs.getString("Phone")!=null?rs.getString("Phone"):"";
		       company = rs.getString("Company")!= null?rs.getString("Company"):"";
		       fax = rs.getString("Fax")!= null?rs.getString("Fax"):"";
			      
		       //set values
		      request.setAttribute("firstName",firstName);
		      request.setAttribute("lastName", lastName);
		      request.setAttribute("email", email);
		      request.setAttribute("address", address);
		      request.setAttribute("city", city);
		      request.setAttribute("state", state);
		      request.setAttribute("postalCode", postalCode);
		      request.setAttribute("country", country);
		      request.setAttribute("phone", phone);
		      request.setAttribute("fax", fax);
		      request.setAttribute("totalPrice", totalPrice);
		      request.setAttribute("company", company);
			 }
			 else
			 {
				%>  <div style="color: white; font-size: 20px"> <% out.print("Customer does not exist"); %></div>
				 <%
			 }
		     
		}
	 %>
		<%! }%>
<%@ page language="java" import="shop.cart.*,java.util.*,java.text.*" %>


<p>
<%-- <jsp:include page="DisplayShoppingCart.jsp" flush="true"/> --%>
<p>
<h1>Please enter your shipping information</h1>
<p>

<form onsubmit="searchCustomerMethod();" >
<table>
<tr><td>Email Address:</td><td><input type="text" name="email" id="email" value="<%=email%>">
</td>
<td><button class="button" name="Search" type="submit" onclick="searchCustomerMethod();" style="float: right">Search</button></form></td>
</tr>
<form action="CustomerInfoServlet" method="post" >
<tr><td><input type="hidden" name="email" value="<%=email%>"></td></tr>
<tr><td>First Name:</td><td><input type="text" name="firstName"  value="<%=firstName%>">
</td> 
</tr>
<tr><td>Last Name:</td><td><input type="text" name="lastName"  value="<%=lastName%>">
</td> 
</tr>
<tr><td>Company:</td><td><input type="text" name="company" value="<%=company%>"></td>
</tr>
<tr><td>Address:</td><td><input type="text" name="address" value="<%=address%>"></td>
</tr>

<tr><td>City:</td><td><input type="text" name="city" value="<%=city%>"></td></tr>
    <td>State:</td>
    <td><input type="text" name="state" size=2 maxlength=2 value="<%=state%>"></td></tr>
<tr><td>Postal Code:</td>
    <td><input type="text" name="postalCode" value="<%=postalCode%>"></td></tr>
<tr><td>Country:</td><td><input type="text" name="country" value="<%=country%>"></td></tr>
<tr><td>Phone:</td><td><input type="text" name="phone" value="<%=phone%>"></td></tr>
<tr><td>Fax :</td><td><input type="text" name="fax" value="<%=fax%>"></td></tr>
<tr><td><input type="hidden" name="totalPrice" value="<%=totalPrice%>"></td></tr>
<tr></tr>

</table>


<input type="submit" value="Complete Order">
</form>

	  </div>
            
            <div class="templatemo_right_panel_fullwidth">
                <div id="news_section">
                  
                </div> <!-- end of news -->
                
                
			</div>                
    
<jsp:include page="footer.jsp"></jsp:include>
<!-- need to encode all the URLs where we want session information to be passed 
<a href="<%=response.encodeURL("CheckoutPage.jsp") %>">Checkout Page</a>
<form action="<%=response.encodeURL("LogoutServlet")%>" method="post">
<input type="submit" value="Logout" >
</form> -->

</body>
</html>
