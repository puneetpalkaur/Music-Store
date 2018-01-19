<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Music Store</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<link href="template.css" rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="template.css" rel="stylesheet" type="text/css" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato">
<link rel="stylesheet" href="template.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://www.w3schools.com/lib/w3.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 <script>
function myFunction() {
   // window.print();
    var printContents = document.getElementById('news_section').innerHTML;
    var originalContents = document.body.innerHTML;

    document.body.innerHTML = printContents;

    window.print();

    document.body.innerHTML = originalContents;
}
</script>
</head>
<body>

<div class="w3-top">
<div class="w3-display-container w3-center" style="display: none; color:white;">
 
 </div>
  <div class="w3-bar w3-black w3-card" >
    <a class="w3-bar-item w3-button w3-padding-large w3-hide-medium w3-hide-large w3-right" href="javascript:void(0)" onclick="myFunction()" title="Toggle Navigation Menu"><i class="fa fa-bars"></i></a>
    <a href="index.jsp" class="w3-bar-item w3-button w3-padding-large">HOME</a>
    <a href="DisplayShoppingCart.jsp" class="w3-bar-item w3-button w3-padding-large w3-hide-small">SHOPPING CART</a>
    <a href="viewprofile.jsp" class="w3-bar-item w3-button w3-padding-large w3-hide-small">PROFILE</a>
    <a href="contact.jsp" class="w3-bar-item w3-button w3-padding-large w3-hide-small">CONTACT</a>
    <a href="Login.jsp" class="w3-bar-item w3-button w3-padding-large w3-hide-small" style="float:right;">LOGIN</a>
    
    
  </div>
</div>

<!-- Page content -->
  <!-- The Band Section -->
  <div class="bgimg w3-black" id="tour">
  <div class=" w3-container w3-content w3-center w3-padding-64" style="max-width:800px" id="band">
  
    <h2 class="w3-wide">THE MUSIC STORE</h2>
    <p class="w3-opacity"><i> Search your favorite Music, Artist, Album.</i></p>
    <p class="w3-justify">
   <br/>
    <br/>
    </div>

      <p class="w3-opacity w3-center"><i></i></p><br>
<br>


</div>
   
    <div class="w3-center" style="text-align:center;">
            
           
                <div id="loginForm">
                  <h1 style="font-size: 18px "><strong>Order Completed Successfully ! </strong></h1>
					 <div style=" font-size:100%;color:Black;">
					 Invoice Number : ${invoiceId}
					 <br><br>
					 Amount Paid : ${total}
					 <br><br>
					 First Name : ${firstName}
					 <br><br>
					 Last Name : ${lastName}
					 <br><br>
					 Company : ${company}
					 <br><br>
					 Address : ${address}
					 <br><br>
					 City : ${city}
					 <br><br>
					 State : ${state}
					 <br><br>
					 Country : ${country}
					 <br><br>
					 Postal Code : ${postalCode}
					 <br><br>
					 Phone : ${phone}
					 <br><br>
					 Fax : ${fax}
					 <br><br>
					 Email : ${email}
					 <br><br>
					 </div>
                     <div class="news_box">
                       <input type="button" value="Print" style="background-color: White ; font-weight: bold" onClick="myFunction();"  />
                    </div>
                    <div class="more_button" style="margin-left:15px;"></div>
                </div> <!-- end of news -->
                </div>
		               
            
	

<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>