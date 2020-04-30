BEGIN;
-- ======================================================================================
-- Vaciado de tablas
-- ======================================================================================
	TRUNCATE TABLE pais CASCADE;
	TRUNCATE TABLE ciudad CASCADE;
	TRUNCATE TABLE direccion CASCADE;
	TRUNCATE TABLE tienda CASCADE;
	TRUNCATE TABLE empleado CASCADE;
	TRUNCATE TABLE encargado_tienda CASCADE;
	TRUNCATE TABLE cliente CASCADE;
	TRUNCATE TABLE actor CASCADE;
	TRUNCATE TABLE lenguaje CASCADE;
	TRUNCATE TABLE categoria CASCADE;
	TRUNCATE TABLE clasificacion CASCADE;
	TRUNCATE TABLE pelicula CASCADE;
	TRUNCATE TABLE actor_pelicula CASCADE;
	TRUNCATE TABLE lenguaje_pelicula CASCADE;
	TRUNCATE TABLE categoria_pelicula CASCADE;
	TRUNCATE TABLE renta_pelicula CASCADE;
	TRUNCATE TABLE pago_renta CASCADE;
-- ======================================================================================
-- Carga de datos de la tabla PAIS
-- ======================================================================================
	INSERT INTO pais(nombre_pais)
	SELECT DISTINCT pais_cliente 
		FROM registro 
			WHERE pais_cliente IS NOT null 
				ORDER BY pais_cliente;
-- ======================================================================================
-- Carga de datos de la tabla CIUDAD
-- ======================================================================================
	INSERT INTO ciudad(nombre_ciudad, pais_ciudad)	
	SELECT DISTINCT ciudad_cliente, id_pais 
		FROM registro
		INNER JOIN pais 
			ON nombre_pais = pais_cliente
				WHERE ciudad_cliente IS NOT null 
					ORDER BY ciudad_cliente;
-- ======================================================================================
-- Carga de datos de la tabla DIRECCION
-- ======================================================================================
	INSERT INTO direccion(direccion, codigo_postal, ciudad_direccion)
	SELECT DISTINCT direccion_cliente, codigo_postal_cliente, id_ciudad
		FROM registro 
		INNER JOIN ciudad 
			ON nombre_ciudad = ciudad_cliente 
		INNER JOIN pais 
			ON id_pais = pais_ciudad 
			AND nombre_pais = pais_cliente
				WHERE direccion_cliente IS NOT null 
					ORDER BY direccion_cliente;
-- ======================================================================================
-- Carga de datos de la tabla TIENDA
-- ======================================================================================
	INSERT INTO tienda(nombre_tienda, direccion_tienda)
	SELECT DISTINCT nombre_tienda, id_direccion
		FROM registro 
		INNER JOIN direccion 
			ON direccion.direccion = direccion_tienda
				WHERE nombre_tienda IS NOT null;
-- ======================================================================================
-- Carga de datos de la tabla EMPLEADO
-- ======================================================================================
	INSERT INTO empleado(nombre_empleado, apellido_empleado, correo_empleado, 
						 empleado_activo, tienda_empleado, usuario_empleado, 
						 contrasenia_empleado, direccion_empleado)
	SELECT DISTINCT nombre_empleado, apellido_empleado, correo_empleado, 
			(
				CASE 
					WHEN UPPER(empleado_activo)='SI'  THEN true 
					WHEN UPPER(empleado_activo)='NO' THEN false 
				END
			) as actividad, 
			id_tienda, usuario_empleado, contrasenia_empleado, id_direccion 
		FROM registro 
		INNER JOIN tienda 
			ON tienda.nombre_tienda = tienda_empleado
		INNER JOIN direccion 
			ON direccion.direccion = direccion_empleado
				WHERE nombre_empleado IS NOT null 
					AND apellido_empleado IS NOT null
						ORDER BY nombre_empleado;
-- ======================================================================================
-- Carga de datos de la tabla ENCARGADO_TIENDA
-- ======================================================================================
	INSERT INTO encargado_tienda
	SELECT DISTINCT id_tienda, id_empleado
		FROM registro
		INNER JOIN empleado 
			ON empleado.nombre_empleado = nombre_encargado 
			AND empleado.apellido_empleado = apellido_encargado
		INNER JOIN tienda ON tienda.nombre_tienda = registro.nombre_tienda
			WHERE registro.nombre_tienda IS NOT null;
-- ======================================================================================
-- Carga de datos de la tabla CLIENTE
-- ======================================================================================
	INSERT INTO cliente(nombre_cliente, apellido_cliente, correo_cliente, 
						cliente_activo, fecha_creacion_cliente, 
						tienda_preferida_cliente, direccion_cliente
					   )
	SELECT DISTINCT nombre_cliente, apellido_cliente, correo_cliente, 
			(
				CASE 
					WHEN UPPER(empleado_activo)='SI'  THEN true 
					WHEN UPPER(empleado_activo)='NO' THEN false 
				END
			) as actividad, 
			fecha_creacion, id_tienda, id_direccion
		FROM registro 
		INNER JOIN tienda 
			ON tienda.nombre_tienda = tienda_preferida
		INNER JOIN direccion 
			ON direccion.direccion = direccion_cliente
				WHERE nombre_cliente IS NOT null AND apellido_cliente IS NOT null
					ORDER BY nombre_cliente;
-- ======================================================================================
-- Carga de datos de la tabla ACTOR
-- ======================================================================================
	INSERT INTO actor(nombre_actor, apellido_actor)
	SELECT DISTINCT nombre_actor, apellido_actor 
		FROM registro 
			WHERE nombre_actor IS NOT null 
				AND apellido_actor IS NOT null
					ORDER BY nombre_actor;
