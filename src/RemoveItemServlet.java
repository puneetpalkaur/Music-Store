

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import shop.cart.ShoppingCart;

import java.io.*;

@WebServlet("/RemoveItemServlet")
public class RemoveItemServlet extends HttpServlet
{
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void service(HttpServletRequest request,
        HttpServletResponse response)
        throws IOException, ServletException
    {

// Get the index of the item to remove.
        int itemIndex = Integer.parseInt(request.getParameter("item").toString());
        
        HttpSession session = request.getSession();

// Get the cart.
        ShoppingCart cart =
            (ShoppingCart) session.getAttribute("ShoppingCart");
        
// If there is no shopping cart, create one.
        if (cart == null)
        {
            cart = new ShoppingCart();

            session.setAttribute("ShoppingCart", cart);
        }

        cart.removeItem(itemIndex);

// Now display the cart and allow the user to check out or order more items.
        response.sendRedirect(response.encodeRedirectURL(
            "DisplayShoppingCart.jsp"));
    }
}