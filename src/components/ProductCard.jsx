import { Button } from "./ui/button";
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "./ui/card";
import { ShoppingCart } from "lucide-react";
import { Link } from "react-router-dom";

export const ProductCard = ({ id, name, description, price, image_url, stock, onAddToCart }) => {
  return (
    <Card className="overflow-hidden hover:shadow-lg transition-shadow">
      <Link to={`/product/${id}`}>
          <img 
          src={image_url} 
          alt={name}
          className="w-full h-24 object-cover"
        />
      </Link>
      <CardHeader className="p-3">
        <CardTitle className="line-clamp-1 text-base">{name}</CardTitle>
        <CardDescription className="line-clamp-2 text-sm">{description}</CardDescription>
      </CardHeader>
      <CardContent className="p-3 pt-0">
        <p className="text-lg font-bold text-primary">${price.toFixed(2)}</p>
        <p className="text-xs text-muted-foreground mt-0.5">
          {stock > 0 ? `${stock} in stock` : "Out of stock"}
        </p>
      </CardContent>
      <CardFooter className="p-3 pt-0">
        <Button 
          onClick={() => onAddToCart(id)} 
          disabled={stock === 0}
          className="w-full"
        >
          <ShoppingCart className="mr-2 h-4 w-4" />
          Add to Cart
        </Button>
      </CardFooter>
    </Card>
  );
};