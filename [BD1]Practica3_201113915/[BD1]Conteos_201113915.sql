SELECT 0 AS indice, 'registro' AS tabla , COUNT(*) AS cantidad_filas  FROM registro
UNION
SELECT 1 AS indice, 'pais' AS tabla , COUNT(*) AS cantidad_filas  FROM pais
UNION
SELECT 2 AS indice, 'ciudad' AS tabla , COUNT(*) AS cantidad_filas  FROM ciudad
UNION
SELECT 3 AS indice, 'direccion' AS tabla , COUNT(*) AS cantidad_filas  FROM direccion
UNION
SELECT 4 AS indice, 'tienda' AS tabla , COUNT(*) AS cantidad_filas  FROM tienda
UNION
SELECT 5 AS indice, 'empleado' AS tabla , COUNT(*) AS cantidad_filas  FROM empleado
UNION
SELECT 6 AS indice, 'encargado_tienda' AS tabla , COUNT(*) AS cantidad_filas  FROM encargado_tienda
UNION
SELECT 7 AS indice, 'cliente' AS tabla , COUNT(*) AS cantidad_filas  FROM cliente
UNION
SELECT 8 AS indice, 'actor' AS tabla , COUNT(*) AS cantidad_filas  FROM actor
UNION
SELECT 9 AS indice, 'lenguaje' AS tabla , COUNT(*) AS cantidad_filas  FROM lenguaje
UNION
SELECT 10 AS indice, 'categoria' AS tabla , COUNT(*) AS cantidad_filas  FROM categoria
UNION
SELECT 11 AS indice, 'clasificacion' AS tabla , COUNT(*) AS cantidad_filas  FROM clasificacion
UNION
SELECT 12 AS indice, 'pelicula' AS tabla , COUNT(*) AS cantidad_filas  FROM pelicula
UNION
SELECT 13 AS indice, 'actor_pelicula' AS tabla , COUNT(*) AS cantidad_filas  FROM actor_pelicula
UNION
SELECT 14 AS indice, 'lenguaje_pelicula' AS tabla , COUNT(*) AS cantidad_filas  FROM lenguaje_pelicula
UNION
SELECT 15 AS indice, 'categoria_pelicula' AS tabla , COUNT(*) AS cantidad_filas  FROM categoria_pelicula
UNION
SELECT 16 AS indice, 'copia_pelicula' AS tabla , COUNT(*) AS cantidad_filas  FROM copia_pelicula
UNION
SELECT 17 AS indice, 'renta_pelicula' AS tabla , COUNT(*) AS cantidad_filas  FROM renta_pelicula
UNION
SELECT 18 AS indice, 'pago_renta' AS tabla , COUNT(*) AS cantidad_filas  FROM pago_renta
	ORDER BY indice	;

