BEGIN;

	DROP TABLE IF EXISTS registro;

	CREATE TABLE registro (
		nombre_cliente          VARCHAR(50),
		apellido_cliente        VARCHAR(50),
		correo_cliente          VARCHAR(50),
		cliente_activo          VARCHAR(2),
		fecha_creacion          TIMESTAMP,
		tienda_preferida        VARCHAR(20),
		direccion_cliente       VARCHAR(50),
		codigo_postal_cliente   VARCHAR(10),
		ciudad_cliente          VARCHAR(50),
		pais_cliente            VARCHAR(50),
		fecha_renta             TIMESTAMP,
		fecha_retorno           TIMESTAMP,
		monto_a_pagar           REAL,
		fecha_pago              TIMESTAMP,
		nombre_empleado         VARCHAR(50),
		apellido_empleado       VARCHAR(50),
		correo_empleado         VARCHAR(50),
		empleado_activo         VARCHAR(2),
		tienda_empleado         VARCHAR(20),
		usuario_empleado        VARCHAR(50),
		contrasenia_empleado    VARCHAR(50),
		direccion_empleado      VARCHAR(50),
		codigo_postal_empleado  VARCHAR(10),
		ciudad_empleado         VARCHAR(50),
		pais_empleado           VARCHAR(50),
		nombre_tienda           VARCHAR(20),
		nombre_encargado        VARCHAR(50),
		apellido_encargado      VARCHAR(50),
		direccion_tienda        VARCHAR(50),
		codigo_postal_tienda    VARCHAR(10),
		ciudad_tienda           VARCHAR(50),
		pais_tienda             VARCHAR(50),
		tienda_pelicula         VARCHAR(20),
		nombre_pelicula         VARCHAR(50),
		descripcion_pelicula    VARCHAR(150),
		anio_lanzamiento        SMALLINT,
		dias_renta              INTEGER,
		costo_renta             REAL,
		duracion_minutos        INTEGER,
		costo_por_danio         REAL,
		clasificacion_pelicula  VARCHAR(50),
		lenguaje_pelicula       VARCHAR(50),
		categoria_pelicula      VARCHAR(50),
		nombre_actor            VARCHAR(50),
		apellido_actor          VARCHAR(50)
	);

	COPY registro FROM '/home/victorsdb/Documentos/GitHub/-BD1-Practica3_201113915/[BD1]Practica3_201113915/BlockbusterData.csv' DELIMITER ';' NULL '-' CSV HEADER;
	
COMMIT;