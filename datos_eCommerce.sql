-- Datos para categories
INSERT INTO categories (code, name, active) VALUES
('ELEC', 'Electrónica', TRUE),
('HOME', 'Hogar', TRUE),
('TOYS', 'Juguetes', TRUE),
('BOOK', 'Libros', TRUE),
('FASH', 'Moda', FALSE);

-- Datos para payment_methods
INSERT INTO payment_methods (code, name, active) VALUES
('CASH', 'Efectivo', TRUE),
('CRDT', 'Crédito', TRUE),
('DBIT', 'Débito', TRUE),
('TRNS', 'Transfer', FALSE);

-- Datos para countries
INSERT INTO countries (code_country, country) VALUES
('COL', 'Colombia'),
('USA', 'Estados Unidos'),
('MEX', 'México');

-- Datos para cities
INSERT INTO cities (city, zip_code, countries_id) VALUES
('Bogotá', 110111, 1),
('Medellín', 050001, 1),
('New York', 10001, 2),
('Ciudad de México', 01000, 3);

-- Datos para users (clientes y vendedores)
INSERT INTO users (name, email, password, document_type, document_number, phone, cities_id, user_type, register_date, active, address) VALUES
('Juan Pérez', 'juanp@example.com', 'hashedpwd1', 'CC', '123456789', '3001234567', 1, 'client', '2024-01-10', TRUE, 'Cra 1 #23-45'),
('Ana Gómez', 'anag@example.com', 'hashedpwd2', 'CC', '987654321', '3012345678', 2, 'client', '2024-02-20', TRUE, 'Cll 50 #10-20'),
('Carlos Ruiz', 'carlosr@example.com', 'hashedpwd3', 'CC', '456789123', '3023456789', 3, 'seller', '2024-03-15', TRUE, '123 Main St'),
('Laura Díaz', 'laurad@example.com', 'hashedpwd4', 'CC', '321654987', '3034567890', 4, 'seller', '2024-04-05', FALSE, '456 Central Ave');

-- Datos para products
INSERT INTO products (code, name, description, price, stock, category_id, brand, product_Condition, vat, active) VALUES
('P001', 'Smartphone X', 'Teléfono inteligente de gama alta', 1200.00, 15, 1, 'TechBrand', 'Nuevo', 19.0, TRUE),
('P002', 'Aspiradora 3000', 'Aspiradora con filtro HEPA', 350.50, 8, 2, 'CleanCo', 'Nuevo', 19.0, TRUE),
('P003', 'Muñeca Clara', 'Muñeca de colección', 45.99, 20, 3, 'ToyWorld', 'Nuevo', 5.0, TRUE),
('P004', 'Libro de Fantasía', 'Novela de fantasía épica', 19.99, 50, 4, 'BookHouse', 'Nuevo', 0.0, TRUE),
('P005', 'Camisa Azul', 'Camisa casual de algodón', 29.99, 30, 5, 'ModaZ', 'Nuevo', 19.0, FALSE);

-- Datos para sales
INSERT INTO sales (reference, date, payment_method_id, client_id, seller_id) VALUES
(1001, '2025-05-01', 1, 1, 3),
(1002, '2025-05-05', 2, 2, 4);

-- Datos para sale_details
INSERT INTO sale_details (product_id, quantity, price, sale_id) VALUES
(1, 1, 1200.00, 1),
(4, 2, 19.99, 1),
(2, 1, 350.50, 2),
(5, 3, 29.99, 2);