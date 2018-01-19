

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import shop.cart.Shipping;
import shop.cart.ShoppingCart;

import java.io.*;


@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet
{
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void service(HttpServletRequest request,
        HttpServletResponse response)
        throws IOException, ServletException
    {

// First get the shipping values from the request.
        Shipping shipping = new Shipping();

        shipping.setName(request.getParameter("name"));
        shipping.setAddress1(request.getParameter("address"));
         shipping.setCity(request.getParameter("city"));
        shipping.setState(request.getParameter("state"));
        shipping.setPostalCode(request.getParameter("postalCode"));
        shipping.setCountry(request.getParameter("country"));
        shipping.setEmail(request.getParameter("email"));


        HttpSession session = request.getSession();

// Get the cart.
        ShoppingCart cart =
            (ShoppingCart) session.getAttribute("ShoppingCart");

// If there is no shopping cart, create one (this should really be an error).
        if (cart == null)
        {
            cart = new ShoppingCart();

            session.setAttribute("ShoppingCart", cart);
        }
        try
        {
            String confirmation = request.getParameter("invoiceDate");
        
		String addItemURL =
				"/ShowConfirmation.jsp"+
                "?confirmationNumber="+confirmation+
                "invoiceDate="+request.getParameter("invoiceDate")+
                "&address="+request.getParameter("address")+
                "&city="+""+request.getParameter("city")+
                "&state="+""+request.getParameter("state");
       
            
// Now display the cart and allow the user to check out or order more items.
            response.sendRedirect(response.encodeRedirectURL(addItemURL));
        }
        catch (Exception exc)
        {
            PrintWriter out = response.getWriter();

            out.println("<html><body><h1>Error</h1>");
            out.println("The following error occurred while "+
                "processing your order:");
            out.println("<pre>");
            out.println(exc);
            out.println("</pre>");
            out.println("</body></html>");
            return;
        }
    }
}