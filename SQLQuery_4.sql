Create Database DBTransito
go
Use DBTransito
Go

Create Table Multas(
    IDMulta int not null primary key identity(1, 1),
    IDTipoInfraccion int not null,
    IDAgente int null,
    Patente varchar(10) not null,
    ImporteMulta money not null,
    FechaHora datetime not null,
    Pagada bit not null default(0), --POR DEFECTO NO ESTA PAGADA
    Localidad int not null
)
GO
Create Table Agente(
    IDAgente int not null primary key identity(1, 1),
    Legajo varchar(10) not null,
    Nombres varchar(50) not null,
    Apellidos varchar(50) not null,
    FechaNac date not null,
    FechaIng date not null,
    Sueldo money not null default(100000),
    Email varchar(100) null,
    Telefono varchar(20) null,
    Celular varchar(20) null,
    Activo bit not null default(1)
)

GO
Create Table TipoInfracciones(
    IDTipoInfraccion int not null primary key identity(1, 1),
    Descripcion varchar(100),
    ImporteReferencia money not null,
)
GO
Create Table Localidades(
    IDLocalidad int not null primary key identity(1, 1),
    Localidad varchar(150) not null,
    IDProvincia int not NULL
)
GO
Create Table Provincias(
    IDProvincias int not null primary key identity(1, 1),
    Provincia varchar(50) not NULL
)
GO

-- RESTRICCIONES MULTAS
Alter Table Multas 
-- CONSTRAINT_ RESTRICCION
Add CONSTRAINT FK_Multas_Localidades FOREIGN key 
(Localidad) References Localidades(IDLocalidad)
GO
Alter Table Multas
Add CONSTRAINT FK_Multas_TipoInfracciones FOREIGN KEY (IDTipoInfraccion) References TipoInfracciones(IDTipoInfraccion)
Go
Alter Table Multas 
Add Constraint FK_Multas_Agentes FOREIGN KEY (IDAgente) References Agente(IDAgente)
GO
Alter Table Multas
Add Constraint CHK_MONTO_POS CHECK(ImporteMulta>0)
Go
--- restricciones de agentes ---

Alter Table Agente
Add Constraint UQ_Legajo Unique(Legajo)
GO

--- localidades
Alter Table Localidades
Add Constraint FK_Localidades_PROV FOREIGN key (IDProvincia) references Provincias(IDProvincias)
go
-- Agregamos una columna, la agregamos y despues la borramos
Alter Table Agente
Add EstadoCivil varchar(20) NULL
go
Alter TABLE Agente
Alter Column EstadoCivil varchar(50) not NULL
GO
-- DROP ES PARA BORRAR
Alter TABLE Agente
Drop Column EstadoCivil 