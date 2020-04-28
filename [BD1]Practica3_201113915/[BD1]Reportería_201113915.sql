-- ====================================================================================== 
-- Consulta 01
-- ====================================================================================== 
-- Mostrar la cantidad de copias que existen en el inventario para la película “Sugar 
-- Wonka”.
-- ====================================================================================== 
	SELECT nombre_tienda, COUNT(*) AS cantidad
		FROM renta_pelicula
			INNER JOIN copia_pelicula ON copia_pelicula_renta = id_copia_pelicula
			INNER JOIN pelicula ON id_pelicula = pelicula
			INNER JOIN tienda ON id_tienda = tienda
				WHERE nombre_pelicula = 'SUGAR WONKA'
				GROUP BY nombre_pelicula, nombre_tienda
				ORDER BY nombre_tienda;
-- ====================================================================================== 
-- Consulta 02
-- ======================================================================================
-- Mostrar el nombre, apellido y pago total de todos los clientes que han rentado pelícu-
-- las por lo menos 40 veces.
-- ====================================================================================== 
	SELECT nombre_cliente, apellido_cliente, SUM(monto_pago) AS pago_total
		--, COUNT(id_renta_pelicula) AS cantidad_renta
		FROM renta_pelicula
			INNER JOIN cliente ON id_cliente = cliente_renta
			INNER JOIN pago_renta ON id_renta_pelicula = renta
				GROUP BY  nombre_cliente, apellido_cliente
					HAVING COUNT(id_renta_pelicula) >= 40
						ORDER BY pago_total;
-- ======================================================================================
-- Consulta 03
-- ======================================================================================
-- Mostrar el nombre y apellido del cliente y el nombre de la película de todos aquellos 
-- clientes que hayan rentado una película y no la hayan devuelto y donde la fecha de al-
-- quiler esté más allá de la especificada por la película.
-- ====================================================================================== 
	SELECT nombre_pelicula, nombre_cliente, apellido_cliente
		--, (dias_renta||' day')::interval, fecha_retorno - fecha_renta
		FROM renta_pelicula
			INNER JOIN cliente ON id_cliente = cliente_renta
			INNER JOIN copia_pelicula ON id_copia_pelicula = copia_pelicula_renta
			INNER JOIN tienda ON id_tienda = copia_pelicula.tienda
			INNER JOIN pelicula ON id_pelicula = copia_pelicula.pelicula
				WHERE fecha_retorno IS null 
					OR fecha_retorno - fecha_renta > (dias_renta||' day')::interval
				GROUP BY nombre_pelicula, nombre_cliente, apellido_cliente
				ORDER BY nombre_pelicula;
-- ====================================================================================== 
-- Cambio 1 Consulta 03
-- ====================================================================================== 				
-- En la consulta 3 mostrar solo las que no hayan devuelto.
-- ======================================================================================
	SELECT nombre_pelicula, nombre_cliente, apellido_cliente
		--, fecha_retorno
		FROM renta_pelicula
			INNER JOIN cliente ON id_cliente = cliente_renta
			INNER JOIN copia_pelicula ON id_copia_pelicula = copia_pelicula_renta
			INNER JOIN tienda ON id_tienda = copia_pelicula.tienda
			INNER JOIN pelicula ON id_pelicula = copia_pelicula.pelicula
				WHERE fecha_retorno IS null 
				GROUP BY nombre_pelicula, nombre_cliente, apellido_cliente
				--, fecha_retorno
				ORDER BY nombre_pelicula;	
-- ====================================================================================== 
-- Cambio 2 Consulta 03
-- ====================================================================================== 
-- Mostrar el nombre y apellido del actor que más veces a aparecido en una película. Debe 
-- mostrar la cantidad de veces que apareció. Si esa cantidad coincide también para otros 
-- actores, debe mostrarlos todos.
-- ======================================================================================
	SELECT nombre_actor, apellido_actor, COUNT(pelicula) as conteo
		FROM actor_pelicula
			INNER JOIN actor ON id_actor = actor_pelicula.actor
				GROUP BY nombre_actor, apellido_actor
					HAVING COUNT(pelicula) = (
						SELECT MAX(count) FROM (
							SELECT actor, COUNT(pelicula)
								FROM actor_pelicula
									GROUP BY actor
						)maximo);
