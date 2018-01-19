package shop.cart;

public class Item implements java.io.Serializable
{
    public String productCode;
    public String description;
    public double price;
    public int quantity;
    public int orderQuantity;

    public Item()
    {
    }

    public Item(String aProductCode, String aDescription,
        double aPrice, int aQuantity)
    {
        this(aProductCode, aDescription, aPrice, aQuantity, aQuantity);
    }

    public Item(String aProductCode, String aDescription,
        double aPrice, int aQuantity, int anOrderQuantity)
    {
        productCode = aProductCode;
        description = aDescription;
        price = aPrice;
        quantity = aQuantity;
        orderQuantity = anOrderQuantity;
    }

// Make get/set methods so the attributes will appear
// as bean attributes.

    public String getProductCode() { return productCode; }
    public void setProductCode(String aProductCode) {
        productCode = aProductCode; }

    public String getDescription() { return description; }
    public void setDescription(String aDescription) {
        description = aDescription; }

    public double getPrice() { return price; }
    public void setPrice(double aPrice) { price = aPrice; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int aQuantity) { quantity = aQuantity; }

    public int getOrderQuantity() { return orderQuantity; }
    public void setOrderQuantity(int anOrderQuantity)
    {
        orderQuantity = anOrderQuantity;
    }

    public boolean equals(Object ob)
    {
        if (ob == this) return true;
        if (!(ob instanceof Item)) return false;
        if (((Item)ob).getProductCode().equals(getProductCode()))
        {
            return true;
        }
        return false;
    }
}