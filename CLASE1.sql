Create Database Clase01
Go
Use Clase01
Go
Create Table Areas(
    ID_Area smallint not null identity (1,1) primary key,
    Nombre varchar(250) not null ,
    Presupuesto money not null check(Presupuesto >0),
    Mail varchar(250) not null UNIQUE
)

GO
Create Table Empleados(
    Legajo smallint not null primary key, --- POR DEFECTO LA PRIMARY KEY ES NOT NULL
    ID_Area smallint null FOREIGN key references Areas(ID_Area),
    Apellido varchar(250) not null,
    Nombres varchar(250) not null,
    Telefono varchar(50) null
)


