USE cooperativa_db;

-- CREAR TABLA INTERESES PRESTAMOS
-- Agregar campos de 12, 18, 24 para cada tipo de prestamo según sus intereses (fiduciario 12 cuotas, fiduaciario 18 cuotas)
-- SIN REFERENCIAS // O LA DE APROBACION DE PRESTAMO

CREATE TABLE IF NOT EXISTS intereses_prestamos(
id_intereses_prestamo INT NOT NULL,
fiduciario12_c DECIMAL(10,2) DEFAULT '0.00',
fiduciario18_c DECIMAL(10,2) DEFAULT '0.00',
fiduciario24_c DECIMAL(10,2) DEFAULT '0.00',
hipotecario12_c DECIMAL(10,2) DEFAULT '0.00',
hipotecario18_c DECIMAL(10,2) DEFAULT '0.00',
hipotecario24_c DECIMAL(10,2) DEFAULT '0.00'
);

ALTER TABLE operaciones_bancarias DROP FOREIGN KEY fk_operaciones_bancarias_usuarios1;
ALTER TABLE operaciones_bancarias DROP FOREIGN KEY operaciones_bancarias_ibfk_1;
ALTER TABLE operaciones_bancarias DROP FOREIGN KEY operaciones_bancarias_ibfk_2;

ALTER TABLE operaciones_bancarias DROP COLUMN usuarios_id_usuario;
ALTER TABLE operaciones_bancarias DROP COLUMN id_cuenta_ahorro;
ALTER TABLE operaciones_bancarias DROP COLUMN id_cuenta_monetaria;
ALTER TABLE operaciones_bancarias ADD COLUMN id_cuenta_ahorro VARCHAR(20) NULL DEFAULT NULL;
ALTER TABLE operaciones_bancarias ADD COLUMN id_cuenta_monetaria VARCHAR(20) NULL DEFAULT NULL;

ALTER TABLE clientes
DROP COLUMN tipo_cliente;

CREATE TABLE catalogo_clientes(
id_clientes VARCHAR(20) NOT NULL,
tipo_cliente VARCHAR(50) NOT NULL
);

INSERT INTO catalogo_clientes (id_clientes, tipo_cliente) VALUES
('1', 'CLIENTE_INDIVIDUAL'),
('2', 'CLIENTE_JURIDICO'),
('3', 'SOCIO');

ALTER TABLE cuentas_ahorro DROP FOREIGN KEY fk_cuentas_ahorro_socios1;
ALTER TABLE porcentajes_intereses DROP FOREIGN KEY fk_porcentajes_intereses_cuentas_ahorro1;
ALTER TABLE historial_movimientos DROP FOREIGN KEY historial_movimientos_ibfk_2;
ALTER TABLE pagos_intereses DROP FOREIGN KEY pagos_intereses_ibfk_1;

ALTER TABLE cuentas_ahorro DROP COLUMN id_cuenta_ahorro;
ALTER TABLE cuentas_ahorro DROP COLUMN socios_id_socio;
ALTER TABLE cuentas_ahorro ADD COLUMN id_clientes VARCHAR(20) NOT NULL;
ALTER TABLE cuentas_ahorro ADD COLUMN id_cuenta_ahorro VARCHAR(20) NOT NULL;

ALTER TABLE socios DROP FOREIGN KEY fk_socios_cuentas_aportes1;
ALTER TABLE cuentas_aportes DROP FOREIGN KEY fk_cuentas_aportes_socios1;

ALTER TABLE cuentas_aportes DROP COLUMN id_cuenta_aporte;
ALTER TABLE cuentas_aportes DROP COLUMN socios_id_socio;
ALTER TABLE cuentas_aportes ADD COLUMN id_clientes VARCHAR(20) NOT NULL;
ALTER TABLE cuentas_aportes ADD COLUMN id_cuenta_aporte VARCHAR(20) NOT NULL;

ALTER TABLE historial_movimientos DROP FOREIGN KEY historial_movimientos_ibfk_3;

ALTER TABLE cuentas_monetarias DROP COLUMN id_cuenta_monetaria;
ALTER TABLE cuentas_monetarias ADD COLUMN id_cuenta_monetaria VARCHAR(20) NOT NULL;

ALTER TABLE socios DROP COLUMN cuentas_aportes_id_cuenta_aporte;

CREATE TABLE manejo_aportes(
id_manejo_aporte INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
id_cuenta_aporte VARCHAR(20) NOT NULL,
id_clientes VARCHAR(20) NOT NULL,
fecha_operacion DATETIME,
concepto VARCHAR(50) NULL DEFAULT NULL,
retiros DECIMAL(10,2) DEFAULT '0.00',
depositos DECIMAL(10,2) DEFAULT '0.00',
intereses DECIMAL(10,2) DEFAULT '0.00',
saldo DECIMAL(10,2) DEFAULT '0.00'
);

-- ----------------------------------------------------------------------------
-- Actualización tablas estudio socioeconómico
-- ----------------------------------------------------------------------------

