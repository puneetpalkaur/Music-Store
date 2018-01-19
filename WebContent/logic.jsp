<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>W3.CSS Template</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato">
<link href="template.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://www.w3schools.com/lib/w3.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
</head>
<body>
<div class="w3-content" style="max-width:2000px;margin-top:46px">

     <div class="w3-bar" style="text-align: left;">
                <form method="post" >
        	
       			<select name ="SearchBy" class="w3-select w3-bar-item w3-black w3-round-xxlarge select " style="-webkit-appearance: none;">
        		<option selected="selected" >Search By</option>
        		<option>Artist</option>
        		<option>Album</option>
        		<option >Track</option>
        		<option>Genre</option>
        		</select> 
        		&nbsp;&nbsp;
        		
       			<input class="w3-bar-item w3-white w3-round-xxlarge" name = "myText" style="width:30%;" type="text" placeholder="What are you looking for?" class="w3-input w3-round-small" />		    	
				&nbsp;&nbsp;
				<button class="button w3-button w3-black w3-round-xxlarge w3-bar-item" type="submit" name="Search" value="Submit" onclick="searchMethod()"><i class="fa fa-search"></i></button>
				
				</form>
	
	</div>
     <div class="w3-row w3-padding-32">
     
    </div>
  
</div>

<div class="w3-display-container we-center" style="color:white;">
  <!-- The Tour Section -->
  <div class="w3-black" id="tour">
    <div class="w3-container w3-content w3-padding-64" style="max-width:800px">
     
        
       
            	
            	
       	<%@ page import="java.net.*,java.text.*,shop.cart.*,java.sql.Connection,java.sql.DriverManager,java.sql.Statement,java.sql.ResultSet" %>
		<%!
		public void searchMethod()
		{
			System.out.print("running method");
		%>
		<%
		if(request.getParameter("SearchBy")!= null)
		{
			String c=request.getParameter("SearchBy"); 
			String d = request.getParameter("myText");
			if(!d.equals("") && ! c.equals(""))
			{

				int count = 1;
				boolean check = false;
			
				out.print("<h1>Search Results <i>for '"+d+"'</i></h1>");
				DriverManager.registerDriver(new com.mysql.jdbc.Driver ());
				Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/chinook", "root", "Pass");
		        Statement st = null;
		        Statement stTwo = null;
		        Statement stThree = null;
				ResultSet rs = null;
				ResultSet rsTwo = null;
				ResultSet rsThree = null;
				stTwo = conn.createStatement();
				stThree = conn.createStatement();
				st = conn.createStatement();
				List <String> templist = new ArrayList <String>();
				List <String> trackList = new ArrayList <String>();
				Map <String , String> tempMap = new HashMap<String, String>();
				NumberFormat currency = NumberFormat.getCurrencyInstance();
				if(c.equals("Artist"))
				{
					String artName = "";
					rs = st.executeQuery("select * from artist where Name LIKE '%"+d+"%'");
					Item[] catalog ;
					  while (rs.next()) 
							 { 
						       artName = rs.getString("Name");
								templist.add(artName);
								
						      } 
						    rs.close();
						    String composer = "";
						    for(int k =0; k<templist.size();k++)
							{
								   composer  = templist.get(k).toString();
								   %>
								   
									 <button class="accordion"><% out.print(composer);%></button>
									 <% 
									
							       if(composer != null)
								   {
							    	 //  out.print(" composr "+composer);
							    	   if(composer.contains("'"))
							    	   {
							    		   composer= composer.replace("'", "''");
							    	   }
							    	 //  out.print(" composr "+composer);
							    	   rs = st.executeQuery("select * from track where Composer LIKE '%"+composer+"%'");
							    	   while(rs.next())
								     { 
								       tempMap.put(rs.getString("Name"),rs.getString("UnitPrice"));
								     }
								     %>
								  
								     <div class="panel" style="color: white ;">
									  <p>
									  <%
									
										 for (Map.Entry<String, String> entry : tempMap.entrySet())
										 {
										     System.out.println(entry.getKey() + "/" + entry.getValue());
										
												String trackName = entry.getKey();
												String unitPrice = entry.getValue();
												Double pr = Double.parseDouble(unitPrice);
												%>
												<br>
												<%
												  out.println(trackName);
												
												catalog = new Item[] 
												  {
									        				new Item(trackName, trackName, pr, 1),
									        				
									       
									   			 };
												   for (int i=0; i < catalog.length; i++)
												    {
												        Item item = catalog[i];

												// Create the URL for adding the item to the shopping cart.
												        String addItemURL =
												            "AddToShoppingCartServlet?"+
												            "productCode="+URLEncoder.encode(item.getProductCode())+
												            "&description="+URLEncoder.encode(item.getDescription())+
												            "&quantity="+URLEncoder.encode(""+item.getQuantity())+
												            "&price="+URLEncoder.encode(""+item.getPrice());


												    
														%>	           <span class="download_button" style="float: right"><%=item.getPrice() %><a class="download_button" href="<%=addItemURL%>">Buy</a></span>
																	
																	<%
												   				 }
												
											  %>
											  <br>
											 </p>
										<%  }
									 
									 %>
									 </div>
									<br>
									<script>
								     var acc = document.getElementsByClassName("accordion");
							         var i;

							         for (i = 0; i < acc.length; i++) 
							         {
							             acc[i].onclick = function()
							             {
							                 this.classList.toggle("active");
							                 this.nextElementSibling.classList.toggle("show");
							             }
							         }
								     </script>
									 <%
									 } 
									}
				   if(templist.size()==0)
					 {
						 %> 
						 <div class="topdownload_box">
						  <% out.print("No Match Found!"); %>
						  </div>
						 <%
					 }
				  }	
				else if (c.equals("Album"))
				{
					
					
					String albumTitle = "";
				    rs = st.executeQuery("select * from album where Title LIKE '%"+d+"%'"); 
				    while (rs.next()) 
					 { 
						albumTitle = rs.getString("Title");
						templist.add(albumTitle);
						
				      } 
				    rs.close();
					for(int k =0; k<templist.size();k++)
					{
					   albumTitle  = templist.get(k);
					   %>
					   
						
						 <button class="accordion"><% out.print(albumTitle);%></button>
						 <% 
					
				       if(albumTitle != null)
					   {
				    	   if(albumTitle.contains("'"))
				    	   {
				    		   albumTitle= albumTitle.replace("'", "''");
				    	   }
						 rs = st.executeQuery("select * from track where AlbumId IN (select AlbumId from album where Title LIKE '%"+albumTitle+"%')");
						 while(rs.next())
					     { 
					       tempMap.put(rs.getString("Name"),rs.getString("UnitPrice"));
					     }
					     %>
					  
					     <div class="panel" style="color: white ;">
						  <p>
						  <%
						 
							 for (Map.Entry<String, String> entry : tempMap.entrySet())
							 {
							    
							 		String trackName = entry.getKey();
							 		String unitPrice = entry.getValue();
							 	   Double pr = Double.parseDouble(unitPrice);
								  %>
								  <br>
								  <%
								  out.println(trackName);
								  Item[] catalog = new Item[] 
								            {
					        				new Item(trackName, trackName, pr, 1),
					        
					   						 };
								  for (int i=0; i < catalog.length; i++)
								    {
								        Item item = catalog[i];

								// Create the URL for adding the item to the shopping cart.
								        String addItemURL =
								            "AddToShoppingCartServlet?"+
								            "productCode="+URLEncoder.encode(item.getProductCode())+
								            "&description="+URLEncoder.encode(item.getDescription())+
								            "&quantity="+URLEncoder.encode(""+item.getQuantity())+
								            "&price="+URLEncoder.encode(""+item.getPrice());


								    
										%>	           <span class="download_button" style="float: right"><%=item.getPrice() %><a class="download_button" href="<%=addItemURL%>">Buy</a></span>
													
													<%
								   				 }
								 %> 
									</p>
							<%  }
						
						 %>
						 </div>
						 
						 
						<br>
						
						 <% 
						 %>
						  <script>
					     var acc = document.getElementsByClassName("accordion");
				         var i;

				         for (i = 0; i < acc.length; i++) 
				         {
				             acc[i].onclick = function()
				             {
				                 this.classList.toggle("active");
				                 this.nextElementSibling.classList.toggle("show");
				             }
				         }
					     </script>
						 <%
						 } 
						}
					%>
					
					<%
				     if(templist.size()==0)
					 {
						 %> 
						 <div class="topdownload_box">
						  <% out.print("No Match Found!"); %>
						  </div>
						 <%
					 }
				}
				else if (c.equals("Track"))
				{
					rs = st.executeQuery("select * from track where Name LIKE '%"+d+"%' order by Name");
					while (rs.next()) 
					 { 
						check = true;
						 %>
						 <div class="topdownload_box">
						 <% 
						 String trckName = rs.getString("Name");
						 out.print(trckName); %>
				           <span> 
				           <%if(rs.getString("Composer") != null)
				            {
				            	out.print(" by "+rs.getString("Composer"));
				            }
				            String price = rs.getString("UnitPrice");
				            Double pr = Double.parseDouble(price);
				            %>
				           </span>
				            <%  Item[] catalog = new Item[] 
				            {
	        				new Item(trckName, trckName, pr, 1),
	        
	   						 };
	    // Get a currency formatter for showing the price.
	    

	    for (int i=0; i < catalog.length; i++)
	    {
	        Item item = catalog[i];

	// Create the URL for adding the item to the shopping cart.
	        String addItemURL =
	            "AddToShoppingCartServlet?"+
	            "productCode="+URLEncoder.encode(item.getProductCode())+
	            "&description="+URLEncoder.encode(item.getDescription())+
	            "&quantity="+URLEncoder.encode(""+item.getQuantity())+
	            "&price="+URLEncoder.encode(""+item.getPrice());


	    
			%>	           <span class="download_button" style="float: right"><%=price %><a class="download_button" href="<%=addItemURL%>">Buy</a></span>
						 </div>
						<%
	   				 }
				      } 
				  
				  if(!check)
					 {
						 %> 
						 <div class="topdownload_box">
						  <% out.print("No Match Found!"); %>
						  </div>
						 <%
					 }
				}
				else if (c.equals("Genre"))
				{
				// start here
				    Set<String> trackSet = new  HashSet<String>();
					String genreName = "";
				    rs = st.executeQuery("select * from genre where Name LIKE '%"+d+"%'"); 
				    while (rs.next()) 
					 { 
				    	check = true;
				    	genreName = rs.getString("Name");
						templist.add(genreName);
						
				      } 
				     rs.close();
				     String trackName = "";
				     for(int k =0; k<templist.size();k++)
					 {
						genreName  = templist.get(k);
						//out.println("genre "+genreName);
						 rs = st.executeQuery("select * from track where GenreId IN (select GenreId from genre where Name LIKE '%"+genreName+"%')");
						 while(rs.next())
					     { 
				    	   trackName = rs.getString("Name");
				    	   String albumId = rs.getString("AlbumId");
				    	   trackSet.add(albumId);
					     }
						 rs.close();
					 }
				     Map<String,String> checkList = new HashMap<String,String>();
				     for (String s : trackSet) 
			    	  {
			    		  String albId = s;
			    		  rsTwo = stTwo.executeQuery("select Title from album where AlbumId LIKE '%"+albId+"%'");
				    	   if(rsTwo.next())
						     { 
					    	  
					    	   String albumName = rsTwo.getString("Title");
					    	  // out.println("albumName "+albumName);
					    	   checkList.put(albId,albumName);
						     }
			    	  }
				     for (Map.Entry<String, String> entry : checkList.entrySet())
				     {
				        //out.println(entry.getKey() + "/" + entry.getValue());

				    	  String albName = entry.getValue();
				    	  String albumID = entry.getKey();
				    	  //out.println("albumNamefrom list "+albName);
				    	  %><br><button class="accordion"><% out.println(albName);%></button>
				    	   <%
				    	   rsThree = stThree.executeQuery("select * from track where AlbumId LIKE '%"+albumID+"%'");
				    	   %>
			    		    <div class="panel" style="color: white ;">
					       <p>
			    		   <%
			    		   
				    	   while(rsThree.next())
						     { 
				    		   String trkName = rsThree.getString("Name");
				    		   String unitPrice = rsThree.getString("UnitPrice");
				    		   Double pr = Double.parseDouble(unitPrice);
				    		   %>
								  <br>
								  <%
				    		   out.println(trkName);
								  Item[] catalog = new Item[] 
								            {
					        				new Item(trkName, trkName, pr, 1),
					        
					   						 };
								  for (int i=0; i < catalog.length; i++)
								    {
								        Item item = catalog[i];

								// Create the URL for adding the item to the shopping cart.
								        String addItemURL =
								            "AddToShoppingCartServlet?"+
								            "productCode="+URLEncoder.encode(item.getProductCode())+
								            "&description="+URLEncoder.encode(item.getDescription())+
								            "&quantity="+URLEncoder.encode(""+item.getQuantity())+
								            "&price="+URLEncoder.encode(""+item.getPrice());


								    
										%>	           <span class="download_button" style="float: right"><%=item.getPrice() %><a class="download_button" href="<%=addItemURL%>">Buy</a></span>
													 
													<%
								   				 }
				    		   %>
				    		    
			    		        </p>
				    		   <%
						     }
			    		   %>
			    		   
			    		    </div>
			    		   <%
				    	   rsThree.close();
			    		   %>
							  <script>
						     var acc = document.getElementsByClassName("accordion");
					         var i;

					         for (i = 0; i < acc.length; i++) 
					         {
					             acc[i].onclick = function()
					             {
					                 this.classList.toggle("active");
					                 this.nextElementSibling.classList.toggle("show");
					             }
					         }
						     </script>
							 <%
				      
				     }
				     
					
				//end here
				} 
			   
			}
			else
			{
				%> 
				 <div class="topdownload_box">
				  <% out.print("Please select a Search By option and a valid keyword and try again !"); %>
				  </div>
				 <%
			}
		}
			
		
		 %>
		<%! }%>
	
              					
            </div>
            
            <div class="templatemo_right_panel_fullwidth">
                <div id="news_section">
                  
                </div> <!-- end of news -->
                
                
			</div>                
      
    </div>
     </div>
    

            </body>
            </html>