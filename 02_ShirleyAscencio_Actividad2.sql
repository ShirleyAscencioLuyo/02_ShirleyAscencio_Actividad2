                                     --ACTIVIDAD2---02_ShirleyAscencio--
--1.Crear un nuevo script New Query.
--2.Eliminar y crear la base de datos db_SalesClothes.
DROP DATABASE IF EXISTS db_SalesClothes
GO

CREATE DATABASE db_SalesClothes
GO

--3.Poner en uso la base de datos db_SalesClothes.
USE db_SalesClothes
GO
--4.Configurar el idioma español el motor de base de datos.
SET LANGUAGE Español
GO

SELECT @@language AS 'Idioma'
GO

---5.Configurar el formato de fecha en dmy (día, mes y año) en el motor de base de datos.

SET DATEFORMAT dmy
GO

                  --6.Insertar los siguientes registros en la tabla client----
--6.1 Crear tabla client 
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


--6.2 Quitar Primary Key en tabla client
ALTER TABLE client
	DROP CONSTRAINT client_pk
GO

--6.3 Quitar columna id en tabla cliente 
ALTER TABLE client
	DROP COLUMN id
GO

--6.4 Agregar columna client
ALTER TABLE client
	ADD id int identity(1,1)
GO

--6.5 Agregar restricción primary key 
ALTER TABLE client
	ADD CONSTRAINT client_pk 
	PRIMARY KEY (id)
GO

--6.6 El tipo de documento puede ser DNI ó CNE 
ALTER TABLE client
	DROP COLUMN type_document
GO

--6.7 Agregar restricción para tipo documento 
ALTER TABLE client
	ADD type_document char(3)
	CONSTRAINT type_document_client
	CHECK( type_document ='DNI' OR type_document ='CNE')
GO

--6.8 Eliminar columna number_document de tabla client
ALTER TABLE client
	DROP COLUMN number_document
GO

--6.9 El número de documento sólo debe permitir dígitos de 0 - 9 
ALTER TABLE client
	ADD number_document char(9)
	CONSTRAINT number_document_client
	CHECK (number_document like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][^A-Z]')
GO

--6.10Eliminar columna email de tabla client 
ALTER TABLE client
	DROP COLUMN email
GO

--6.11 Agregar columna email
ALTER TABLE client
	ADD email varchar(80)
	CONSTRAINT email_client
	CHECK(email LIKE '%@%._%')
GO

--6.12 Eliminar columna celular
ALTER TABLE client
	DROP COLUMN cell_phone
GO

