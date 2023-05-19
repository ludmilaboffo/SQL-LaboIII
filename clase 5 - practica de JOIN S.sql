/*Listado con las localidades, su ID, nombre y el nombre de la provincia a la que pertenece.*/ 
SELECT P.Provincia, L.Localidad FROM Provincias AS P
INNER JOIN  Localidades AS L
On P.IDProvincia = L.IDProvincia

/*Listado que informe el ID de la multa, el monto a abonar y los datos del agente que la realizó.
 Debe incluir los apellidos y nombres de los agentes. Así como también la fecha de nacimiento y la edad.*/
 SELECT M.Monto, M.IdMulta, A.Nombres, A.Apellidos, A.FechaNacimiento, DateDiff(Year, FechaNacimiento, getdate()) - 
Case
    When Month(getdate()) < Month(FechaNacimiento) Or (Month(getdate()) = Month(FechaNacimiento) And Day(getdate()) < Day(FechaNacimiento)) Then 1
    Else 0
End
 as Edad FROM AGENTES AS A
 INNER JOIN MULTAS AS M
 ON A.IdAgente = M.IdAgente
 
 /*Listar todos los datos de todas las multas realizadas por agentes que a la fecha
  de hoy tengan más de 5 años de antigüedad*/




SELECT M.IdTipoInfraccion, M.IDLocalidad, M.IdAgente, M.Patente, M.FechaHora, M.Monto,M.Pagada, A.FechaIngreso FROM MULTAS AS M
LEFT JOIN AGENTES AS A
ON M.IdAgente = A.IdAgente
WHERE DATEDIFF(YEAR, A.FechaIngreso, GETDATE()) >5

/*Listar todos los datos de todas las multas cuyo importe de referencia supere los $15000.*/

SELECT  M.IdTipoInfraccion, M.IDLocalidad, M.IdAgente, M.Patente, M.FechaHora, M.Monto,M.Pagada, T.ImporteReferencia FROM MULTAS AS M
left JOIN TipoInfracciones AS T
ON M.IdTipoInfraccion = T.IdTipoInfraccion
WHERE T.ImporteReferencia > 15000

/*Listar los nombres y apellidos de los agentes, sin repetir,
 que hayan labrado multas en la provincia de Buenos Aires o en Cordoba.*/

 SELECT A.NOMBRES, A.APELLIDOS FROM AGENTES AS A
 INNER JOIN MULTAS AS M
 ON A.IdAgente = M.IdAgente

 INNER JOIN Localidades as L
 on M.IDLocalidad = L.IDLocalidad

 INNER JOIN Provincias AS P
 on P.IDProvincia = L.IDProvincia
 WHERE P.Provincia = 'Cordoba' OR P.Provincia = 'Buenos Aires'


/*Listar los nombres y apellidos de los agentes, sin repetir,
 que hayan labrado multas del tipo "Exceso de velocidad".
*/

SELECT A.NOMBRES, A.APELLIDOS, T.Descripcion FROM AGENTES AS A
INNER JOIN MULTAS AS M
ON A.IdAgente = M.IdAgente

INNER JOIN TipoInfracciones AS T
ON M.IdTipoInfraccion = T.IdTipoInfraccion
WHERE T.IdTipoInfraccion = 1

/*Por cada multa, lista el nombre de la localidad y provincia,
 el tipo de multa, los apellidos y nombres de los agentes y su legajo, 
 el monto de la multa y la diferencia en pesos en relación al tipo de infracción cometida.*/

SELECT L.Localidad, P.Provincia, M.IdTipoInfraccion, A.Apellidos, A.Nombres, A.Legajo, M.Monto, (M.monto - t.IdTipoInfraccion) as 'Diferencia' FROM MULTAS AS M
LEFT JOIN AGENTES AS A
ON M.IdAgente = a.IdAgente

LEFT JOIN TipoInfracciones AS T
ON M.IdTipoInfraccion = T.IdTipoInfraccion

LEFT JOIN Localidades AS L
ON M.IDLocalidad = L.IDLocalidad

LEFT JOIN Provincias as P
ON L.IDLocalidad = P.IDProvincia

/*LOCALIDADES SIN MULTAS */

SELECT * FROM Localidades L
LEFT JOIN Multas M
ON L.IDLocalidad = M.IDLocalidad
WHERE M.IdMulta IS NULL 

-- LISTAR EL ID DE LA MULTA . . . . 11
SELECT M.IdMulta, M.Patente, M.Monto as ImporteReal, T.ImporteReferencia,
Case
    When M.Monto > T.ImporteReferencia then 'Punitorio'
    When M.Monto < T.ImporteReferencia then 'Leve'
    When M.Monto = T.ImporteReferencia then 'Justo'   
 End As 'Tipo de importe'
FROM Multas M
INNER JOIN TipoInfracciones T
ON  T.IdTipoInfraccion = M.IdTipoInfraccion

