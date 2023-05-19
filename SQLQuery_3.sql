Create DATABASE Universidad
GO
Use Universidad
GO


Create Table Carreras(
    CodCarrera int not null primary key,
    Nombre varchar(50) not null,
    Resolucion varchar(150) not null
)
GO
Create Table Materias(
    CodMateria int not null PRIMARY key,
    CodCarrera int not null FOREIGN key references Carreras(CodCarrera),
    Nombre varchar(50) not null,
)
GO
Create Table Profesores(
    Legajo int not null primary key,
    DNI int not null unique,
    FechaNac date not null,
    Edad smallint not null check(Edad>0),
    Nombre varchar(50) not null,
    Apellido varchar(50) not null,
)
GO
Create Table CargoDocente(
    IDCargo int not null PRIMARY key,
    NombreCargo varchar(50) not null
)
Go

Create Table Plantas(
    Legajo int not null FOREIGN key references Profesores(Legajo),
    CodMateria int not null FOREIGN KEY references Materias(CodMateria),
    Anio date not null,
    IDCargo int not null FOREIGN key references CargoDocente(IDCargo),
    PRIMARY KEY (Legajo, CodMateria,ANIO)
)