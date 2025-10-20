import { Button } from "./ui/button";
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "./ui/card";
import { ShoppingCart } from "lucide-react";
import { Link } from "react-router-dom";

interface ProductCardProps {
  id: string;
  name: string;
  description: string;
  price: number;
  image_url: string;
  stock: number;
  onAddToCart: (id: string) => void;
}

export const ProductCard = ({ id, name, description, price, image_url, stock, onAddToCart }: ProductCardProps) => {
  return (
    <Card className="overflow-hidden hover:shadow-lg transition-shadow">
      <Link to={`/product/${id}`}>
        <img 
          src={image_url} 
          alt={name}
          className="w-full h-48 object-cover"
        />
      </Link>
      <CardHeader>
        <CardTitle className="line-clamp-1">{name}</CardTitle>
        <CardDescription className="line-clamp-2">{description}</CardDescription>
      </CardHeader>
      <CardContent>
        <p className="text-2xl font-bold text-primary">${price.toFixed(2)}</p>
        <p className="text-sm text-muted-foreground mt-1">
          {stock > 0 ? `${stock} in stock` : "Out of stock"}
        </p>
      </CardContent>
      <CardFooter>
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