-- ====================================================================================== 
-- Consulta 04
-- ======================================================================================
-- Mostrar el nombre y apellido (en una sola columna) de los actores que contienen la pa-
-- labra “SON” en su apellido, ordenados por su primer nombre.
-- ======================================================================================
	SELECT nombre_actor||' '||  apellido_actor nombre_apellido_actor
		FROM actor
			WHERE UPPER(apellido_actor) LIKE '%SON%'
				ORDER BY nombre_actor;
-- ====================================================================================== 
-- Consulta 05
-- ======================================================================================
-- Mostrar el apellido de todos los actores y la cantidad de actores que tienen ese ape-
-- llido pero solo para los que comparten el mismo nombre por lo menos con dos actores.
-- ====================================================================================== 
	SELECT apellido_actor, COUNT(nombre_actor)
		FROM actor
			GROUP BY apellido_actor
				HAVING COUNT(nombre_actor) >= 2
					ORDER BY COUNT(nombre_actor);
-- ====================================================================================== 
-- Cambio Consulta 05
-- ======================================================================================
-- Mostrar el apellido de todos los actores y la cantidad de actores que tienen ese ape-
-- llido.
-- ======================================================================================
	SELECT apellido_actor, COUNT(nombre_actor)
		FROM actor
			GROUP BY apellido_actor
					ORDER BY COUNT(nombre_actor) DESC;
-- ====================================================================================== 
-- Consulta 06
-- ======================================================================================
-- Mostrar el nombre y apellido de los actores que participaron en una película que invo-
-- lucra un “Cocodrilo” y un “Tiburón” junto con el año de lanzamiento de la película,
-- ordenados por el apellido del actor en forma ascendente.
-- ======================================================================================
	SELECT nombre_actor, apellido_actor, anio_lanzamiento, descripcion_pelicula
		FROM actor_pelicula
			INNER JOIN actor ON id_actor = actor_pelicula.actor
			INNER JOIN pelicula ON id_pelicula = actor_pelicula.pelicula
				WHERE UPPER(descripcion_pelicula) LIKE '%CROCODILE%'
					AND UPPER(descripcion_pelicula) LIKE '%SHARK%'
						ORDER BY apellido_actor ASC;
-- ====================================================================================== 
-- Consulta 07
-- ======================================================================================
-- Mostrar el nombre de la categoría y el número de películas por categoría de todas las 
-- categorías de películas en las que hay entre 55 y 65 películas. Ordenar el resultado 
-- por número de películas de forma descendente.
-- ======================================================================================
	SELECT nombre_categoria, COUNT(pelicula) AS cantidad
		FROM categoria_pelicula
			INNER JOIN categoria ON id_categoria = categoria_pelicula.categoria
				GROUP BY  nombre_categoria
					HAVING COUNT(pelicula) >= 55 AND COUNT(pelicula) <= 65
						ORDER BY COUNT(pelicula) DESC;
-- ====================================================================================== 
-- Consulta 08
-- ======================================================================================
-- Mostrar todas las categorías de películas en las que la diferencia promedio entre el 
-- costo de reemplazo de la película y el precio de alquiler sea superior a 17.
-- ======================================================================================
	SELECT nombre_categoria, ROUND(AVG(costo_por_danio - costo_renta)::numeric,2)
		FROM categoria_pelicula
			INNER JOIN categoria ON id_categoria = categoria_pelicula.categoria
			INNER JOIN pelicula ON id_pelicula = categoria_pelicula.pelicula
				GROUP BY nombre_categoria
					HAVING AVG(costo_por_danio - costo_renta) > 17
						ORDER BY AVG(costo_por_danio - costo_renta);
-- ====================================================================================== 
-- Consulta 09
-- ======================================================================================
-- Mostrar el título de la película, el nombre y apellido del actor de todas aquellas pe-
-- lículas en las que uno o más actores actuaron en dos o más películas.
-- ======================================================================================
	SELECT nombre_pelicula, id_actor, nombre_actor, apellido_actor
		FROM actor_pelicula
			INNER JOIN actor ON id_actor = actor_pelicula.actor
			INNER JOIN pelicula ON id_pelicula = actor_pelicula.pelicula
			INNER JOIN (
				SELECT actor FROM actor_pelicula 
					GROUP BY actor HAVING count(pelicula) > 2
			) mas2actuaciones ON mas2actuaciones.actor = id_actor
