-- A
SELECT dni
FROM Profesor P JOIN Departamento D USING(CodDep)
WHERE D.Nombre = 'Informática y Comunicaciones';

SELECT dni
FROM Profesor P JOIN Departamento D ON P.CodDep = D.CodDep
WHERE D.Nombre = 'Informática y Comunicaciones';

-- B
SELECT Nombre, prApellido
FROM Alumno A JOIN AlumBil B USING(dni)
WHERE UPPER(lugar) IN ('MADRID', 'BARCELONA');

SELECT Nombre, prApellido
FROM Alumno A JOIN AlumBil B ON A.dni = B.dni
WHERE UPPER(lugar) IN ('MADRID', 'BARCELONA');

-- C
SELECT Al.Nombre, Al.prApellido, Al.sgApellido
FROM Alumno Al JOIN Matricula M USING(dni) JOIN Asignatura Ag USING(CodAsig)
WHERE UPPER(Ag.Nombre) IN ('BASES DE DATOS', 'ACCESO A DATOS');

SELECT Al.Nombre, Al.prApellido, Al.sgApellido
FROM Alumno Al JOIN Matricula M ON Al.dni = M.dni JOIN Asignatura Ag ON M.CodAsig = Ag.CodAsig
WHERE UPPER(Ag.Nombre) IN ('BASES DE DATOS', 'ACCESO A DATOS');

-- D
SELECT Al.Nombre, Al.prApellido, Al.sgApellido
FROM Alumno Al JOIN Matricula M USING(dni) JOIN Asignatura Ag USING(CodAsig) JOIN Ciclo USING(CodCF)
WHERE Siglas = 'DAM' AND nota >= 5;

SELECT Al.Nombre, Al.prApellido, Al.sgApellido
FROM Alumno Al JOIN Matricula M ON Al.dni = M.dni JOIN Asignatura Ag ON M.CodAsig = Ag.CodAsig JOIN Ciclo C ON Ag.CodCF = C.CodCF
WHERE Siglas = 'DAM' AND nota >= 5;

-- E
SELECT Ag.Nombre
FROM Alumno Al JOIN Matricula M USING(dni) JOIN Asignatura Ag USING(CodAsig) JOIN Imparte I USING (CodAsig) JOIN Profesor P USING(dni) JOIN Departamento D USING(CodDep)
WHERE NH > 100 AND Siglas='DAM' AND M.curso=2023
UNION
SELECT Ag1.Nombre
FROM Asignatura Ag1 JOIN Ciclo C USING(CodCF)
WHERE C.Nombre='Inoformática y Comunicaciones';

SELECT Ag.Nombre
FROM Alumno Al JOIN Matricula M ON Al.dni = M.dni JOIN Asignatura Ag ON M.CodAsig = Ag.CodAsig JOIN Imparte I ON Ag.CodAsig = I.CodAsig JOIN Profesor P ON I.dni = P.dni JOIN Departamento D ON P.CodDep = D.CodDep
WHERE NH > 100 AND Siglas='DAM' AND M.curso=2023
UNION
SELECT Ag1.Nombre
FROM Asignatura Ag1 JOIN Ciclo C ON Ag.CodCF = C.CodCF
WHERE C.Nombre='Inoformática y Comunicaciones';