

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AddEmployeeServlet
 */
@WebServlet("/AddEmployeeServlet")
public class AddEmployeeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddEmployeeServlet() {
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
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

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
		int empNumber = 0;
		int cId = 0;
		String billingAddress = "";
		String billingCity = "";
		String billingState = "";
		String billingCountry = "";
		String billingPostalCode = "";
		String totalPrice = "";
		String customerId = "";
		
		billingAddress = request.getParameter("address");
    	billingCity = request.getParameter("city");
    	billingState = request.getParameter("state");
    	billingCountry = request.getParameter("country");
    	billingPostalCode = request.getParameter("postalCode");
    	String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String phone = request.getParameter("phone");
        String fax = request.getParameter("fax");
        
        String title = request.getParameter("title");
        String birthDate = request.getParameter("birthDate");
        String hireDate = request.getParameter("hireDate");
        String password = "1000:edec2ab7b374803b6bbaa0320d8c88bc:69abf93e074acc9fa70f43e9331bd8d7161dd2aa6f97ea9a13b618e272beb0a9f1ebfee5c479cc2bbe0cef333b94d9c4188dbd17fbeb12e062759d6299d84c16";
        String reportsTo = "";
		st = conn.createStatement();
		rsTwo = st.executeQuery("select max(EmployeeId) from employee");
	      if (rsTwo.next()) 
	        {
	        	int invoice = Integer.parseInt(rsTwo.getString("max(EmployeeId)").toString());
             //orderNumber = nextOrderNumber;
	        	empNumber = invoice + 1;
          
	        } 
	      rsTwo.close();
		rs = st.executeQuery("select EmployeeId from employee where Email LIKE '"+email+"'");
		
      	if(rs.next())
		{
			//customerId = rs.getString("CustomerId");
      	//
      		//employee arlready exist//
      	    request.getSession().setAttribute("empErrorMessage", "Employee already exists!");
			request.getRequestDispatcher("/AdminLoginSuccess.jsp").forward(request, response);
        	
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
        	if(title.equals("IT Staff"))
        	{
        		reportsTo = "6";
        	}
        	else if(title.equals("Sales Manager")|| title.equals("IT Manager"))
        	{
        		reportsTo = "1";
        	}
        	else if(title.equals("Sales Support Agent"))
        	{
        		reportsTo = "2";
        	}
        	
	        String query = 
        			"Insert into employee values ('"+empNumber+"' , '"+lastName+"' , '"+
        			firstName+"' , '"+title+"' , '"+ reportsTo+"' , '"+birthDate+ 
        			"' , '"+hireDate+ "' , '"+billingAddress+ "' , '"+
        			billingCity +"' ,  '"+billingState +"' ,  '"+
        	        billingCountry +"' , '"+ billingPostalCode+"' , '"+phone+"' , '"+fax+"' , '"+
        			email  +"' , '"+password+"' ) ;";
        	st.executeUpdate(query);
        	System.out.println(" Data Update in employee table ");
        	request.getSession().setAttribute("empErrorMessage", "Employee added to the database successfully !");
        	request.getRequestDispatcher("/AdminLoginSuccess.jsp").forward(request, response);
         } 
     
   }
		catch(Exception e)
		{
			System.out.println("Exception "+e.getMessage());
		}
	}

}
