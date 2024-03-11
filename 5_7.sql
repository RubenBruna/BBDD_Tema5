-- Consultas sobre una tabla
-- A
SELECT NOMBBRE
FROM PRODUCTOS;

-- B
SELECT N AS 'NOMBRE DE PRODUCTO', P AS 'EUROS'
FROM PRODUCTOS.NOMBRE N, PRECIO P;

-- C
SELECT UPPER(NOMBRE), PRECIO
FROM PRODUCTOS;

-- D
SELECT LOWER(NOMBRE), PRECIO
FROM PRODUCTOS;

-- E
SELECT NOMBRE, ROUND(PRECIO)
FROM PRODUCTOS;

-- F
SELECT NOMBRE, TRUNCATE(PRECIO,0)
FROM PRODUCTOS;

-- G
SELECT ID
FROM FABRICANTES f, PRODUCTO P
WHERE F.ID = P.ID_FABRICANTE;

-- H
SELECT DISTINCT ID
FROM FABRICANTES f, PRODUCTO P
WHERE F.ID = P.ID_FABRICANTE;

-- I
SELECT NOMBRE
FROM FABRICANTES
ORDER BY NOMBRE;

-- J
SELECT NOMBRE, PECIO
FROM FABRICANTES
ORDER BY PRECIO DESC
AND ROWNUM = 1;

-- K
SELECT NOMBRE
FROM PRODUCTOS
WHERE PRECIO >= 400;

-- L
SELECT NOMBRE
FROM PRODUCTOS
WHERE PRECIO < 400;

-- M
SELECT NOMBRE
FROM PRODUCTOS
WHERE PRECIO >= 80
AND PRECIO <= 300;

-- N
SELECT NOMBRE
FROM PRODUCTOS
WHERE PRECIO BETWEEN 60 AND 200;

-- O
SELECT NOMBRE
FROM PRODUCTOS P, FABRICANTES F
WHERE PRECIO > 200
AND P.ID = F.ID_FABRICANTE
AND F.ID = 6;

-- P
SELECT NOMBRE
FROM PRODUCTOS P, FABRICANTES F
WHERE PRECIO > 200
AND P.ID = F.ID_FABRICANTE
AND F.ID IN (1, 3, 5);

-- Q
SELECT NOMBRE
FROM FABRICANTES
WHERE UPPER(NOMBRE) LIKE 'S%';

-- R
SELECT NOMBRE
FROM FABRICANTES
WHERE UPPER(NOMBRE) LIKE '%E';

-- S
SELECT NOMBRE
FROM FABRICANTES
WHERE UPPER(NOMBRE) LIKE '%W%';



-- Consultas multitabla (Composición externa)
-- A
SELECT *
FROM fabricantes f LEFT JOIN productos p ON f.id = p.id_fabricante;

-- B
SELECT *
FROM fabricantes f LEFT JOIN productos p ON f.id = p.id_fabricante WHERE p.id IS NULL;

-- C
-- Sí, porque id_fabricante es NOT NULL, por lo que puede no almacenar ningún valor



-- Consultas multitabla (Composición interna)
-- 1
SELECT p.nombre as producto, p.precio, f.nombre as fabricante
FROM fabricantes f RIGHT JOIN productos p ON f.id = p.id_fabricante;

-- 2
SELECT p.nombre as producto, p.precio, f.nombre as fabricante
FROM fabricantes f RIGHT JOIN productos p ON f.id = p.id_fabricante
ORDER BY f.nombre;

-- 3
SELECT p.id as id_producto, p.nombre as producto, f.id as id_fabricante, f.nombre as fabricante
FROM fabricantes f FULL OUTER JOIN productos p ON f.id = p.id_fabricante;

-- 4
SELECT p.nombre as producto, LEAST(p.precio), f.nombre as fabricante
FROM fabricantes f, productos p;

-- 5
SELECT p.nombre as producto, GREATEST(p.precio), f.nombre as fabricante
FROM fabricantes f, productos p;

-- 6
SELECT p.nombre as producto
FROM productos p LEFT JOIN fabricantes f ON p.id_fabricante = f.id
WHERE f.nombre = 'Lenovo';

-- 7
SELECT p.nombre as producto
FROM productos p LEFT JOIN fabricantes f ON p.id_fabricante = f.id
WHERE f.nombre = 'Crucial'
AND p.precio > 200;

-- 8
SELECT p.nombre as producto
FROM productos p LEFT JOIN fabricantes f ON p.id_fabricante = f.id
WHERE f.nombre = 'Asus'
OR f.nombre = 'Hewlett-Packard'
OR f.nombre = 'Seagate';

-- 9
SELECT p.nombre as producto
FROM productos p LEFT JOIN fabricantes f ON p.id_fabricante = f.id
WHERE f.nombre IN ('Asus', 'Hewlett-Packard', 'Seagate');

-- 10
SELECT p.nombre as producto, p.precio as precio
FROM productos p LEFT JOIN fabricantes f ON p.id_fabricante = f.id
WHERE f.nombre LIKE '%e';

-- 11
SELECT p.nombre as producto, p.precio as precio
FROM productos p LEFT JOIN fabricantes f ON p.id_fabricante = f.id
WHERE LOWER(f.nombre) LIKE '%w%';

