INSERT INTO clientes 
(id_clientes, estado, id_cliente_individual) 
VALUES 
(1,  'ACTIVO', 1);
INSERT INTO clientes 
(id_clientes, estado, id_cliente_individual) 
VALUES 
(2,  'ACTIVO', 2);

INSERT INTO clientes_individuales 
(id_cliente_individual, dpi, primer_nombre, segundo_nombre, otros_nombres, primer_apellido, segundo_apellido, otros_apellidos, fecha_nacimiento, estado_civil, clientes_id_clientes, departamento, municipio, zona, grupo_habitacional, vialidad, numero_casa, telefono, correo_electronico) 
VALUES 
(1, '1234567890101', 'Ana', 'Isabel', 'Maria', 'Martinez', 'Lopez', NULL, '1990-05-15', 'SOLTERO', 1, 'Guatemala', 'Ciudad de Guatemala', 'Zona 10', 'Colonia Primavera', 'Calle 5', '101-A', '555-1234', 'cliente.martinez@example.com');

INSERT INTO clientes_individuales 
(id_cliente_individual, dpi, primer_nombre, segundo_nombre, otros_nombres, primer_apellido, segundo_apellido, otros_apellidos, fecha_nacimiento, estado_civil, clientes_id_clientes, departamento, municipio, zona, grupo_habitacional, vialidad, numero_casa, telefono, correo_electronico) 
VALUES 
(2, '111111111111', 'Maria', NULL, NULL, 'Martinez', 'Lopez', NULL, '1990-03-15', 'CASADO', 2, 'Guatemala', 'Ciudad de Guatemala', 'Zona 10', 'Colonia Primavera', 'Calle 5', '101-A', '555-1234', 'naria.martinez@example.com');

INSERT INTO fiador (cliente_id_cliente, parentesco, prestamo_id_prestamo, fecha_registro)
VALUES (2, 'Hermano', 10, '2025-04-17 23:15:00');

INSERT INTO solicitud_credito 
(id_solicitud, correo_electronico, estado_civil, ocupacion, segundo_nombre, DPI, cliente_id_cliente, fiador_id_fiador, estado_solicitud) 
VALUES 
(1, 'cliente.martinez@example.com', 'SOLTERO', 'Comerciante', 'Isabel', '1234567890101', 1, 2, 'APROBADO');

INSERT INTO bienes_inmuebles (valor, tipo, ubicacion, id_solicitud) VALUES (40000, 'Residencial', 'Ciudad', 1);
INSERT INTO bienes_inmuebles (valor, tipo, ubicacion, id_solicitud) VALUES (200, 'Residencial', 'Ciudad', 1);

SELECT * FROM bienes_inmuebles;

-- PRUEBA OCUPACION

INSERT INTO ocupacion (id_empleo, empresa, puesto, fecha_inicio_labores, ingresos_base, estado, id_solicitud)
VALUES 
(1, 'TechCorp', 'Ing. de Software', '2020-01-15', 5000.00, NULL, 1);
INSERT INTO ocupacion (id_empleo, empresa, puesto, fecha_inicio_labores, ingresos_base, estado, id_solicitud)
VALUES (3, 'SoftData', 'Analista', '2024-05-01', 4000.00, NULL, 1); 

SELECT * FROM ocupacion;

-- PRUEBA VALIDAR PROMEDIO DE INGRESOS MENSUALES 
INSERT INTO ingresos_familiares (tipo_ingreso, cantidad_familiares, promedio_mensual, estado, id_solicitud) 
VALUES ('Familiar', 3, 12000, NULL, 1); 
INSERT INTO ingresos_familiares (tipo_ingreso, cantidad_familiares, promedio_mensual, estado, id_solicitud) 
VALUES ('Familiar', 0, 1200, NULL, 1); 

SELECT * FROM ingresos_familiares;

-- PRUEBA TG OTROS INGRESOS 

INSERT INTO otros_ingresos (id_otro_ingreso, frecuencia, tipo_ingreso, monto_promedio_mensual, estado, id_solicitud)
VALUES 
(1, 'cada 2 meses', 'Venta ocasional', 800, NULL, 1),
(2, 'mensual', 'horas extra', 300, NULL, 1); 