-- ======================================================================================
-- Carga de datos de la tabla LENGUAJE
-- ======================================================================================
	INSERT INTO lenguaje(nombre_lenguaje)
	SELECT DISTINCT lenguaje_pelicula 
		FROM registro 
			WHERE lenguaje_pelicula IS NOT null
				ORDER BY lenguaje_pelicula;
-- ======================================================================================
-- Carga de datos de la tabla CATEGORIA
-- ======================================================================================
	INSERT INTO categoria(nombre_categoria)
	SELECT DISTINCT categoria_pelicula 
		FROM registro 
			WHERE categoria_pelicula IS NOT null
				ORDER BY categoria_pelicula;
-- ======================================================================================
-- Carga de datos de la tabla CLASIFICACION
-- ======================================================================================
	INSERT INTO clasificacion(nombre_clasificacion)
	SELECT DISTINCT clasificacion_pelicula
		FROM registro 
			WHERE clasificacion_pelicula IS NOT null
				ORDER BY clasificacion_pelicula;
-- ======================================================================================
-- Carga de datos de la tabla PELICULA
-- ======================================================================================
	INSERT INTO pelicula(nombre_pelicula, descripcion_pelicula, anio_lanzamiento, 
						 dias_renta, costo_renta, duracion_minutos, costo_por_danio, 
						 clasificacion_pelicula
						)
	SELECT DISTINCT nombre_pelicula, descripcion_pelicula, anio_lanzamiento, 
					dias_renta, costo_renta, duracion_minutos, costo_por_danio, 
					id_clasificacion	 
		FROM registro 
		INNER JOIN clasificacion 
			ON clasificacion.nombre_clasificacion = registro.clasificacion_pelicula
				WHERE nombre_pelicula IS NOT null
					ORDER BY nombre_pelicula;
-- ======================================================================================
-- Carga de datos de la tabla ACTOR_PELICULA
-- ======================================================================================
	INSERT INTO actor_pelicula
	SELECT DISTINCT id_pelicula, id_actor
		FROM registro
		INNER JOIN actor 
			ON actor.nombre_actor = registro.nombre_actor 
			AND actor.apellido_actor = registro.apellido_actor
		INNER JOIN pelicula 
			ON pelicula.nombre_pelicula = registro.nombre_pelicula
				ORDER BY id_pelicula;
-- ======================================================================================
-- Carga de datos de la tabla LENGUAJE_PELICULA
-- ======================================================================================
	INSERT INTO lenguaje_pelicula
	SELECT DISTINCT id_pelicula, id_lenguaje
		FROM registro
		INNER JOIN lenguaje 
			ON lenguaje.nombre_lenguaje = registro.lenguaje_pelicula
		INNER JOIN pelicula 
			ON pelicula.nombre_pelicula = registro.nombre_pelicula
				ORDER BY id_pelicula;
-- ======================================================================================
-- Carga de datos de la tabla CATEGORIA_PELICULA
-- ======================================================================================
	INSERT INTO categoria_pelicula
	SELECT DISTINCT id_pelicula, id_categoria
		FROM registro
		INNER JOIN categoria 
			ON categoria.nombre_categoria = registro.categoria_pelicula
		INNER JOIN pelicula 
			ON pelicula.nombre_pelicula = registro.nombre_pelicula
				ORDER BY id_pelicula;
-- ======================================================================================
-- Carga de datos de la tabla RENTA_PELICULA
-- ======================================================================================
	INSERT INTO renta_pelicula(cliente_renta, tienda_renta, pelicula_renta, 
							   empleado_renta, fecha_renta, fecha_retorno
							  )
		SELECT DISTINCT id_cliente, id_tienda, id_pelicula, id_empleado, fecha_renta, 
						fecha_retorno
			FROM registro	
			INNER JOIN cliente 
				ON cliente.nombre_cliente = registro.nombre_cliente 
				AND cliente.apellido_cliente = registro.apellido_cliente
			INNER JOIN pelicula 
				ON pelicula.nombre_pelicula = registro.nombre_pelicula 
			INNER JOIN tienda 
				ON tienda.nombre_tienda = registro.tienda_pelicula
			INNER JOIN empleado 
				ON empleado.nombre_empleado = registro.nombre_empleado 
				AND empleado.apellido_empleado = registro.apellido_empleado
					WHERE fecha_renta IS NOT null;
-- ======================================================================================
-- Carga de datos de la tabla PAGO_RENTA
-- ======================================================================================
	INSERT INTO pago_renta(renta, monto_pago, fecha_pago)
	SELECT DISTINCT id_renta_pelicula, monto_a_pagar, fecha_pago
		FROM registro	
		INNER JOIN cliente 
			ON cliente.nombre_cliente = registro.nombre_cliente 
			AND cliente.apellido_cliente = registro.apellido_cliente
		INNER JOIN pelicula 
			ON pelicula.nombre_pelicula = registro.nombre_pelicula 
		INNER JOIN tienda 
			ON tienda.nombre_tienda = registro.tienda_pelicula
		INNER JOIN empleado 
			ON empleado.nombre_empleado = registro.nombre_empleado 
			AND empleado.apellido_empleado = registro.apellido_empleado
		INNER JOIN renta_pelicula 
			ON renta_pelicula.cliente_renta = id_cliente
			AND renta_pelicula.tienda_renta = id_tienda
			AND renta_pelicula.pelicula_renta = id_pelicula
			AND renta_pelicula.empleado_renta = id_empleado
			AND renta_pelicula.fecha_renta = registro.fecha_renta
				WHERE registro.fecha_renta IS NOT null
					ORDER BY id_renta_pelicula ASC;	
-- ======================================================================================
COMMIT;