-- 12
SELECT p.nombre as producto, p.precio as precio, f.nombre
FROM productos p LEFT JOIN fabricantes f ON p.id_fabricante = f.id
WHERE p.precio >= 180
ORDER BY p.precio DESC, p.nombre;



-- Sub-consultas (Cláusula WHERE)
-- 1
SELECT nombre
FROM productos
WHERE id_fabricante = (
    SELECT id
    FROM fabricantes
    WHERE nombre = 'Lenovo'
);

-- 2
SELECT *
FROM productos p
WHERE p.precio = (
    SELECT MAX(precio)
    FROM productos p
    WHERE p.id_fabricante = (
        SELECT f.id
        FROM fabricantes f
        WHERE f.nombre = 'Lenovo'
    )
);

-- 3
SELECT nombre
FROM productos
where precio = (
    SELECT MAX(precio)
    FROM productos
    WHERE id_fabricante = (
        SELECT id
        FROM fabricantes
        WHERE nombre = 'Lenovo'
    )
);

SELECT nombre
FROM productos
WHERE precio = (
    SELECT MAX(p.precio)
    FROM productos p
    WHERE id_fabricante = (
        SELECT id
        FROM fabricantes f
        WHERE f.nombre = 'Lenovo'
    )
)
AND id_fabricante = (
    SELECT id
    FROM fabricantes f
    WHERE f.nombre = 'Lenovo'
);

-- 4
SELECT nombre
FROM productos
where precio = (
    SELECT MIN(precio)
    FROM productos
    WHERE id_fabricante = (
        SELECT id
        FROM fabricantes
        WHERE nombre = 'Hewlett-Packard'
    )
);

-- 5
SELECT *
FROM productos
WHERE precio >= (
    SELECT MAX(p.precio)
    FROM productos p
    WHERE p.id_fabricante = (
        SELECT id
        FROM fabricantes f
        WHERE f.nombre = 'Lenovo'
    )
);

SELECT *
FROM productos
WHERE precio >= (
    SELECT MAX(productos.precio)
    FROM productos
    WHERE id_fabricante = (
        SELECT id
        FROM fabricantes
        WHERE nombre = 'Lenovo'
    )
);

-- 6
SELECT nombre, precio
FROM productos
WHERE precio > (
    SELECT AVG(p.precio)
    FROM productos p
    WHERE p.id_fabricante = (
        SELECT id
        FROM fabricantes f
        WHERE f.nombre = 'Asus'
    )
)
AND id_fabricante = (
    SELECT id
    FROM fabricantes f
    WHERE f.nombre = 'Asus'
);



-- Sub-consultas (ALL y ANY)
-- 7
SELECT nombre
FROM productos
WHERE precio >= ALL (
    SELECT precio
    FROM productos
);

-- 8
SELECT nombre
FROM productos
WHERE precio <= ALL (
    SELECT precio
    FROM productos
);

-- 9
SELECT nombre
FROM fabricantes
WHERE id = ANY (
    SELECT id_fabricante
    FROM productos
);

-- 10
SELECT nombre
FROM fabricantes
WHERE id <> ALL ( -- WHERE id != ALL
    SELECT id_fabricante
    FROM productos
);



-- Sub-consultas (IN y NOT IN)
-- 11
SELECT nombre
FROM fabricantes
WHERE id IN (
    SELECT id_fabricante
    FROM productos
);

-- 12
SELECT nombre
FROM fabricantes
WHERE id NOT IN (
    SELECT id_fabricante
    FROM productos
);



-- Sub-consultas (EXISTS y NOT EXISTS)
-- 13
SELECT nombre
FROM fabricantes
WHERE EXISTS (
    SELECT id_fabricante
    FROM productos
);

-- 14
SELECT nombre
FROM fabricantes
WHERE NOT EXISTS (
    SELECT id_fabricante
    FROM productos
);



-- Sub-consultas correlacionadas
-- 15
SELECT f.nombre AS fabricante, p.nombre AS producto, p.precio
FROM productos p, fabricantes f
WHERE p.id_fabricante = f.id
AND p.precio = (
    SELECT MAX(p2.precio)
    FROM productos p2
    WHERE p2.id_fabricante = f.id
);

-- 16
SELECT f.nombre AS fabricante, p.nombre AS producto, p.precio
FROM productos p, fabricantes f
WHERE p.id_fabricante = f.id
AND p.precio >= (
    SELECT AVG(p2.precio)
    FROM productos p2
    WHERE p2.id_fabricante = f.id
);

-- 17
SELECT f.nombre AS fabricante, p.nombre AS producto, p.precio
FROM productos p, fabricantes f
WHERE p.id_fabricante = f.id
AND p.precio = (
    SELECT MAX(precio)
    FROM productos p2
    WHERE f.nombre = 'Lenovo'
    AND p2.id_fabricante = f.id
);



-- Sub-consultas (cláusula HAVING)
-- 18
SELECT f.nombre, COUNT(*)
FROM productos p, fabricantes f
WHERE p.id_fabricante = f.id
GROUP BY f.nombre
HAVING COUNT(*) = (
    SELECT COUNT(*)
    FROM fabricantes f, productos p
    WHERE p.id_fabricante = f.id
    AND f.nombre = 'Lenovo'
);