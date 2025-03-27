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