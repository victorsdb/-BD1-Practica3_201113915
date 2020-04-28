BEGIN;

-- ======================================================================================
-- Eliminación de tablas
-- ======================================================================================
	DROP TABLE IF EXISTS pais CASCADE;
	DROP TABLE IF EXISTS ciudad CASCADE;
	DROP TABLE IF EXISTS direccion CASCADE;
	DROP TABLE IF EXISTS tienda CASCADE;
	DROP TABLE IF EXISTS empleado CASCADE;
	DROP TABLE IF EXISTS encargado_tienda CASCADE;
	DROP TABLE IF EXISTS cliente CASCADE;
	DROP TABLE IF EXISTS actor CASCADE;
	DROP TABLE IF EXISTS lenguaje CASCADE;
	DROP TABLE IF EXISTS categoria CASCADE;
	DROP TABLE IF EXISTS clasificacion CASCADE;
	DROP TABLE IF EXISTS pelicula CASCADE;
	DROP TABLE IF EXISTS actor_pelicula CASCADE;
	DROP TABLE IF EXISTS lenguaje_pelicula CASCADE;
	DROP TABLE IF EXISTS categoria_pelicula CASCADE;
	DROP TABLE IF EXISTS copia_pelicula CASCADE;
	DROP TABLE IF EXISTS renta_pelicula CASCADE;
	DROP TABLE IF EXISTS pago_renta CASCADE;
-- ======================================================================================
-- Creación de la tabla PAIS
-- ======================================================================================
	CREATE TABLE pais (
		id_pais      SERIAL NOT NULL,
		nombre_pais  VARCHAR(50) NOT NULL
	);

	ALTER TABLE pais 
		ADD CONSTRAINT pais_pk PRIMARY KEY ( id_pais );
-- ======================================================================================
-- Creación de la tabla CIUDAD
-- ======================================================================================
	CREATE TABLE ciudad (
		id_ciudad      SERIAL NOT NULL,
		nombre_ciudad  VARCHAR(50) NOT NULL,
		pais_ciudad    INTEGER NOT NULL
	);

	ALTER TABLE ciudad 
		ADD CONSTRAINT ciudad_pk PRIMARY KEY ( id_ciudad );

	ALTER TABLE ciudad
		ADD CONSTRAINT pais_ciudad_fk FOREIGN KEY ( pais_ciudad )
			REFERENCES pais ( id_pais );
-- ======================================================================================
-- Creación de la tabla DIRECCION
-- ======================================================================================
	CREATE TABLE direccion (
		id_direccion      SERIAL NOT NULL,
		direccion         VARCHAR(50) NOT NULL,
		codigo_postal     VARCHAR(10),
		ciudad_direccion  INTEGER NOT NULL
	);

	ALTER TABLE direccion 
		ADD CONSTRAINT direccion_pk PRIMARY KEY ( id_direccion );

	ALTER TABLE direccion
		ADD CONSTRAINT ciudad_direccion_fk FOREIGN KEY ( ciudad_direccion )
			REFERENCES ciudad ( id_ciudad );
-- ======================================================================================
-- Creación de la tabla TIENDA
-- ======================================================================================
	CREATE TABLE tienda (
		id_tienda         SERIAL NOT NULL,
		nombre_tienda     VARCHAR(50) NOT NULL,
		direccion_tienda  INTEGER NOT NULL
	);

	ALTER TABLE tienda 
		ADD CONSTRAINT tienda_pk PRIMARY KEY ( id_tienda );

	ALTER TABLE tienda
		ADD CONSTRAINT direccion_tienda_fk FOREIGN KEY ( direccion_tienda )
			REFERENCES direccion ( id_direccion );
-- ======================================================================================
-- Creación de la tabla EMPLEADO
-- ======================================================================================
	CREATE TABLE empleado (
		id_empleado           SERIAL NOT NULL,
		nombre_empleado       VARCHAR(50) NOT NULL,
		apellido_empleado     VARCHAR(50) NOT NULL,
		correo_empleado       VARCHAR(50) NOT NULL,
		empleado_activo       BOOLEAN NOT NULL,
		tienda_empleado       INTEGER NOT NULL,
		usuario_empleado      VARCHAR(50) NOT NULL,
		contrasenia_empleado  VARCHAR(50) NOT NULL,
		direccion_empleado    INTEGER NOT NULL
	);

	ALTER TABLE empleado 
		ADD CONSTRAINT empleado_pk PRIMARY KEY ( id_empleado );

	ALTER TABLE empleado
		ADD CONSTRAINT direccion_empleado_fk FOREIGN KEY ( direccion_empleado )
			REFERENCES direccion ( id_direccion );

	ALTER TABLE empleado
		ADD CONSTRAINT tienda_empleado_fk FOREIGN KEY ( tienda_empleado )
			REFERENCES tienda ( id_tienda );