ALTER TABLE vehiculos
DROP COLUMN id_cliente,
ADD COLUMN tipo_vehiculo VARCHAR(20) NOT NULL, -- Van, camioneta, bus, panel, etc
ADD COLUMN finalidad_vehiculo ENUM ('USO_PERSONAL', 'USO_COMERCIAL') NOT NULL,
ADD COLUMN cantidad_vehiculos INT NOT NULL,
DROP COLUMN financiado, 
ADD COLUMN placas VARCHAR(10) NOT NULL,
ADD COLUMN fase ENUM ('PAGADO', 'EN_PROCESO_DE_PAGO') NOT NULL,
ADD COLUMN fecha_compra DATE,
ADD COLUMN estado_vehiculo ENUM ('USADO', 'NUEVO');

ALTER TABLE referencias_personales
DROP COLUMN id_cliente,
ADD COLUMN `primer_nombre` VARCHAR(200) NOT NULL,
ADD COLUMN `segundo_nombre` VARCHAR(200) NULL DEFAULT NULL,
ADD COLUMN `otros_nombres` VARCHAR(200) NULL DEFAULT NULL,
ADD COLUMN `primer_apellido` VARCHAR(250) NOT NULL,
ADD COLUMN `segundo_apellido` VARCHAR(250) NULL DEFAULT NULL,
ADD COLUMN `otros_apellidos` VARCHAR(100) NULL DEFAULT NULL,
ADD COLUMN `departamento` VARCHAR(300) NOT NULL,
ADD COLUMN `municipio` VARCHAR(300) NOT NULL,
ADD COLUMN `zona` VARCHAR(300) NOT NULL,
ADD COLUMN `grupo_habitacional` VARCHAR(300) NOT NULL,
ADD COLUMN `vialidad` VARCHAR(300) NOT NULL,
ADD COLUMN `numero_casa` VARCHAR(300) NOT NULL,
ADD COLUMN  `DPI` VARCHAR(20) NOT NULL;

ALTER TABLE otros_ingresos
DROP COLUMN id_cliente,
DROP COLUMN fuente,
ADD COLUMN tipo_ingreso VARCHAR(100) NOT NULL, -- negocio, remesa, etc
DROP COLUMN monto,
ADD COLUMN monto_promedio_mensual DECIMAL(12,2) DEFAULT '0.00';

ALTER TABLE ingresos_familiares
DROP COLUMN id_cliente,
ADD COLUMN cantidad_familiares INT NULL DEFAULT NULL,
ADD COLUMN parentesco VARCHAR(20),
DROP COLUMN monto,
ADD COLUMN promedio_mensual DECIMAL(12,2) DEFAULT '0.00';

RENAME TABLE empleo TO ocupacion;

ALTER TABLE ocupacion
DROP COLUMN id_cliente,
DROP COLUMN antiguedad,
ADD COLUMN fecha_inicio_labores DATE NULL DEFAULT NULL,
DROP COLUMN salario,
ADD COLUMN ingresos_base DECIMAL (12,2) DEFAULT '0.00';

ALTER TABLE bienes_inmuebles
DROP COLUMN id_cliente,
DROP COLUMN hipoteca;

ALTER TABLE historial_crediticio
DROP COLUMN id_cliente;

RENAME TABLE informacion_solicitante_credito TO solicitud_credito;

ALTER TABLE solicitud_credito
DROP PRIMARY KEY,
CHANGE `id_solicitante` `id_solicitud` INT NOT NULL AUTO_INCREMENT,
ADD PRIMARY KEY (id_solicitud),
CHANGE `nombre` `primer_nombre` VARCHAR(100) NOT NULL,
ADD COLUMN `segundo_nombre` VARCHAR(200) NULL DEFAULT NULL,
ADD COLUMN `otros_nombres` VARCHAR(200) NULL DEFAULT NULL,
ADD COLUMN `primer_apellido` VARCHAR(250) NOT NULL,
ADD COLUMN `segundo_apellido` VARCHAR(250) NULL DEFAULT NULL,
ADD COLUMN `otros_apellidos` VARCHAR(100) NULL DEFAULT NULL,
DROP COLUMN direccion,
ADD COLUMN `departamento` VARCHAR(300) NOT NULL,
ADD COLUMN `municipio` VARCHAR(300) NOT NULL,
ADD COLUMN `zona` VARCHAR(300) NOT NULL,
ADD COLUMN `grupo_habitacional` VARCHAR(300) NOT NULL,
ADD COLUMN `vialidad` VARCHAR(300) NOT NULL,
ADD COLUMN `numero_casa` VARCHAR(300) NOT NULL,
ADD COLUMN  `DPI` VARCHAR(20) NOT NULL,
DROP COLUMN ingresos_promedio,
DROP COLUMN historial_crediticio,
DROP COLUMN bienes_inmuebles,
DROP COLUMN referencias_personales,
DROP COLUMN otros_datos;

ALTER TABLE solicitud_credito DROP FOREIGN KEY fk_informacion_solicitante_credito_usuarios1;
ALTER TABLE solicitud_credito DROP COLUMN usuarios_id_usuario;
