<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="template.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://www.w3schools.com/lib/w3.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<title>Music Store</title>
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
  <div class="w3-top">
<div class="w3-display-container w3-center" style="display: none; color:white;">
 
 </div>
  <div class="w3-bar w3-black w3-card" >
    <a class="w3-bar-item w3-button w3-padding-large w3-hide-medium w3-hide-large w3-right" href="javascript:void(0)" onclick="myFunction()" title="Toggle Navigation Menu"><i class="fa fa-bars"></i></a>
    <a href="index.jsp" class="w3-bar-item w3-button w3-padding-large">HOME</a>
    <a href="DisplayShoppingCart.jsp" class="w3-bar-item w3-button w3-padding-large w3-hide-small">SHOPPING CART</a>
    <a href="viewprofile.jsp" class="w3-bar-item w3-button w3-padding-large w3-hide-small">PROFILE</a>
    <a href="contact.jsp" class="w3-bar-item w3-button w3-padding-large w3-hide-small">CONTACT</a>
   <% if(session.getAttribute("user") == null ||session.getAttribute("user") == "")
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
  
        
 <div class="w3-center ">
            <h2 class="w3-wide w3-center">LOGIN</h2>
            
           
               <form name="myloginForm" method="post" action="loginServlet" class="myloginForm">
                <br><br>
                
                 <input class="inputfield w3-input" name="username" type="text" id="email_address" required placeholder="Username"/><br><br>
                   <input class="inputfield w3-input" name="password" type="password" id="password" required placeholder="Password"/><br>
                   <br>
                  <input class="button w3-button" type="submit" name="Submit" value="Login" />
              
                </form>
                
                
                
                <br>
          <div style="color: #FF0000; float: right; font-size:150%">${errorMessage}</div>
          </div>
</body>
</html>