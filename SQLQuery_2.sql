Use CocinaApp
GO

-- PLATOS

Insert into Platos(Nombre,TiempoCoccion)
VALUES
('Milanesa Carne', 50),
('Tacos veggies', 80),
('Lasana', 90)

-- INGREDIENTES

Insert into Ingredientes (Nombre, Vegano, AptoCeliaco)
VALUES
('PECETO', 0, 1),
('Pan Rallado', 1, 1),
('Huevos', 0, 1),
('Ajo', 0 ,1),

('Tortitas de arroz', 1, 1),
('Soja texturizada', 1, 1),
('Salsa de tomate', 1, 1),

('Queso', 0, 1),
('Harina', 1, 0),
('Ricota', 0, 1),
('Agua', 1, 1)

-- MODIFICACION
DELETE from Ingredientes WHERE IDIngrediente >100
