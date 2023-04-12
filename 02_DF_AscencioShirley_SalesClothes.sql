/* Poner en uso base de datos master */
USE master;

/* Crear base de datos Sales Clothes */
DROP DATABASE IF EXISTS db_SalesClothes;
CREATE DATABASE db_SalesClothes;

/* Poner en uso la base de datos */
USE db_SalesClothes;

/* Crear tabla client */
CREATE TABLE client
(
	id int,
	type_document char(3),
	number_document char(15),
	names varchar(60),
	last_name varchar(90),
	email varchar(80),
	cell_phone char(9),
	birthdate date,
	active bit
	CONSTRAINT client_pk PRIMARY KEY (id)
);

/* Crear tabla clothes */
CREATE TABLE clothes (
    id int  NOT NULL,
    description varchar(60)  NOT NULL,
    brand varchar(60)  NOT NULL,
    amount int  NOT NULL,
    size varchar(10)  NOT NULL,
    price decimal(8,2)  NOT NULL,
    active bit  NOT NULL,
    CONSTRAINT clothes_pk PRIMARY KEY  (id)
);

/* Crear tabla sale */
CREATE TABLE sale (
    id int  NOT NULL,
    date_time datetime  NOT NULL,
    active bit  NOT NULL,
    client_id int  NOT NULL,
    seller_id int  NOT NULL,
    CONSTRAINT sale_pk PRIMARY KEY  (id)
);;


/* Crear tabla sale_detail */
CREATE TABLE sale_detail (
    id int  NOT NULL,
    amount int  NOT NULL,
    sale_id int  NOT NULL,
    clothes_id int  NOT NULL,
    CONSTRAINT sale_detail_pk PRIMARY KEY  (id)
);

/* Crear tabla seller */
CREATE TABLE seller (
    id int  NOT NULL,
    type_document char(3)  NOT NULL,
    number_document char(15)  NOT NULL,
    names varchar(60)  NOT NULL,
    last_name varchar(90)  NOT NULL,
    salary decimal(8,2)  NOT NULL,
    cell_phone char(9)  NOT NULL,
    email varchar(80)  NOT NULL,
    active bit  NOT NULL,
    CONSTRAINT seller_pk PRIMARY KEY  (id)
);


/* Relacionar tabla sale con tabla client */
ALTER TABLE sale ADD CONSTRAINT sale_client
    FOREIGN KEY (client_id)
    REFERENCES client (id);

/* Relacionar tabla sale_detail con tabla clothes */
ALTER TABLE sale_detail ADD CONSTRAINT sale_detail_clothes
    FOREIGN KEY (clothes_id)
    REFERENCES clothes (id);

/* Relacionar tabla sale_detail con tabla sale */
ALTER TABLE sale_detail ADD CONSTRAINT sale_detail_sale
    FOREIGN KEY (sale_id)
    REFERENCES sale (id);

/* Relacionar tabla sale con tabla seller */
ALTER TABLE sale ADD CONSTRAINT sale_seller
    FOREIGN KEY (seller_id)
    REFERENCES seller (id);
