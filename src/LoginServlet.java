

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

 
@WebServlet("/loginServlet")
public class LoginServlet extends HttpServlet 
{
 
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static String passwordFromDB  = "";
	private static boolean matchFound = false;
	protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
         boolean check = true;
        // read form fields
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        PrintWriter writer = response.getWriter();
      
        try {
			Class.forName("com.mysql.jdbc.Driver");
		//	System.out.println(" trying to connect to db ");
	        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/chinook", "root", "Pass");
	        //fetch password for current user 
	        PreparedStatement pst = conn.prepareStatement("Select Password from employee where Email=?");
	        pst.setString(1, username);
	        ResultSet rs = pst.executeQuery();
	        if (rs.next()) 
	        {
	        	passwordFromDB = rs.getString("Password");
	       	System.out.println(" password from database "+passwordFromDB);
	          
	        } 
	        else 
	        {
	        	check = false;
	           //System.out.println("Username not found");
	            request.getSession().setAttribute("errorMessage", "Invalid Credentials!");
    			request.getRequestDispatcher("/MainPage.jsp").forward(request, response);
    		}
	        if(password.length()>0 && check)
		       {
		    	   if(!passwordFromDB.equals(""))
			        {
			        	try 
				        {
			        		//matchFound = CheckPassword.checkPassmain(password, passwordFromDB);
			        	//	if(matchFound)
			        	//	{
			        			System.out.println(" username and password matches ");
			        		 	 // build HTML code
			    	            String htmlRespone = "<html>";
			    	            htmlRespone += "<h2>Login Successful " +  "<br/>";      
			    	          //  htmlRespone += "Your password is: " + password + "</h2>";    
			    	            htmlRespone += "</html>";
			    	            // return response
			    	            writer.println(htmlRespone);
			    	            /// code to set session
			    	            HttpSession session = request.getSession();
			    				session.setAttribute("user", username);
			    				//setting session to expiry in 30 mins
			    				session.setMaxInactiveInterval(30*60);
			    				Cookie userName = new Cookie("user", username);
			    				response.addCookie(userName);
			    				//Get the encoded URL string
			    				//String encodedURL = response.encodeRedirectURL("LoginSuccess.jsp");
			    				
			    				response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
			    		        response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
			    		        response.setDateHeader("Expires", 0);
			    				if(username.equals("admin@chinookcorp.com"))
			    				{
			    					String encodedURL = response.encodeRedirectURL("AdminLoginSuccess.jsp");
			    					response.sendRedirect(encodedURL);
			    				}
			    				else
			    				{
			    					System.out.println();
			    					String encodedURL = response.encodeRedirectURL("index.jsp");
			    					response.sendRedirect(encodedURL);
			    				}
			    				
			    				
			    	       
						} 
				        catch (Exception e1)
				        {
							//System.out.println(" exception occured for password check "+e1.getMessage());
							e1.printStackTrace();
						}
			        }
		    	   else
		    	   {
		    		   //System.out.println(" password is a required field");
		    	   }
		       }
	        
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
         
    }
 
}