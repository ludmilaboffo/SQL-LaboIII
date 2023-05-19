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

Select count(P.Importe) as CantidadDePagos, M.FechaHora, M.Monto as Importe, M.Patente from Pagos P
INNER JOIN Multas M on  M.IdMulta =P.IDMulta
GROUP by M.FechaHora, M.Monto, M.Patente, M.IdMulta 
HAVING SUM(P.Importe)>= M.Monto

-- 12 Listar todos los datos de las multas que hayan registrado más de un pago.

Select M.IdMulta, M.FechaHora, M.IdAgente, M.IDLocalidad, M.IdTipoInfraccion, M.Monto, M.Patente, M.Pagada,Count(P.Importe) as CantidadDePagos from Multas M
INNER JOIN Pagos P on P.IDMulta = M.IdMulta
Group by M.IdMulta, M.FechaHora, M.IdAgente, M.IDLocalidad, M.IdTipoInfraccion, M.Monto, M.Patente, M.Pagada
Having Count(P.Importe) >1

-- 13 Listar todos los datos de todos los agentes que hayan registrado multas
-- con un monto que en promedio supere los $10000

Select AVG(M.Monto) as Montopromedio, A.IdAgente, A.Apellidos, A.Nombres From Agentes A
INNER JOIN Multas M on M.IdAgente = a.IdAgente
Group By A.IdAgente, A.Apellidos, A.Nombres
HAVING AVG(M.Monto) > 10000

-- 14 Listar el tipo de infracción que más cantidad de multas haya registrado.

Select TOP 1 Count(M.IdTipoInfraccion) as CantidadDeMultas, T.Descripcion, T.IdTipoInfraccion FROM TipoInfracciones T
INNER JOIN Multas M on T.IdTipoInfraccion = M.IdTipoInfraccion
GROUP BY t.IdTipoInfraccion, t.Descripcion
--Order by Count(M.IdTipoInfraccion) desc

-- 15 Listar por cada patente, la cantidad de infracciones distintas que se cometieron.
Select M.Patente,  Count(M.IdTipoInfraccion) AS TiposDiferentes from TipoInfracciones T
INNER JOIN Multas M on T.IdTipoInfraccion = m.IdTipoInfraccion
Group by M.Patente

--16 Listar por cada patente, el texto literal 'Multas pagadas' y el monto total de los pagos registrados
-- por esa patente. Además, por cada patente, el texto literal 'Multas por pagar' y el monto total de lo que 
-- se adeuda.

select distinct M.Patente, 'Multas pagadas' Multas_Pagadas, sum(P.Importe) PImporte, 'Multas por pagar' Multas_por_Pagar, (sum(distinct M.Monto)-sum(P.Importe)) Deuda from Multas M
full join Pagos P on P.IDMulta = M.IDMulta
group by M.Patente

-- 17 Listado con los nombres de los medios de pagos que se hayan utilizado más de 3 veces.

-- 18 Los legajos, apellidos y nombres de los agentes que hayan labrado más de 2 multas con tipos de infracciones distintas.
-- 19 El total recaudado en concepto de pagos discriminado por nombre de medio de pago.
--20 Un listado con el siguiente formato:
/*
Descripción        Tipo           Recaudado
-----------------------------------------------
Tigre              Localidad      $xxxx
San Fernando       Localidad      $xxxx
Rosario            Localidad      $xxxx
Buenos Aires       Provincia      $xxxx
Santa Fe           Provincia      $xxxx
Argentina          País           $xxxx*/











