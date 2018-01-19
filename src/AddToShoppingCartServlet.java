



import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import shop.cart.Item;
import shop.cart.ShoppingCart;

import java.io.*;

@WebServlet("/AddToShoppingCartServlet")
public class AddToShoppingCartServlet extends HttpServlet
{
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void service(HttpServletRequest request,
        HttpServletResponse response)
        throws IOException, ServletException
    {
		System.out.println(" i am gere ");

// First get the item values from the request.
        String productCode = request.getParameter("productCode");
        String description = request.getParameter("description");
        int quantity = Integer.parseInt(
            request.getParameter("quantity"));
        double price = Double.parseDouble(
            request.getParameter("price"));

// Now create an item to add to the cart.
        Item item = new Item(productCode, description, price, quantity);

        HttpSession session = request.getSession();

// Get the cart.
        ShoppingCart cart = (ShoppingCart) session.
            getAttribute("ShoppingCart");

// If there is no shopping cart, create one.
        if (cart == null)
        {
            cart = new ShoppingCart();

            session.setAttribute("ShoppingCart", cart);
        }

        cart.addItem(item);

// Now display the cart and allow the user to check out or order more items.
        response.sendRedirect(response.encodeRedirectURL(
            "ShowProductCatalog.jsp"));
    }
}