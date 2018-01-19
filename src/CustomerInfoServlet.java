

import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class CustomerInfoServlet
 */
@WebServlet("/CustomerInfoServlet")
public class CustomerInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CustomerInfoServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException 
	{
      // get response writer
       PrintWriter writer = response.getWriter();
      try 
       {
    	    String email = request.getParameter("email");
    	    System.out.print(" email "+email);
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println(" trying to connect to db from customer ");
	        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/chinook", "root", "Pass");
	        Statement st = null;
			ResultSet rs = null;
			ResultSet rsTwo = null;
			int orderNumber = 0;
			int cId = 0;
			String billingAddress = "";
			String billingCity = "";
			String billingState = "";
			String billingCountry = "";
			String billingPostalCode = "";
			String totalPrice = "";
			String customerId = "";
			  NumberFormat currency = NumberFormat.getCurrencyInstance();
			billingAddress = request.getParameter("address");
        	billingCity = request.getParameter("city");
        	billingState = request.getParameter("state");
        	billingCountry = request.getParameter("country");
        	billingPostalCode = request.getParameter("postalCode");
        	String firstName = request.getParameter("firstName");
	        String lastName = request.getParameter("lastName");
	        String phone = request.getParameter("phone");
	        String fax = request.getParameter("fax");
	        String company = request.getParameter("company");
			st = conn.createStatement();
			rsTwo = st.executeQuery("select max(InvoiceId) from invoice");
			
    	      if (rsTwo.next()) 
  	        {
  	        	int invoice = Integer.parseInt(rsTwo.getString("max(InvoiceId)").toString());
                 //orderNumber = nextOrderNumber;
  	        	orderNumber = invoice + 1;
              
  	        } 
    	      rsTwo.close();
			rs = st.executeQuery("select CustomerId from customer where Email LIKE '"+email+"'");
			
	      	if(rs.next())
			{
				customerId = rs.getString("CustomerId");
	        	
			}
			else 
	         {
	        	//customer does not exist
	        	rsTwo = st.executeQuery("select max(CustomerId) from customer");
	    	    if (rsTwo.next()) 
	  	        {
	  	        	int custId = Integer.parseInt(rsTwo.getString("max(CustomerId)").toString());
	                 //orderNumber = nextOrderNumber;
	  	        	cId = custId + 1;
	            } 
	    	    rsTwo.close();
	        	//add customer data to customer and invoice to invoice
	        	customerId = String.valueOf(cId);
	        	
		        String query = 
	        			"Insert into customer values ('"+customerId+"' , '"+
	        			firstName+"' , '"+lastName+"' , '"+ company+"' , '"+billingAddress+ "' , '"+
	        			billingCity +"' ,  '"+billingState +"' ,  '"+
	        	        billingCountry +"' , '"+ billingPostalCode+"' , '"+phone+"' , '"+fax+"' , '"+
	        			email  +"' , '"+"3" +"' ) ;";
	        	st.executeUpdate(query);
	        	//System.out.println(" Data Update in customer table ");
	         
	         } 
	     
        	// customer already exist, add data to invoice table
	        rs = st.executeQuery("select CustomerId from customer where Email LIKE '"+email+"'");
			if(rs.next())
			{
				customerId = rs.getString("CustomerId");
	        	//System.out.print(" customerId "+customerId);
			}
        	//orderNumber = nextOrderNumber;
        	String invoiceId = String.valueOf(orderNumber);
        	
        	Calendar cal = Calendar.getInstance();
        	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        	String invoiceDate = sdf.format(cal.getTime());
            totalPrice = request.getParameter("totalPrice");
        	
        	//System.out.println("totalPrice  "+totalPrice);
        	String query = 
        			"Insert into invoice values ('"+invoiceId+"' , '"+customerId+"' , '"+
        			invoiceDate+"' , '"+ billingAddress+ "' , '"+
        			billingCity +"' ,  '"+billingState +"' ,  '"+
        	        billingCountry +"' , '"+ billingPostalCode+"' , '"+
        			totalPrice +"' ) ;";
        	st.executeUpdate(query);
        //	System.out.println(" Data Update in invoice table ");
        	//currency.format(totalPrice);
	       //request.getSession().setAttribute("errorMessage", "Invalid Credentials!");
        	request.getSession().setAttribute("invoiceId", invoiceId);
        	request.getSession().setAttribute("firstName", firstName);
        	request.getSession().setAttribute("lastName", lastName);
        	request.getSession().setAttribute("company", company);
        	request.getSession().setAttribute("address", billingAddress);
        	request.getSession().setAttribute("city", billingCity);
        	request.getSession().setAttribute("state", billingState);
        	request.getSession().setAttribute("country", billingCountry);
        	request.getSession().setAttribute("postalCode", billingPostalCode);
        	request.getSession().setAttribute("phone", phone);
        	request.getSession().setAttribute("fax", fax);
        	request.getSession().setAttribute("email", email);
        	request.getSession().setAttribute("total", "$ "+totalPrice.substring(0,totalPrice.indexOf(".")+2));
			request.getRequestDispatcher("/ShowConfirmation.jsp").forward(request, response);
			
		      
		}  catch (Exception e) 
      {
			System.out.println("Exception occurred "+e.getMessage());
			e.printStackTrace();
		}
       
        
   }

}
