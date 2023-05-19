--Listado con la cantidad de agentes

Select  Count(*) as CantidadAgentes From Agentes A

--Listado con importe de referencia promedio de los tipos de infracciones

Select AVG(T.ImporteReferencia) AS PromedioReferencial FROM TipoInfracciones T
--Listado con la suma de los montos de las multas. Indistintamente de si fueron pagadas o no.
Select SUM(M.Monto) as MontoMultas from Multas M

--Listado con la cantidad de pagos que se realizaron.
Select Count(*) as CantidadPagos from Multas M
Where (M.Pagada) = 1

--Listado con la cantidad de multas realizadas en la provincia de Buenos Aires.
Select Count(*) as MultasBsAs from Multas M 
INNER JOIN Localidades L on M.IDLocalidad = L.IDLocalidad
INNER JOIN Provincias P on L.IDProvincia = P.IDProvincia
WHERE P.provincia = 'Buenos Aires'
--NOTA: Utilizar el nombre 'Buenos Aires' de la provincia.
--Listado con el promedio de antigüedad de los agentes que se encuentren activos.
 
 -- DENTRO DE UNA FUNCION YO PUEDO LLAMAR A OTRA FUNCION
Select AVG(
    Cast(DATEDIFF(Year, FechaIngreso, GETDATE())  as decimal(10,1))
    ) as AntiguedadPromedio From Agentes A
    WHERE A.Activo =1 

   -- o

   Select AVG(
    DATEDIFF(Year, FechaIngreso, GETDATE()) *1.0
    ) as AntiguedadPromedio From Agentes A
    WHERE A.Activo =1 


--Listado con el monto más elevado que se haya registrado en una multa.
Select MAX(M.Monto) as MontoMaximo from Multas M
--Listado con el importe de pago más pequeño que se haya registrado.
Select MIN(M.Monto) as MontoMinimo from Multas M

--Por cada agente, listar Legajo, Apellidos y Nombres y la cantidad de multas que registraron.
Select A.IdAgente, A.Apellidos, A.Nombres, A.Legajo, Count(M.IdAgente) as CantMuLTAS
from Agentes A
INNER JOIN Multas M on A.IdAgente = M.IdAgente
GROUP by A.IdAgente, A.Apellidos, A.Nombres, A.Legajo

-- 10 Por cada tipo de infracción, listar la descripción y el promedio de montos de las multas asociadas
-- a dicho tipo de infracción.
Select T.IdTipoInfraccion, T.Descripcion, AVG(M.Monto) from TipoInfracciones T
INNER JOIN Multas M on T.IdTipoInfraccion = M.IdTipoInfraccion
Group by T.IdTipoInfraccion, T.Descripcion
 
-- 11 Por cada multa, indicar la fecha, la patente, el importe de la multa y la cantidad de pagos realizados.
-- Solamente mostrar la información de las multas que hayan sido pagadas en su totalidad.

Select  M.Monto, M.FechaHora, M.Patente, Count(M.Pagada) as Pagos from Multas M
group BY M.Monto, M.FechaHora, M.Patente
Having Count(M.Pagada)=1







-- 12 Listar todos los datos de las multas que hayan registrado más de un pago.
-- 13 Listar todos los datos de todos los agentes que hayan registrado multas con un monto que en promedio supere los $10000
-- 14 Listar el tipo de infracción que más cantidad de multas haya registrado.
-- 15 Listar por cada patente, la cantidad de infracciones distintas que se cometieron.