-- ======================================================================================
-- Creación de la tabla ENCARGADO_TIENDA
-- ======================================================================================
	CREATE TABLE encargado_tienda (
		tienda    INTEGER NOT NULL,
		empleado  INTEGER NOT NULL
	);
	
	ALTER TABLE encargado_tienda 
		ADD CONSTRAINT encargado_tienda_pk PRIMARY KEY ( tienda );

	ALTER TABLE encargado_tienda
		ADD CONSTRAINT encargado_tienda_tienda_fk FOREIGN KEY ( tienda )
			REFERENCES tienda ( id_tienda );
			
	ALTER TABLE encargado_tienda
		ADD CONSTRAINT encargado_tienda_empleado_fk FOREIGN KEY ( empleado )
			REFERENCES empleado ( id_empleado );
-- ======================================================================================
-- Creación de la tabla CLIENTE
-- ======================================================================================
	CREATE TABLE cliente (
		id_cliente                SERIAL NOT NULL,
		nombre_cliente            VARCHAR(50) NOT NULL,
		apellido_cliente          VARCHAR(50) NOT NULL,
		correo_cliente            VARCHAR(50) NOT NULL,
		cliente_activo            BOOLEAN NOT NULL,
		fecha_creacion_cliente    TIMESTAMP,
		tienda_preferida_cliente  INTEGER NOT NULL,
		direccion_cliente         INTEGER NOT NULL
	);

	ALTER TABLE cliente 
		ADD CONSTRAINT cliente_pk PRIMARY KEY ( id_cliente );

	ALTER TABLE cliente
		ADD CONSTRAINT direccion_cliente_fk FOREIGN KEY ( direccion_cliente )
			REFERENCES direccion ( id_direccion );

	ALTER TABLE cliente
		ADD CONSTRAINT tienda_preferida_cliente_fk FOREIGN KEY ( tienda_preferida_cliente )
			REFERENCES tienda ( id_tienda );
-- ======================================================================================
-- Creación de la tabla ACTOR
-- ======================================================================================
	CREATE TABLE actor (
		id_actor        SERIAL NOT NULL,
		nombre_actor    VARCHAR(50) NOT NULL,
		apellido_actor  VARCHAR(50) NOT NULL
	);

	ALTER TABLE actor 
		ADD CONSTRAINT actor_pk PRIMARY KEY ( id_actor );
-- ======================================================================================
-- Creación de la tabla LENGUAJE
-- ======================================================================================
	CREATE TABLE lenguaje (
		id_lenguaje      SERIAL NOT NULL,
		nombre_lenguaje  VARCHAR(50) NOT NULL
	);

	ALTER TABLE lenguaje 
		ADD CONSTRAINT clasificacionv1_pk PRIMARY KEY ( id_lenguaje );
-- ======================================================================================
-- Creación de la tabla CATEGORIA
-- ======================================================================================
	CREATE TABLE categoria (
		id_categoria      SERIAL NOT NULL,
		nombre_categoria  VARCHAR(50) NOT NULL
	);

	ALTER TABLE categoria 
		ADD CONSTRAINT categoria_pk PRIMARY KEY ( id_categoria );
-- ======================================================================================
-- Creación de la tabla CLASIFICACION
-- ======================================================================================
	CREATE TABLE clasificacion (
		id_clasificacion      SERIAL NOT NULL,
		nombre_clasificacion  VARCHAR(50) NOT NULL
	);

	ALTER TABLE clasificacion 
		ADD CONSTRAINT clasificacion_pk PRIMARY KEY ( id_clasificacion );
-- ======================================================================================
-- Creación de la tabla PELICULA
-- ======================================================================================
	CREATE TABLE pelicula (
		id_pelicula             SERIAL NOT NULL,
		nombre_pelicula         VARCHAR(50) NOT NULL,
		descripcion_pelicula    VARCHAR(150) NOT NULL,
		anio_lanzamiento        SMALLINT NOT NULL,
		dias_renta				INTEGER NOT NULL,
		costo_renta             REAL NOT NULL,
		duracion_minutos        INTEGER NOT NULL,
		costo_por_danio         REAL NOT NULL,
		clasificacion_pelicula  INTEGER NOT NULL
	);

	ALTER TABLE pelicula 
		ADD CONSTRAINT pelicula_pk PRIMARY KEY ( id_pelicula );

	ALTER TABLE pelicula
		ADD CONSTRAINT clasificacion_pelicula_fk FOREIGN KEY ( clasificacion_pelicula )
			REFERENCES clasificacion ( id_clasificacion );