SELECT * FROM otros_ingresos;

-- EVALUAR REFERENCIAS 

INSERT INTO referencias_personales 
(telefono, parentesco, primer_nombre, segundo_nombre, otros_nombres, primer_apellido, segundo_apellido, otros_apellidos, departamento, municipio, zona, grupo_habitacional, numero_casa, vialidad, DPI, estado, id_solicitud, ocupacion_referencia, criterio)
VALUES 
('555-1234', 'Amigo', 'Carlos', 'Eduardo', 'Martinez', 'Ramirez', 'Lopez', NULL, 'Guatemala', 'Ciudad de Guatemala', 'Zona 1', 'Primavera', '12-A', 'Calle 5', '1234567890101', NULL, 1, 'Ingeniero', 'FAVORABLE'),
('555-5678', 'Hermano', 'Ana', 'Isabel', 'Morales', 'Lopez', 'Garcia', NULL, 'Guatemala', 'Ciudad de Guatemala', 'Zona 5', 'Las Rosas', '6-B', 'Avenida 6', '9876543210123', NULL, 1, 'Doctora', 'NO_FAVORABLE'),
('555-9999', 'Primo', 'Luis', 'Alfredo', 'Sanchez', 'Gomez', 'Martinez', NULL, 'Guatemala', 'Ciudad de Guatemala', 'Zona 7', 'San José', '15-C', 'Calle 8', '5678901234567', NULL, 1, 'Contador', 'POR EVALUAR');

SELECT * FROM referencias_personales;

-- EVALUAR VEHICULOS (Si es 1 o mas el estatus es APROBADO)

INSERT INTO vehiculos 
(marca, modelo, año, valor, tipo_vehiculo, finalidad_vehiculo, cantidad_vehiculos, placas, fase, fecha_compra, estado_vehiculo, estado, id_solicitud)
VALUES 
('Toyota', 'Corolla', 2015, 30000, 'Sedán', 'USO_PERSONAL', 2, 'P12345', 'PAGADO', '2023-05-15', 'NUEVO', NULL, 1),
('Chevrolet', 'Camaro', 2010, 15000, 'Hatchback', 'USO_COMERCIAL', 0, 'C67890', 'EN_PROCESO_DE_PAGO', '2022-08-20', 'USADO', NULL, 1);

SELECT * FROM vehiculos;

-- VERIFICAR HISTORIAL CREDITICIO
INSERT INTO historial_crediticio 
(id_historial, tipo_credito, monto, estatus, estado, historial_cliente, puntualidad_pagos, observaciones, id_solicitud)
VALUES 
(1, 'Personal', 15000.00, 'PAGADO', 'APROBADO', 'CON_HISTORIAL', 95.00, 'El cliente ha cumplido con todos los pagos de forma puntual.', 1),
(2, 'Hipotecario', 80000.00, 'INCUMPLIDO', 'RECHAZADO', 'CON_HISTORIAL', 70.00, 'Retraso en pagos por más de 6 meses.', 1),
(3, 'Automotriz', 25000.00, 'PENDIENTE', 'APROBADO', 'SIN_HISTORIAL', NULL, 'No se han registrado pagos debido a que el crédito es reciente.', 1);

SELECT * FROM historial_crediticio;
SELECT * FROM solicitud_credito;

SELECT estado_solicitud FROM solicitud_credito WHERE id_solicitud = 1;

-- EL CAMPO "puntualidad_pagos" se mide según el porcentaje, no debe colocarse el signo %
INSERT INTO historial_crediticio 
(tipo_credito, monto, estatus, puntualidad_pagos, observaciones, id_solicitud)
VALUES 
('Personal', 20000, 'PAGADO', 95, 'Pago puntual en todos los casos.', 1), -- Debería ser APROBADO
('Automotriz', 30000, 'PENDIENTE', 85, 'Pago con retrasos esporádicos.', 1), -- Debería ser RECHAZADO
('Hipotecario', 100000, 'INCUMPLIDO', NULL, 'El cliente incumplió varios pagos.', 1); -- Debería ser RECHAZADO
-- (4, 'Estudiantil', 15000, 'PENDIENTE', NULL, 'No se encontraron registros previos.', 2); -- Debería ser SIN HISTORIAL

