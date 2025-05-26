CREATE DATABASE IF NOT EXISTS Ecommerce;

USE Ecommerce;

CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(10) NOT NULL,
    name VARCHAR(100) NOT NULL,
    active BOOLEAN 
);

CREATE TABLE payment_methods (
    id INT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(10) NOT NULL,
    name VARCHAR(10) NOT NULL,
    active BOOLEAN
);

CREATE TABLE countries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    code_country VARCHAR(3) NOT NULL,
    country VARCHAR(100)
);

CREATE TABLE cities (
    id INT AUTO_INCREMENT PRIMARY KEY,
    city VARCHAR(100),
    zip_code INT,
    countries_id INT NOT NULL,
    Foreign Key (countries_id ) REFERENCES countries(id)
);

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password VARCHAR(200) NOT NULL,
    document_type VARCHAR(50),
    document_number VARCHAR(40),
    phone VARCHAR(20),
    cities_id INT NOT NULL,
    user_type ENUM("client", "seller") NOT NULL,
    register_date DATE,
    active BOOLEAN,
    address VARCHAR(250),
    Foreign Key (cities_id) REFERENCES cities(id)
);

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(10) NOT NULL,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(500) NOT NULL,
    price DOUBLE NOT NULL,
    stock INT,
    category_id INT NOT NULL,
    brand VARCHAR(100),
    product_Condition VARCHAR(50),
    vat DOUBLE,
    active BOOLEAN,
    Foreign Key (category_id) REFERENCES categories(id)
);

CREATE TABLE sale_details (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    sale_id INT NOT NULL,
    quantity INT NOT NULL,
    price DOUBLE NOT NULL,
    Foreign Key (product_id) REFERENCES products(id),
    Foreign Key (sale_id) REFERENCES sales(id)
);

CREATE TABLE sales (
    id INT AUTO_INCREMENT PRIMARY KEY,
    reference INT NOT NULL,
    date DATE NOT NULL,
    payment_method_id INT NOT NULL,
    client_id INT NOT NULL,
    seller_id INT NOT NULL,
    Foreign Key (payment_method_id) REFERENCES payment_methods(id),
    Foreign Key (client_id) REFERENCES users(id),
    Foreign Key (seller_id) REFERENCES users(id)
);



-- los Indices


-- poder buscar por email
CREATE INDEX idx_users_email ON users(email);


--buscar ciudad por usuario
CREATE INDEX idx_users_city ON users(cities_id);


-- filtar productos por categoria o tambien marca
CREATE INDEX idx_products_category ON products(category_id);
CREATE INDEX idx_products_brand ON products(brand);


-- poder ver las ciudades por pais
CREATE INDEX idx_cities_country ON cities(countries_id);



-- Con ventas se puede: consultar por cliente, vendedor, o el metodo de pago
CREATE INDEX idx_sales_client ON sales(client_id);

CREATE INDEX idx_sales_seller ON sales(seller_id);

CREATE INDEX idx_sales_payment ON sales(payment_method_id);


-- detalles de productos en ventass
CREATE INDEX idx_sale_details_product ON sale_details(product_id);



-- ahora las vistas 

-- la primera se desespera

CREATE VIEW login_user_view AS
SELECT 
    u.name AS full_name,
    u.email,
    u.document_type,
    u.document_number,
    c.city,
    u.address,
    u.phone
    u.user_type AS role,
FROM users u
JOIN cities c ON u.cities_id = c.id;


-- Vista #2(Ordenes de Pedidos del User)

CREATE VIEW users_sales_view AS
SELECT
    u.name AS full_name,
    u.document_number,
    s.reference,
    s.date,
    pa.name AS payment_method,
    GROUP_CONCAT(po.name SEPARATOR ', ') AS products,
    SUM(sd.price) AS total
FROM 
    sales s 
LEFT JOIN users u ON s.client_id = u.id
LEFT JOIN payment_methods pa ON s.payment_method_id = pa.id
LEFT JOIN sale_details sd ON sd.sale_id = s.id
LEFT JOIN products po ON sd.product_id = po.id
GROUP BY s.id;