-- ======================================================================================
-- Creación de la tabla ACTOR_PELICULA
-- ======================================================================================
	CREATE TABLE actor_pelicula (
		pelicula  INTEGER NOT NULL,
		actor     INTEGER NOT NULL
	);

	ALTER TABLE actor_pelicula
		ADD CONSTRAINT actor_pelicula_fk2 FOREIGN KEY ( pelicula )
			REFERENCES pelicula ( id_pelicula );
			
	ALTER TABLE actor_pelicula
		ADD CONSTRAINT actor_pelicula_fk1 FOREIGN KEY ( actor )
			REFERENCES actor ( id_actor );
-- ======================================================================================
-- Creación de la tabla LENGUAJE_PELICULA
-- ======================================================================================
	CREATE TABLE lenguaje_pelicula (
		pelicula  INTEGER NOT NULL,
		lenguaje  INTEGER NOT NULL
	);

	ALTER TABLE lenguaje_pelicula
		ADD CONSTRAINT lenguaje_pelicula_fk2 FOREIGN KEY ( pelicula )
			REFERENCES pelicula ( id_pelicula );
			
	ALTER TABLE lenguaje_pelicula
		ADD CONSTRAINT lenguaje_pelicula_fk1 FOREIGN KEY ( lenguaje )
			REFERENCES lenguaje ( id_lenguaje );
-- ======================================================================================
-- Creación de la tabla CATEGORIA_PELICULA
-- ======================================================================================
	CREATE TABLE categoria_pelicula (
		pelicula   INTEGER NOT NULL,
		categoria  INTEGER NOT NULL
	);

	ALTER TABLE categoria_pelicula
		ADD CONSTRAINT categoria_pelicula_fk2 FOREIGN KEY ( pelicula )
			REFERENCES pelicula ( id_pelicula );
			
	ALTER TABLE categoria_pelicula
		ADD CONSTRAINT categoria_pelicula_fk1 FOREIGN KEY ( categoria )
			REFERENCES categoria ( id_categoria );
-- ======================================================================================
-- Creación de la tabla COPIA_PELICULA
-- ======================================================================================
	CREATE TABLE copia_pelicula (
		id_copia_pelicula  SERIAL NOT NULL,
		pelicula           INTEGER NOT NULL,
		tienda             INTEGER NOT NULL
	);

	ALTER TABLE copia_pelicula 
		ADD CONSTRAINT copia_pelicula_pk PRIMARY KEY ( id_copia_pelicula );

	ALTER TABLE copia_pelicula
		ADD CONSTRAINT copia_pelicula_pelicula_fk FOREIGN KEY ( pelicula )
			REFERENCES pelicula ( id_pelicula );

	ALTER TABLE copia_pelicula
		ADD CONSTRAINT copia_pelicula_tienda_fk FOREIGN KEY ( tienda )
			REFERENCES tienda ( id_tienda );
-- ======================================================================================
-- Creación de la tabla RENTA_PELICULA
-- ======================================================================================
	CREATE TABLE renta_pelicula (
		id_renta_pelicula     SERIAL NOT NULL,
		cliente_renta         INTEGER NOT NULL,
		copia_pelicula_renta  INTEGER NOT NULL,
		empleado_renta        INTEGER NOT NULL,
		fecha_renta           TIMESTAMP NOT NULL,
		fecha_retorno         TIMESTAMP
	);

	ALTER TABLE renta_pelicula 
		ADD CONSTRAINT renta_pelicula_pk PRIMARY KEY ( id_renta_pelicula );

	ALTER TABLE renta_pelicula
		ADD CONSTRAINT renta_pelicula_cliente_fk FOREIGN KEY ( cliente_renta )
			REFERENCES cliente ( id_cliente );

	ALTER TABLE renta_pelicula
		ADD CONSTRAINT renta_pelicula_pelicula_fk FOREIGN KEY ( copia_pelicula_renta )
			REFERENCES copia_pelicula ( id_copia_pelicula );

	ALTER TABLE renta_pelicula
		ADD CONSTRAINT renta_pelicula_empleado_fk FOREIGN KEY ( empleado_renta )
			REFERENCES empleado ( id_empleado );
-- ======================================================================================
-- Creación de la tabla PAGO_RENTA
-- ======================================================================================
	CREATE TABLE pago_renta (
		renta       INTEGER NOT NULL,
		monto_pago  REAL,
		fecha_pago  TIMESTAMP
	);

	ALTER TABLE pago_renta
		ADD CONSTRAINT pago_renta_renta_pelicula_fk FOREIGN KEY ( renta )
			REFERENCES renta_pelicula ( id_renta_pelicula );
-- ======================================================================================

COMMIT;