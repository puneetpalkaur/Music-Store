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

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato">
<link rel="stylesheet" href="template.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://www.w3schools.com/lib/w3.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Music Store</title>
<meta name="keywords" content="" />
<meta name="description" content="" />

</head>
<body>
    
<%
//allow access only if session exists
String user = null;
if(session.getAttribute("user") == null)
{
	//response.sendRedirect("index.html");
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

<input type="hidden" id="refreshed" value="no">
<script type="text/javascript">
onload=function(){
var e=document.getElementById("refreshed");
if(e.value=="no")e.value="yes";
else{e.value="no";location.reload();}
}
</script>
			
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
            	
            	
       	<%@ page language="java" import="shop.cart.*,java.net.*,java.text.*,java.util.*,java.lang.*" %>



<%
// Initialize the array of available products.
  ShoppingCart cart = (ShoppingCart) session.getAttribute("ShoppingCart");
	Vector items = cart.getItems();
    
%>


<form name="loginForm" method="post" action="DisplayShoppingCart.jsp">
 			<input class="w3-bar-item w3-button w3-padding-large w3-hide-small w3-center" style="text-align:center;" type="submit" name="Logout" value="View Shopping Cart" />
            </form> 
<br>
<p>
<h1>Available Products</h1>
<table border="1">
<tr><th style="background-color: white">Description</th><th style="background-color: white">Quantity</th><th style="background-color: white">Price</th></tr>
<%

// Get a currency formatter for showing the price.
    NumberFormat currency = NumberFormat.getCurrencyInstance();
    int qty = 0 ;

    for (int i=0; i < items.size(); i++)
    {	
    
    	     Item item = (Item) items.elementAt(i);
  			// System.out.println("for item "+item.getProductCode());
			 qty = item.getQuantity();
			
		// Create the URL for adding the item to the shopping cart.
        String addItemURL =
            "AddToShoppingCartServlet?"+
            "productCode="+URLEncoder.encode(item.getProductCode())+
            "&description="+URLEncoder.encode(item.getDescription())+
            "&quantity="+URLEncoder.encode(""+qty)+
            "&price="+URLEncoder.encode(""+item.getPrice());
%>
<tr><td><%=item.getDescription()%></td><td><%=item.orderQuantity%>
    </td><td><%=currency.format(item.getPrice())%></td>
<td > <a href="<%=addItemURL%>" style="black">Click to Increase Quantity</a></h3></td></tr>
<%
    }
%>
</table>

	  </div>
            
            <div class="templatemo_right_panel_fullwidth">
                <div id="news_section">
                <br>
                  <button type="button" name="back" onclick="history.back()">Go Back</button>
                </div> 
                
                
			</div>                
            
		</div>
    </div>  
	
<!-- need to encode all the URLs where we want session information to be passed 
<a href="<%=response.encodeURL("CheckoutPage.jsp") %>">Checkout Page</a>
<form action="<%=response.encodeURL("LogoutServlet")%>" method="post">
<input type="submit" value="Logout" >
</form> -->
<jsp:include page="footer.jsp"></jsp:include>
