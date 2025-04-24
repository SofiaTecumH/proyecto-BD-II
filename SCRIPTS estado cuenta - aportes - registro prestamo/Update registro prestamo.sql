-- CAMBIOS PARA REGISTRAR PRESTAMO

ALTER TABLE bienes_inmuebles
CHANGE `valor` `valor` DECIMAL(12,2) DEFAULT '0.00';

ALTER TABLE clientes DROP COLUMN otros_nombres;
ALTER TABLE clientes CHANGE `id_cliente_juridico` `id_cliente_juridico` INT DEFAULT NULL;
ALTER TABLE clientes CHANGE `id_cliente_individual` `id_cliente_individual` INT DEFAULT NULL;
ALTER TABLE clientes CHANGE `id_socio` `id_socio` INT DEFAULT NULL;

ALTER TABLE referencias_personales
DROP COLUMN nombre,
ADD COLUMN ocupacion_referencia VARCHAR(50),
ADD COLUMN criterio ENUM ('FAVORABLE', 'NO_FAVORABLE', 'POR EVALUAR');
ALTER TABLE solicitud_credito MODIFY estado_solicitud ENUM('APROBADO', 'RECHAZADO', 'POR_EVALUAR');

ALTER TABLE solicitud_credito DROP COLUMN segundo_nombre;

ALTER TABLE prestamos
ADD COLUMN id_cliente INT NOT NULL,
ADD COLUMN id_fiador INT NOT NULL;
ALTER TABLE prestamos
ADD CONSTRAINT fk_cliente FOREIGN KEY (id_cliente) REFERENCES clientes (id_clientes) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT fk_fiador FOREIGN KEY (id_fiador) REFERENCES fiador (id_fiador) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE prestamos
DROP FOREIGN KEY fk_prestamos_porcentajes_intereses1,
DROP COLUMN porcentajes_intereses_id_interes;

ALTER TABLE solicitud_credito
ADD COLUMN tipo_prestamo ENUM ('FIDUCIARIO', 'HIPOTECARIO');

ALTER TABLE prestamos ADD COLUMN id_solicitud INT NOT NULL;
ALTER TABLE prestamos ADD CONSTRAINT fk_solicitud FOREIGN KEY (id_solicitud) REFERENCES solicitud_credito (id_solicitud) ON DELETE CASCADE ON UPDATE CASCADE;

-- UPDATE PARA ESTADO CUENTA

ALTER TABLE historial_movimientos
DROP FOREIGN KEY fk_historial_movimientos_usuarios1,
DROP COLUMN usuarios_id_usuario,
DROP FOREIGN KEY fk_historial_movimientos_bitacora1,
DROP COLUMN bitacora_id_bitacora;

ALTER TABLE historial_movimientos CHANGE tipo_movimiento `tipo_movimiento` ENUM ('DEPOSITO', 'RETIRO');
ALTER TABLE historial_movimientos ADD COLUMN descripcion VARCHAR (50) DEFAULT NULL;

-- UDATE CUENTAS APORTES 

ALTER TABLE cuentas_aportes
ADD PRIMARY KEY (id_cuenta_aporte),
MODIFY id_clientes INT NOT NULL,
ADD CONSTRAINT fk_cliente_aporte FOREIGN KEY (id_clientes) REFERENCES clientes(id_clientes),
ADD COLUMN bloqueo_hasta DATE DEFAULT NULL;
-- ADD CONSTRAINT chk_saldo_minimo CHECK (saldo >= 100);

-- ADD CONSTRAINT fk_manejo_cuenta FOREIGN KEY (id_cuenta_aporte)  REFERENCES cuentas_aportes(;
ALTER TABLE manejo_aportes
ADD CONSTRAINT fk_manejo_cuenta FOREIGN KEY (id_cuenta_aporte) REFERENCES cuentas_aportes(id_cuenta_aporte),
DROP COLUMN id_clientes,
DROP COLUMN retiros,
DROP COLUMN depositos,
ADD COLUMN monto DECIMAL (12,2) NOT NULL; -- CANTIDAD ESPECIFICA DE CADA TRANSACCION, SALDO ES TOTAL DE LA CUENTA APORTE 
ALTER TABLE manejo_aportes
DROP COLUMN intereses,
ADD COLUMN tipo_operacion ENUM('DEPOSITO', 'RETIRO', 'INTERESES');

ALTER TABLE manejo_aportes MODIFY saldo DECIMAL(12,2) DEFAULT 0 NOT NULL;

ALTER TABLE cuentas_aportes CHANGE saldo monto_apertura DECIMAL(12,2);

-- UPDATE CLIENTES JURIDICOS

ALTER TABLE usuarios_cuenta_juridica
DROP FOREIGN KEY fk_id_usuarios_cuenta_juridica,
DROP COLUMN id_cliente_juridico;

ALTER TABLE clientesjuridicos
DROP FOREIGN KEY fk_clientesjuridicos_clientes1,
DROP COLUMN clientes_id_clientes,
ADD COLUMN id_usuarios_cuenta_juridica INT NOT NULL,
ADD CONSTRAINT fk_usuarios_cuenta FOREIGN KEY (id_usuarios_cuenta_juridica) REFERENCES usuarios_cuenta_juridica(id_usuarios_cuenta_juridica);