SELECT * FROM historial_crediticio;

UPDATE bienes_inmuebles SET estado = 'RECHAZADO' WHERE id_solicitud = 1;
UPDATE referencias_personales SET estado = 'APROBADO' WHERE id_solicitud = 1;
UPDATE ocupacion SET estado = 'APROBADO' WHERE id_solicitud = 1;

SELECT estado_solicitud FROM solicitud_credito WHERE id_solicitud = 1;

SELECT * FROM bienes_inmuebles;
SELECT id_solicitud, estado_solicitud
FROM solicitud_credito
WHERE id_solicitud = 1;

-- PRUEBA CONJUNTA (NO ESTÁN TODAS LAS TABLAS DE ESTUDIO)

INSERT INTO solicitud_credito (
    correo_electronico,
    estado_civil,
    ocupacion,
    DPI,
    cliente_id_cliente,
    fiador_id_fiador
) VALUES (
    'nuevo_cliente@example.com', -- Correo del cliente
    'Casado',                   -- Estado civil
    'Abogado',                  -- Ocupación
    '9876543210987',            -- DPI
    2,                          -- ID del cliente asociado
    1                           -- ID del fiador asociado
);
SELECT * FROM solicitud_credito;
INSERT INTO bienes_inmuebles (valor, tipo, ubicacion, id_solicitud) VALUES (40000, 'terreno', 'Xela', 2);
SELECT * FROM bienes_inmuebles WHERE id_solicitud = 2;
INSERT INTO ocupacion (empresa, puesto, fecha_inicio_labores, ingresos_base, estado, id_solicitud)
VALUES ('SoftData', 'Servicio Cliente', '2025-05-01', 4000.00, NULL, 2); 
SELECT * FROM ocupacion;
SELECT * FROM solicitud_credito;

-- PRUEBA SP REGISTRO 

CALL RegistrarPrestamo(1, 1, 2, @mensaje);
SELECT @mensaje AS MensajeResultado;

CALL RegistrarPrestamo(2, 2, 1, @mensaje);
SELECT @mensaje AS MensajeResultado;
SELECT * FROM solicitud_credito;

SELECT *FROM prestamos;
DELETE FROM prestamos
WHERE id_prestamo IN (1, 2);
SELECT *FROM prestamos;

CALL RegistrarPrestamo(1, 1, 2, @mensaje);
SELECT @mensaje AS MensajeResultado;

CALL RegistrarPrestamo(2, 2, 1, @mensaje);
SELECT @mensaje AS MensajeResultado;

SELECT * FROM solicitud_credito;
SELECT *FROM prestamos;

SELECT * FROM solicitud_credito;

CALL RegistrarPrestamo(1, 1, 2, @mensaje);
SELECT @mensaje AS MensajeResultado;

CALL RegistrarPrestamo(2, 2, 1, @mensaje);
SELECT @mensaje AS MensajeResultado;

SELECT *FROM prestamos;

-- PRUEBA APORTES 

-- REALIZAMOS TRIGGER PARA GENERAR UNA FECHA DE RETIRO EN BASE A LA FECHA CREACION tgBefore_AsignarBloqueoAportes
INSERT INTO cuentas_aportes (id_clientes, id_cuenta_aporte, saldo, fecha_creacion)
VALUES (1, 'APORT12345', 100.00, NOW());
SELECT * FROM cuentas_aportes;

-- REALIZAMOS TRIGGER PARA CALCULO DE SALDO, EL SALDO ES EL TOTAL DE LA CUENTA Y EL MONTO LO UTILIZADO PARA CADA OPERACION
INSERT INTO manejo_aportes (id_cuenta_aporte, tipo_operacion, monto)
VALUES ('APORT12345', 'RETIRO', 300);
SELECT * FROM manejo_aportes;
SELECT * FROM cuentas_aportes;

SELECT saldo FROM cuentas_aportes WHERE id_cuenta_aporte = 'APORT12345';