--6.13 Validar que el celular esté conformado por 9 números 
ALTER TABLE client
	ADD cell_phone char(9)
	CONSTRAINT cellphone_client
	CHECK (cell_phone like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
GO

--6.14 Eliminar columna fecha de nacimiento 
ALTER TABLE client
	DROP COLUMN birthdate
GO

--6.15 Sólo debe permitir el registro de clientes mayores de edad
ALTER TABLE client
	ADD  birthdate date
	CONSTRAINT birthdate_client
	CHECK((YEAR(GETDATE())- YEAR(birthdate )) >= 18)
GO

--6.16 Eliminar columna active de tabla client 
ALTER TABLE client
	DROP COLUMN active
GO

--6.17 El valor predeterminado será activo al registrar clientes 
ALTER TABLE client
	ADD active bit DEFAULT (1)
GO


--6.18 Insertar los siguientes registros en la tabla client
INSERT INTO client 
	(type_document, number_document, names, last_name, email, cell_phone, birthdate)
VALUES
	('DNI', '78451233', 'Fabiola', 'Perales Campos', 'fabiolaperales@gmail.com', '991692597', '19/01/2005'),
	('DNI', '14782536', 'Marcos', 'Dávila Palomino', 'marcosdavila@gmail.com', '982514752', '03/03/1990'),
	('DNI', '78451236', 'Luis Alberto', 'Barrios Paredes', 'luisbarrios@outlook.com', '985414752', '03/10/1995'),
	('CNE', '352514789', 'Claudia María', 'Martínez Rodríguez', 'claudiamartinez@yahoo.com', '995522147', '23/09/1992'),
	('CNE', '142536792', 'Mario Tadeo', 'Farfán Castillo', 'mariotadeo@outlook.com', '973125478', '25/11/1997'),
	('DNI', '58251433', 'Ana Lucrecia', 'Chumpitaz Prada', 'anachumpitaz@gmail.com', '982514361', '17/10/1992'),
	('DNI', '15223369', 'Humberto', 'Cabrera Tadeo', 'humbertocabrera@yahoo.com', '977112234', '27/05/1990'),
	('CNE', '442233698', 'Rosario', 'Prada Velásquez', 'rosarioprada@outlook.com', '971144782', '05/11/1990')
GO


                       --7 Insertar los siguientes registros en la tabla seller--------

--7.1 Crear tabla seller 
CREATE TABLE seller (
    id int ,
    type_document char(3),
    number_document char(15) ,
    names varchar(60),
    last_name varchar(90),
    salary decimal(8,2),
    cell_phone char(9),
    email varchar(80),
    activo bit  ,
    CONSTRAINT seller_pk PRIMARY KEY (id)
);

--7.2 Quitar Primary Key en tabla seller 
ALTER TABLE seller
	DROP CONSTRAINT seller_pk
GO

--7.3 Quitar columna id en tabla seller 
ALTER TABLE seller
	DROP COLUMN id
GO

--7.4 Agregar columna seller 
ALTER TABLE seller
	ADD id int identity(1,1)
GO

--Agregar restricción primary key 
ALTER TABLE seller
	ADD CONSTRAINT seller_pk 
	PRIMARY KEY (id)
GO

--7.5 El tipo de documento puede ser DNI ó CNE 
ALTER TABLE seller
	DROP COLUMN type_document
GO

--7.6 Agregar restricción para tipo documento 
ALTER TABLE seller
	ADD type_document char(3)
	CONSTRAINT type_document_seller
	CHECK( type_document ='DNI' OR type_document ='CNE')
GO

--7.7 Eliminar columna number_document de tabla seller 
ALTER TABLE seller
	DROP COLUMN number_document
GO

--7.8 El número de documento sólo debe permitir dígitos de 0 - 9 
ALTER TABLE seller
	ADD number_document char(9)
	CONSTRAINT number_document_seller
	CHECK (number_document like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][^A-Z]')
GO

--7.9 Eliminar columna salary de tabla seller 
ALTER TABLE seller
	DROP COLUMN salary
GO

--7.10 Crear columna seller en la tabla salary 
ALTER TABLE seller
	ADD salary decimal(8,2)
GO

--7.11 Poner como default '1025' en la columna salary
ALTER TABLE seller 
	ADD DEFAULT 1025 FOR salary
GO

--7.12 Eliminar columna celular 
ALTER TABLE seller
	DROP COLUMN cell_phone
GO

--7.13 Validar que el celular esté conformado por 9 números 
ALTER TABLE seller
	ADD cell_phone char(9)
	CONSTRAINT cellphone_seller
	CHECK (cell_phone like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
GO

--7.14 Eliminar columna email de tabla seller
ALTER TABLE seller
	DROP COLUMN email
GO

--7.15 Agregar columna email 
ALTER TABLE seller
	ADD email varchar(80)
	CONSTRAINT email_seller
	CHECK(email LIKE '%@%._%')
GO

--7.16 Eliminar columna active de tabla seller
ALTER TABLE seller
	DROP COLUMN activo
GO

--7.17 El valor predeterminado será activo al registrar sellers
ALTER TABLE seller
	ADD active bit DEFAULT (1)
GO

--7.18 Insertar los siguientes registros en la tabla seller
INSERT INTO seller
	(type_document, number_document, names, last_name, cell_phone, email)
VALUES
	('DNI', '11224578', 'Oscar', 'Paredes Flores', '985566251', 'oparedes@miemrpesa.com'),
	('CNE', '889922365', 'Azucena', 'Valle Alcazar', '966338874', 'avalle@miemrpesa.com'),
	('DNI', '44771123', 'Rosario', 'Huarca Tarazona', '933665521', 'rhuaraca@miempresa.com')
GO
                                 --8 Insertar los siguientes registros en la tabla clothes--
--8.1 Crear tabla clothes 
CREATE TABLE clothes (
    id int,
    descriptions varchar(60),
    brand varchar(60),
    amount int ,
    size varchar(10) ,
    price decimal(8,2) ,
    active bit ,
    CONSTRAINT clothes_pk PRIMARY KEY (id)
);

--8.2 Quitar Primary Key en tabla clothes
ALTER TABLE clothes
	DROP CONSTRAINT clothes_pk
GO

--8.3 Quitar columna id en tabla clothes
ALTER TABLE clothes
	DROP COLUMN id
GO

--8.4 Agregar columna id en la tabla clothes
ALTER TABLE clothes
	ADD id int identity(1,1)
GO

--8.5 Agregar restricción primary key
ALTER TABLE clothes
	ADD CONSTRAINT clothes_pk 
	PRIMARY KEY (id)
GO

--8.6 Eliminar columna active de tabla clothes
ALTER TABLE clothes
	DROP COLUMN active
GO

--8.7 El valor predeterminado será activo al registrar clothes
ALTER TABLE clothes
	ADD active bit DEFAULT (1)
GO
--8.8 Insertar los siguientes registros en la tabla clothes
INSERT INTO  clothes
	(descriptions, brand, amount, size, price)
VALUE
	('Polo camisero', 'Adidas', '20', 'Medium', '40.50'),
	('Short playero', 'Nike', '30', 'Medium', '55.50'),
	('Camisa sport', 'Adams', '60', 'Large', '60.80'),
	('Camisa sport', 'Adams', '70', 'Medium', '58.75'),
	('buzo de verano', 'Reebok', '45', 'Small', '62.90'),
	('Pantalón Jean', 'Lewis', '35', 'Large', '73.60')
GO


--9 Listar todos los datos de los clientes (client) cuyo tipo de documento sea DNI
SELECT *
FROM client
WHERE type_document LIKE 'DNI'
GO

--10 Listar todos los datos de los clientes (client) cuyo servidor de correo electrónico sea outlook.com.
SELECT *
FROM client
WHERE email LIKE '%@outlook.com'
GO
--11 Listar todos los datos de los vendedores (seller) cuyo tipo de documento sea CNE.
SELECT *
FROM seller
WHERE type_document LIKE 'CNE'
GO
--12 Listar todas las prendas de ropa (clothes) cuyo costo sea menor e igual que S/. 55.00
SELECT *
FROM clothes
WHERE price <= 55.00
GO
--13 Listar todas las prendas de ropa (clothes) cuya marca sea Adams.
SELECT *
FROM clothes
WHERE brand LIKE 'Adams'
GO
--14 Eliminar lógicamente los datos de un cliente client de acuerdo a un determinado id.
UPDATE client
SET active = '0' 
WHERE id = '2'
GO
--15 Eliminar lógicamente los datos de un cliente seller de acuerdo a un determinado id.
UPDATE seller
SET active = '0' 
WHERE id = '1'
GO
--16 Eliminar lógicamente los datos de un cliente clothes de acuerdo a un determinado id 
UPDATE clothes
SET active = '0' 
WHERE id = '4'
GO