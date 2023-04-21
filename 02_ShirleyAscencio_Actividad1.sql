                           --------ACTIVIDAD 1--------02_ShirleyAscencio------
--1. Crear un nuevo script New Query.
--2. Eliminar y crear la base de datos db_SalesClothes.
DROP DATABASE IF EXISTS db_SalesClothes
GO

CREATE DATABASE db_SalesClothes
GO


--3 Poner en uso la base de datos db_SalesClothes.
USE db_SalesClothes
GO


--4 Configurar el idioma español el motor de base de datos.
SET LANGUAGE Español
GO

SELECT @@language AS 'Idioma'
GO


--5 Configurar el formato de fecha en dmy (día, mes y año) en el motor de base de datos.
SET DATEFORMAT dmy
GO

--6 Crear la tabla client con la siguiente estructura:
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

                      --7 Tener presente las siguientes restricciones para la tabla client:---
--7.1 El campo id es clave principal y autoincrementable, empieza en 1 e incrementa de 1 en uno.

--Quitar Primary Key en tabla client 
ALTER TABLE client
	DROP CONSTRAINT client_pk
GO

-- Quitar columna id en tabla cliente 
ALTER TABLE client
	DROP COLUMN id
GO

-- Agregar columna client 
ALTER TABLE client
	ADD id int identity(1,1)
GO

--Agregar restricción primary key 
ALTER TABLE client
	ADD CONSTRAINT client_pk 
	PRIMARY KEY (id)
GO


--7.2 El campo type_document sólo puede admitir datos como DNI ó CNE
ALTER TABLE client
	DROP COLUMN type_document
GO

--Agregar restricción para tipo documento #EEEEEEEEEEEEEEEEEEEEEEEEE
ALTER TABLE client
	ADD type_document char(3)
	CONSTRAINT type_document_client 
	CHECK(type_document ='DNI' OR type_document ='CNE')
GO

--Eliminar columna number_document de tabla client 
ALTER TABLE client
	DROP COLUMN number_document
GO


--7.3El campo number_document sólo permite dígitos entre 0 a 9, y serán 8 cuando es DNI y 9 cuando sea CNE.
ALTER TABLE client
	ADD number_document char(9)
	CONSTRAINT number_document_client
	CHECK (number_document like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][^A-Z]')
GO

--7.4 El el campo email sólo permite correos electrónicos válidos, por ejemplo: mario@gmail.com

--Eliminar columna email de tabla client 
ALTER TABLE client
	DROP COLUMN email
GO

--Agregar columna email 
ALTER TABLE client
	ADD email varchar(80)
	CONSTRAINT email_client
	CHECK(email LIKE '%@%._%')
GO

--7.5 El campo cell_phone acepta solamente 9 dígitos numéricos, por ejemplo: 997158238.

--Eliminar columna celular 
ALTER TABLE client
	DROP COLUMN cell_phone
GO

