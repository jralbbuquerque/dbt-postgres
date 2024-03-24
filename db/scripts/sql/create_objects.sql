-- Drop do schema se existir
DROP SCHEMA IF EXISTS bronze CASCADE;

-- Criação do schema
CREATE SCHEMA IF NOT EXISTS bronze;

-- Tabela categories
CREATE TABLE IF NOT EXISTS bronze.categories (
    category_id smallint PRIMARY KEY NOT NULL,
    category_name varchar(15) NOT NULL,
    description text
);

-- Tabela customers
CREATE TABLE IF NOT EXISTS bronze.customers (
    customer_id varchar(40) PRIMARY KEY NOT NULL,
    company_name varchar(40) NOT NULL,
    contact_name varchar(30),
    contact_title varchar(30),
    address varchar(60),
    city varchar(15),
    region varchar(15),
    postal_code varchar(10),
    country varchar(15),
    phone varchar(24)
);

-- Tabela employees
CREATE TABLE IF NOT EXISTS bronze.employees (
    employee_id smallint PRIMARY KEY NOT NULL,
    last_name varchar(20) NOT NULL,
    first_name varchar(10) NOT NULL,
    title varchar(30),
    title_of_courtesy varchar(25),
    birth_date date,
    hire_date date,
    address varchar(60),
    city varchar(15),
    region varchar(15),
    postal_code varchar(10),
    country varchar(15),
    home_phone varchar(24),
    extension varchar(4),
    notes text,
    reports_to smallint,
    photo_path varchar(255),
    salary real
);

-- Tabela order_details
CREATE TABLE IF NOT EXISTS bronze.order_details (
    order_id smallint NOT NULL,
    product_id smallint NOT NULL,
    unit_price real NOT NULL,
    quantity smallint NOT NULL,
    discount real NOT NULL,
    PRIMARY KEY (order_id, product_id)
);

-- Tabela orders
CREATE TABLE IF NOT EXISTS bronze.orders (
    order_id smallint PRIMARY KEY NOT NULL,
    customer_id bpchar,
    employee_id smallint,
    order_date date,
    required_date date,
    shipped_date date,
    ship_via smallint,
    freight real,
    ship_name varchar(40),
    ship_address varchar(60),
    ship_city varchar(15),
    ship_region varchar(15),
    ship_postal_code varchar(10),
    ship_country varchar(15)
);

-- Tabela products
CREATE TABLE IF NOT EXISTS bronze.products (
    product_id smallint PRIMARY KEY NOT NULL,
    product_name varchar(40) NOT NULL,
    supplier_id smallint,
    category_id smallint,
    quantity_per_unit varchar(20),
    unit_price real,
    units_in_stock smallint,
    units_on_order smallint,
    reorder_level smallint,
    discontinued integer NOT NULL
);

-- Tabela shippers
CREATE TABLE IF NOT EXISTS bronze.shippers (
    shipper_id smallint PRIMARY KEY NOT NULL,
    company_name varchar(40) NOT NULL,
    phone varchar(24)
);

-- Tabela suppliers
CREATE TABLE IF NOT EXISTS bronze.suppliers (
    supplier_id smallint PRIMARY KEY NOT NULL,
    company_name varchar(40) NOT NULL,
    contact_name varchar(30),
    contact_title varchar(30),
    address varchar(60),
    city varchar(15),
    region varchar(15),
    postal_code varchar(10),
    country varchar(15),
    phone varchar(24),
    fax varchar(24),
    homepage text
);