-- ====================================================================================== 
-- Consulta 10
-- ======================================================================================
-- Mostrar el nombre y apellido (en una sola columna) de todos los actores y clientes cu-
-- yo primer nombre sea el mismo que el primer nombre del actor con ID igual a 8. No debe
-- retornar el nombre del actor con ID igual a 8 dentro de la consulta. No puede utilizar 
-- el nombre del actor como una constante, únicamente el ID proporcionado.
-- ======================================================================================
	SELECT nombre || ' ' ||apellido FROM (
		SELECT nombre_cliente AS nombre, apellido_cliente AS apellido FROM cliente
		UNION
		SELECT nombre_actor AS nombre, apellido_actor AS apellido FROM actor
	) nombres INNER JOIN (
		SELECT nombre_actor, apellido_actor
				FROM actor
					WHERE id_actor =  8
	) ids ON nombre = nombre_actor
	WHERE apellido <> apellido_actor;
-- ======================================================================================
-- Aclaración Consulta 10
-- ======================================================================================
-- En la consulta #10 en lugar de utilizar la condicion del ID 8 utilizar el ID de la 
-- persona con el nombre de "MATTHEW JOHANSSON".
-- ====================================================================================== 
	SELECT nombre || ' ' ||apellido FROM (
		SELECT nombre_cliente AS nombre, apellido_cliente AS apellido FROM cliente
		UNION
		SELECT nombre_actor AS nombre, apellido_actor AS apellido FROM actor
	) nombres INNER JOIN (
		SELECT nombre_actor, apellido_actor
				FROM actor
					WHERE UPPER(nombre_actor||' '||apellido_actor) = 'MATTHEW JOHANSSON'
	) ids ON nombre = nombre_actor
	WHERE apellido <> apellido_actor;
-- ====================================================================================== 
-- Consulta 11
-- ======================================================================================
-- Mostrar el país y el nombre del cliente que más películas rentó así como también el 
-- porcentaje que representa la cantidad de películas que rentó con respecto al resto de
-- clientes del país.
-- ======================================================================================
	SELECT nombre_pais, nombre_cliente, apellido_cliente,
		CASE total.conteo 
			WHEN 0 THEN 0.00 
			ELSE ROUND(individual.conteo::numeric/total.conteo::numeric * 100,2) 
		END AS porcentaje 
		, individual.conteo
	FROM (
		SELECT nombre_cliente, apellido_cliente, id_pais, nombre_pais, COUNT(id_renta_pelicula) AS conteo
			FROM renta_pelicula
				INNER JOIN cliente ON id_cliente = cliente_renta
				INNER JOIN direccion ON id_direccion = direccion_cliente
				INNER JOIN ciudad ON id_ciudad = ciudad_direccion
				RIGHT JOIN pais ON id_pais = pais_ciudad
					GROUP BY nombre_cliente, apellido_cliente, id_pais, nombre_pais
	)individual INNER JOIN (
		SELECT pais_ciudad, COUNT(id_renta_pelicula) AS conteo
			FROM renta_pelicula
				INNER JOIN cliente ON id_cliente = cliente_renta
				INNER JOIN direccion ON id_direccion = direccion_cliente
				RIGHT JOIN ciudad ON id_ciudad = ciudad_direccion
					GROUP BY  pais_ciudad
	)total ON id_pais = pais_ciudad 
		WHERE individual.conteo =
			(
				SELECT MAX(conteo) FROM (
					SELECT nombre_cliente, apellido_cliente, pais_ciudad, COUNT(id_renta_pelicula) AS conteo
						FROM renta_pelicula
							INNER JOIN cliente ON id_cliente = cliente_renta
							INNER JOIN direccion ON id_direccion = direccion_cliente
							RIGHT JOIN ciudad ON id_ciudad = ciudad_direccion
								GROUP BY nombre_cliente, apellido_cliente, pais_ciudad
				)tb1
			);		
-- ====================================================================================== 
-- Consulta 12
-- ======================================================================================
-- Mostrar el total de clientes y porcentaje de clientes mujeres por ciudad y país. El 
-- ciento por ciento es el total de mujeres por país. (Tip: Todos los porcentajes por 
-- ciudad de un país deben sumar el 100%).
-- ====================================================================================== 
-- Aclaración Consulta 12
-- ======================================================================================
-- En la consulta #12 dice algo como lo siguiente: "... porcentaje de clientes mujeres 
-- por ciudad y país". En esa consulta ignoren el genero (mujeres) y únicamente haganlo 
-- por la cantidad de clientes por ciudad y país.
-- ======================================================================================
	SELECT nombre_pais, nombre_ciudad, individual.conteo,
		CASE total.conteo 
			WHEN 0 THEN 0.00 
			ELSE ROUND(individual.conteo::numeric/total.conteo::numeric * 100,2) 
		END AS porcentaje 
	FROM (
		SELECT pais_ciudad, nombre_pais, nombre_ciudad, COUNT(id_cliente) AS conteo
			FROM cliente
				INNER JOIN direccion ON id_direccion = direccion_cliente
				RIGHT JOIN ciudad ON id_ciudad = ciudad_direccion
				INNER JOIN pais ON id_pais = pais_ciudad
					GROUP BY pais_ciudad, nombre_pais, nombre_ciudad
						ORDER BY COUNT(id_cliente)
	)individual INNER JOIN (
		SELECT pais_ciudad, COUNT(id_cliente) AS conteo
			FROM cliente
				INNER JOIN direccion ON id_direccion = direccion_cliente
				RIGHT JOIN ciudad ON id_ciudad = ciudad_direccion
					GROUP BY pais_ciudad
						ORDER BY COUNT(id_cliente)
	)total USING(pais_ciudad)
	ORDER BY nombre_pais, nombre_ciudad;