--7.6 Validar que el celular esté conformado por 9 números 
ALTER TABLE client
	ADD cell_phone char(9)
	CONSTRAINT cellphone_client
	CHECK (cell_phone like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
GO

--7.7 El campo birthdate sólo permite la fecha de nacimiento de clientes mayores de edad.

--Eliminar columna fecha de nacimiento 
ALTER TABLE client
	DROP COLUMN birthdate
GO

--Sólo debe permitir el registro de clientes mayores de edad 
ALTER TABLE client
	ADD  birthdate date
	CONSTRAINT birthdate_client
	CHECK((YEAR(GETDATE())- YEAR(birthdate )) >= 18)
GO

--7.8 El campo active tendrá como valor predeterminado 1, que significa que el cliente está activo.

--Eliminar columna active de tabla client 
ALTER TABLE client
	DROP COLUMN active
GO

--El valor predeterminado será activo al registrar clientes 
ALTER TABLE client
	ADD active bit DEFAULT (1)
GO

--8 Crear la tabla seller con la siguiente estructura:
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

               --9Tener presente las siguientes restricciones para la tabla seller:--


--9.1 El campo id es clave principal y autoincrementable, empieza en 1 e incrementa de 1 en uno.

--Quitar Primary Key en tabla seller 
ALTER TABLE seller
	DROP CONSTRAINT seller_pk
GO

--Quitar columna id en tabla seller 
ALTER TABLE seller
	DROP COLUMN id
GO

--Agregar columna seller 
ALTER TABLE seller
	ADD id int identity(1,1)
GO

-- Agregar restricción primary key 
ALTER TABLE seller
	ADD CONSTRAINT seller_pk 
	PRIMARY KEY (id)
GO


--9.2 El campo type_document sólo puede admitir datos como DNI ó CNE

--El tipo de documento puede ser DNI ó CNE
ALTER TABLE seller
	DROP COLUMN type_document
GO

--Agregar restricción para tipo documento
ALTER TABLE seller
	ADD type_document char(3)
	CONSTRAINT type_document_seller
	CHECK( type_document ='DNI' OR type_document ='CNE')
GO


--9.3 El campo number_document sólo permite dígitos entre 0 a 9, y serán 8 cuando es DNI y 9 cuando sea CNE.

-- Eliminar columna number_document de tabla seller
ALTER TABLE seller
	DROP COLUMN number_document
GO

--El número de documento sólo debe permitir dígitos de 0 - 9 
ALTER TABLE seller
	ADD number_document char(9)
	CONSTRAINT number_document_seller
	CHECK (number_document like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][^A-Z]')
GO


--9.4 El campo salary tiene como valor predeterminado 1025

--Eliminar columna salary de tabla seller 
ALTER TABLE seller
	DROP COLUMN salary
GO

--Crear columna seller en la tabla salary
ALTER TABLE seller
	ADD salary decimal(8,2)
GO

--Poner como default '1025' en la columna salary
ALTER TABLE seller 
	ADD DEFAULT 1025 FOR salary
GO


--9.5 El campo cell_phone acepta solamente 9 dígitos numéricos, por ejemplo: 997158238.

-- Eliminar columna celular 
ALTER TABLE seller
	DROP COLUMN cell_phone
GO

--Validar que el celular esté conformado por 9 números 
ALTER TABLE seller
	ADD cell_phone char(9)
	CONSTRAINT cellphone_seller
	CHECK (cell_phone like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
GO


--9.6El el campo email sólo permite correos electrónicos válidos, por ejemplo: roxana@gmail.com

--Eliminar columna email de tabla seller
ALTER TABLE seller
	DROP COLUMN email
GO

-- Agregar columna email
ALTER TABLE seller
	ADD email varchar(80)
	CONSTRAINT email_seller
	CHECK(email LIKE '%@%._%')
GO


--9.7 El campo active tendrá como valor predeterminado 1, que significa que el cliente está activo.

--Eliminar columna active de tabla seller 
ALTER TABLE seller
	DROP COLUMN activo
GO

-- El valor predeterminado será activo al registrar sellers 
ALTER TABLE seller
	ADD active bit DEFAULT (1)
GO

--10 Crear la tabla clothes con la siguiente estructura:
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

       --11 Tener presente las siguientes restricciones para la tabla clothes:--


--11.1 El campo id es clave principal y autoincrementable, empieza en 1 e incrementa de 1 en uno.

--Quitar Primary Key en tabla clothes 
ALTER TABLE clothes
	DROP CONSTRAINT clothes_pk
GO

-- Quitar columna id en tabla clothes 
ALTER TABLE clothes
	DROP COLUMN id
GO

--Agregar columna id en la tabla clothes 
ALTER TABLE clothes
	ADD id int identity(1,1)
GO

-- Agregar restricción primary key 
ALTER TABLE clothes
	ADD CONSTRAINT clothes_pk 
	PRIMARY KEY (id)
GO
--11.2 El campo active tendrá como valor predeterminado 1, que significa que el cliente está activo.

--Eliminar columna active de tabla clothes
ALTER TABLE clothes
	DROP COLUMN active
GO

--El valor predeterminado será activo al registrar clothes 
ALTER TABLE clothes
	ADD active bit DEFAULT (1)
GO


--12 Crear tabla sale con la siguiente estructura:
CREATE TABLE sale (
    id int,
    date_time datetime,
	seller_id int,
    client_id int,
    active bit,
    CONSTRAINT sale_pk PRIMARY KEY (id)
);

               --13 Tener presente las siguientes restricciones para la tabla sale:--


--13.1 El campo id es clave principal y autoincrementable, empieza en 1 e incrementa de 1 en uno.

--Quitar Primary Key en tabla sale 
ALTER TABLE sale
	DROP CONSTRAINT sale_pk
GO

-- Quitar columna id en tabla sale 
ALTER TABLE sale
	DROP COLUMN id
GO

-- Agregar columna id en la tabla sale
ALTER TABLE sale
	ADD id int identity(1,1)
GO

-- Agregar restricción primary key
ALTER TABLE sale
	ADD CONSTRAINT sale_pk 
	PRIMARY KEY (id)
GO
--13.2 El campo date_time debe tener como valor predeterminado la fecha y hora del servidor.

--Quitar columna date_time en tabla sale
ALTER TABLE sale
	DROP COLUMN date_time
GO

-- Agregar columna date_time en la columna sale 
ALTER TABLE sale
	ADD date_time datetime
GO

--Valor predeterminado fecha y hora del servidor 
ALTER TABLE sale
	ADD CONSTRAINT date_time_sale DEFAULT (GETDATE()) FOR date_time
GO


--13.3 El campo active tendrá como valor predeterminado 1, que significa que el cliente está activo.

--Eliminar columna active de tabla sale 
ALTER TABLE sale
	DROP COLUMN active
GO

--El valor predeterminado será activo al registrar sales
ALTER TABLE sale
	ADD active bit DEFAULT (1)
GO


--14 Crear tabla sale_detail con la siguiente estructura:

CREATE TABLE sale_detail (
    id int ,
    sale_id int ,
    clothes_id int ,
    amount int ,
    CONSTRAINT sale_detail_pk PRIMARY KEY (id)
);



--15 Utilizando código T-SQL crear las relaciones entre las tablas de acuerdo a la siguiente imagen:---


--Relacionar tabla sale con seller 
ALTER TABLE sale
	ADD CONSTRAINT sale_seller FOREIGN KEY (seller_id)
	REFERENCES seller (id)
	ON UPDATE CASCADE
	ON DELETE CASCADE
GO

--Relacionar tabla sale con tabla client 
ALTER TABLE sale
	ADD CONSTRAINT sale_client FOREIGN KEY (client_id)
	REFERENCES client (id)
	ON UPDATE CASCADE 
	ON DELETE CASCADE
GO

--Relacionar tabla sale con sale_detail 
ALTER TABLE sale_detail
	ADD CONSTRAINT sale_detail_sale FOREIGN KEY (sale_id)
	REFERENCES sale (id)
	ON UPDATE CASCADE
	ON DELETE CASCADE
GO

--Relacionar tabla sale_detail con clothes 
ALTER TABLE sale_detail
	ADD CONSTRAINT sale_detail_clothes FOREIGN KEY (clothes_id)
	REFERENCES clothes (id)
	ON UPDATE CASCADE
	ON DELETE CASCADE
GO