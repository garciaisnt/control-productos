create database ControlProductosDS;
go

use ControlProductosDS;
go

create table DetalleProductos(
Id bigint not null primary key identity,
NomProducto varchar(50) not null,
Fecha date not null
);
go

create table Materiales(
Id bigint not null primary key identity,
NomMaterial varchar(50) not null,
Cantidad DECIMAL (18, 2)  not null,
UnidadMedida tinyint not null
);
go

create table Usuarios(
Id bigint not null primary key identity,
Nombres varchar(150) not null, 
Apellidos varchar(150) not null,
Usuario varchar(50) not null,
Clave varchar(250) not null,
Rol tinyint not null
);
go

create table MaterialesUtilizados(
Id bigint not null primary key identity,
IdMaterial bigint not null references Materiales(Id),
Cantidad DECIMAL (18, 2)  not null,
IdDetalleProductos bigint not null references DetalleProductos
);
go

select * from Materiales