-- ====================================================================================== 
-- Consulta 13
-- ======================================================================================
-- Mostrar el nombre del país, nombre del cliente y número de películas rentadas de todos 
-- los clientes que rentaron más películas por país. Si el número de películas máximo se 
-- repite, mostrar todos los valores que representa el máximo.
-- ======================================================================================
	SELECT nombre_pais, nombre_cliente, apellido_cliente, individual.conteo
		FROM (
			SELECT nombre_cliente, apellido_cliente, id_pais, nombre_pais, COUNT(id_renta_pelicula) AS conteo
				FROM renta_pelicula
					INNER JOIN cliente ON id_cliente = cliente_renta
					INNER JOIN direccion ON id_direccion = direccion_cliente
					INNER JOIN ciudad ON id_ciudad = ciudad_direccion
					RIGHT JOIN pais ON id_pais = pais_ciudad
						GROUP BY nombre_cliente, apellido_cliente, id_pais, nombre_pais
		)individual INNER JOIN (
			SELECT pais_ciudad, COUNT(id_renta_pelicula) AS conteo
				FROM renta_pelicula
					INNER JOIN cliente ON id_cliente = cliente_renta
					INNER JOIN direccion ON id_direccion = direccion_cliente
					RIGHT JOIN ciudad ON id_ciudad = ciudad_direccion
						GROUP BY  pais_ciudad
		)total ON id_pais = pais_ciudad INNER JOIN (
			SELECT pais_ciudad, MAX(conteo) FROM (
				SELECT nombre_cliente, apellido_cliente, pais_ciudad, COUNT(id_renta_pelicula) AS conteo
					FROM renta_pelicula
						INNER JOIN cliente ON id_cliente = cliente_renta
						INNER JOIN direccion ON id_direccion = direccion_cliente
						RIGHT JOIN ciudad ON id_ciudad = ciudad_direccion
							GROUP BY nombre_cliente, apellido_cliente, pais_ciudad
			)tb1 GROUP BY pais_ciudad
		)maximos ON MAX = individual.conteo AND id_pais = maximos.pais_ciudad
		ORDER BY nombre_pais;	
-- ====================================================================================== 
-- Consulta 14
-- ======================================================================================
-- Mostrar todas las ciudades por país en las que predomina la renta de películas de la 
-- categoría “Horror”. Es decir, hay más rentas que las otras categorías.
-- ======================================================================================
	SELECT nombre_pais, nombre_ciudad, COUNT FROM(
		SELECT nombre_pais, id_ciudad, nombre_ciudad, categoria, nombre_categoria, count(*)
			FROM renta_pelicula
				INNER JOIN copia_pelicula ON id_copia_pelicula = copia_pelicula_renta
				INNER JOIN pelicula ON copia_pelicula.pelicula  = id_pelicula
				INNER JOIN categoria_pelicula ON id_pelicula = categoria_pelicula.pelicula
				INNER JOIN categoria ON categoria_pelicula.categoria = id_categoria
				INNER JOIN cliente ON id_cliente = cliente_renta
				INNER JOIN direccion ON id_direccion = direccion_cliente
				INNER JOIN ciudad ON id_ciudad = ciudad_direccion
				INNER JOIN pais ON id_pais = pais_ciudad
			GROUP BY nombre_pais, id_ciudad, nombre_ciudad, categoria, nombre_categoria
	)individual INNER JOIN 
	(
		SELECT id_ciudad, MAX(COUNT) FROM (
			SELECT id_ciudad, categoria, nombre_categoria, COUNT(id_cliente)
			FROM renta_pelicula
				INNER JOIN copia_pelicula ON id_copia_pelicula = copia_pelicula_renta
				INNER JOIN pelicula ON copia_pelicula.pelicula  = id_pelicula
				INNER JOIN categoria_pelicula ON id_pelicula = categoria_pelicula.pelicula
				INNER JOIN categoria ON categoria_pelicula.categoria = id_categoria
				INNER JOIN cliente ON id_cliente = cliente_renta
				INNER JOIN direccion ON id_direccion = direccion_cliente
				RIGHT JOIN ciudad ON id_ciudad = ciudad_direccion
			GROUP BY id_ciudad, categoria, nombre_categoria
		)maximo
		GROUP BY id_ciudad 
	)maximos ON individual.id_ciudad = maximos.id_ciudad AND COUNT=MAX
		WHERE UPPER(nombre_categoria) = 'HORROR'
	ORDER BY nombre_pais, nombre_ciudad;
