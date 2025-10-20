-- Create products table
CREATE TABLE public.products (
  id uuid NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  name text NOT NULL,
  description text,
  price decimal(10,2) NOT NULL CHECK (price >= 0),
  image_url text,
  category text,
  stock integer NOT NULL DEFAULT 0 CHECK (stock >= 0),
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  updated_at timestamp with time zone NOT NULL DEFAULT now()
);

-- Create orders table
CREATE TABLE public.orders (
  id uuid NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  customer_name text NOT NULL,
  customer_email text NOT NULL,
  customer_phone text,
  total_amount decimal(10,2) NOT NULL CHECK (total_amount >= 0),
  status text NOT NULL DEFAULT 'pending',
  created_at timestamp with time zone NOT NULL DEFAULT now()
);

-- Create order_items table
CREATE TABLE public.order_items (
  id uuid NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  order_id uuid NOT NULL REFERENCES public.orders(id) ON DELETE CASCADE,
  product_id uuid NOT NULL REFERENCES public.products(id),
  quantity integer NOT NULL CHECK (quantity > 0),
  price decimal(10,2) NOT NULL CHECK (price >= 0),
  created_at timestamp with time zone NOT NULL DEFAULT now()
);

-- Enable Row Level Security
ALTER TABLE public.products ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.order_items ENABLE ROW LEVEL SECURITY;

-- Create policies for public read access on products
CREATE POLICY "Products are viewable by everyone" 
ON public.products FOR SELECT 
USING (true);

-- Create policies for admin access to products (for now, allow all inserts/updates/deletes)
CREATE POLICY "Anyone can manage products" 
ON public.products FOR ALL 
USING (true);

-- Create policies for orders
CREATE POLICY "Orders are viewable by everyone" 
ON public.orders FOR SELECT 
USING (true);

CREATE POLICY "Anyone can create orders" 
ON public.orders FOR INSERT 
WITH CHECK (true);

-- Create policies for order items
CREATE POLICY "Order items are viewable by everyone" 
ON public.order_items FOR SELECT 
USING (true);

CREATE POLICY "Anyone can create order items" 
ON public.order_items FOR INSERT 
WITH CHECK (true);

-- Create function to update timestamps
CREATE OR REPLACE FUNCTION public.update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SET search_path = public;

-- Create trigger for automatic timestamp updates on products
CREATE TRIGGER update_products_updated_at
BEFORE UPDATE ON public.products
FOR EACH ROW
EXECUTE FUNCTION public.update_updated_at_column();

-- Insert sample products
INSERT INTO public.products (name, description, price, category, stock, image_url) VALUES
('Laptop Pro 15', 'High-performance laptop with 15-inch display, perfect for professionals', 1299.99, 'Laptops', 25, 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=500'),
('Wireless Mouse', 'Ergonomic wireless mouse with precision tracking', 29.99, 'Accessories', 150, 'https://images.unsplash.com/photo-1527814050087-3793815479db?w=500'),
('Mechanical Keyboard', 'RGB mechanical keyboard with cherry switches', 89.99, 'Accessories', 75, 'https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=500'),
('4K Monitor', '27-inch 4K UHD monitor with HDR support', 449.99, 'Monitors', 40, 'https://images.unsplash.com/photo-1527443224154-c4a3942d3acf?w=500'),
('Noise Cancelling Headphones', 'Premium wireless headphones with active noise cancellation', 199.99, 'Audio', 60, 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500'),
('USB-C Hub', '7-in-1 USB-C hub with HDMI and card readers', 49.99, 'Accessories', 200, 'https://images.unsplash.com/photo-1625948515291-69613efd103f?w=500')