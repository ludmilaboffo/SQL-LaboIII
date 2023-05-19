Create Database CocinaApp
GO
Use CocinaApp
go
Create Table Platos(
    IDPLATO int not null primary key IDENTITY(1, 1),
    Nombre varchar(50) not null,
    TiempoCoccion smallint not null check(TiempoCoccion >0)
)

Create Table Ingredientes(
    IDIngrediente int not null primary key IDENTITY(1, 1),
    Nombre varchar(100) not null,
    Vegano bit,
    AptoCeliaco bit, 
)

go 
Create Table Recetas(
    IDIngrediente int FOREIGN KEY REFERENCES Ingredientes(IDIngrediente),
    IDPLATO int FOREIGN KEY REFERENCES Platos(IDPLATO),
    Cantidad decimal(6, 2) null,
    UnidadMedida varchar(50) not null,
    primary key (IDIngrediente, IDPlato)
)

-- Platos