-- ====================================================================================== 
-- Consulta 15
-- ======================================================================================
-- Mostrar el nombre del país, la ciudad y el promedio de rentas por ciudad. Por ejemplo:
-- si el país tiene 3 ciudades, se deben sumar todas las rentas de la ciudad y dividirlo 
-- dentro de tres (número de ciudades del país).
-- ======================================================================================
-- Aclaración Consulta 15
-- ======================================================================================
-- Para la consulta #15 dice que si un país tiene 3 ciudades, entonces suman todas las 
-- rentas de esa ciudad y lo dividen dentro de 3. Ese promedio resultante es la respuesta
-- a "promedio de rentas por ciudad". Mostrar el campo de ciudad se me paso por alto y 
-- está de más, en realidad, lo que deben mostrar es el país y ese promedio que calcula-
-- ron.
-- ====================================================================================== 


-- ====================================================================================== 
-- Consulta 16
-- ======================================================================================
-- Mostrar el nombre del país y el porcentaje de rentas de películas de la categoría 
-- “Sports”.
-- ======================================================================================

-- ====================================================================================== 
-- Consulta 17
-- ======================================================================================
-- Mostrar la lista de ciudades de Estados Unidos y el número de rentas de películas para
-- las ciudades que obtuvieron más rentas que la ciudad “Dayton”.
-- ======================================================================================

-- ====================================================================================== 
-- Consulta 18
-- ======================================================================================
-- Mostrar el nombre, apellido y fecha de retorno de película a la tienda de todos los 
-- clientes que hayan rentado más de 2 películas que se encuentren en lenguaje Inglés en 
-- donde el empleado que se las vendió ganará más de 15 dólares en sus rentas del día en 
-- la que el cliente rentó la película.
-- ======================================================================================

-- ====================================================================================== 
-- Consulta 19
-- ======================================================================================
-- Mostrar el número de mes, de la fecha de renta de la película, nombre y apellido de 
-- los clientes que más películas han rentado y las que menos en una sola consulta.
-- ======================================================================================
-- Aclaración 	Consulta 19
-- ======================================================================================
-- En la consulta 19, deben mostrar todas las fechas en que los clientes hayan rentado, 
-- tomen en cuenta solo los primeros 5 clientes de cada TOP.
-- ====================================================================================== 


-- ====================================================================================== 
-- Consulta 20
-- ======================================================================================
-- Mostrar el porcentaje de lenguajes de películas más rentadas de cada ciudad durante el
-- mes de julio del año 2005 de la siguiente manera: ciudad, lenguaje, porcentaje de ren-
-- ta.
-- ======================================================================================
	SELECT nombre_ciudad, nombre_lenguaje, COUNT(id_cliente) 
		FROM renta_pelicula
			INNER JOIN copia_pelicula ON copia_pelicula_renta = id_copia_pelicula
			INNER JOIN pelicula ON copia_pelicula.pelicula = id_pelicula
			INNER JOIN lenguaje_pelicula ON lenguaje_pelicula.pelicula = id_pelicula
			INNER JOIN lenguaje ON lenguaje_pelicula.lenguaje = id_lenguaje
			INNER JOIN cliente ON id_cliente = cliente_renta
			INNER JOIN direccion ON id_direccion = direccion_cliente
			INNER JOIN ciudad ON id_ciudad = ciudad_direccion
			INNER JOIN pais ON id_pais = pais_ciudad
		GROUP BY id_ciudad, nombre_ciudad, nombre_lenguaje
		ORDER BY nombre_ciudad--COUNT(id_cliente) 
-- ======================================================================================
