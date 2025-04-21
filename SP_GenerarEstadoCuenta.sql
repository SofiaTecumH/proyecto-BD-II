CREATE DEFINER=`root`@`localhost` PROCEDURE `GenerarEstadoCuenta`(
    IN id_cliente INT,
    OUT mensaje TEXT
)
BEGIN
    -- Validar que el cliente exista
    validaciones: BEGIN
        IF NOT EXISTS (
            SELECT 1 FROM clientes WHERE id_cliente = id_cliente
        ) THEN
            SET mensaje = 'Error: El cliente no existe.';
            LEAVE validaciones;
        END IF;
    END validaciones;

    -- Generar estado de cuenta para cuentas monetarias
    SELECT 
        cm.numero_cuenta AS cuenta_monetaria,
        cm.saldo_actual AS saldo,
        hm.fecha AS fecha_movimiento,
        hm.tipo_movimiento AS tipo_movimiento,
        hm.monto AS monto,
        hm.saldo_despues AS saldo_despues,
        hm.descripcion AS descripcion
    FROM cuenta_monetaria cm
    LEFT JOIN historial_movimientos hm ON cm.id_cuenta_monetaria = hm.id_cuenta_monetaria
    WHERE cm.id_cliente = id_cliente
    ORDER BY hm.fecha ASC;

    -- Generar estado de cuenta para cuentas de ahorro
    SELECT 
        ca.numero_cuenta AS cuenta_ahorro,
        ca.saldo_actual AS saldo,
        hm.fecha AS fecha_movimiento,
        hm.tipo_movimiento AS tipo_movimiento,
        hm.monto AS monto,
        hm.saldo_despues AS saldo_despues,
        hm.descripcion AS descripcion
    FROM cuenta_ahorro ca
    LEFT JOIN historial_movimientos hm ON ca.id_cuenta_ahorro = hm.id_cuenta_ahorro
    WHERE ca.id_cliente = id_cliente
    ORDER BY hm.fecha ASC;

    -- Mensaje de éxito
    SET mensaje = CONCAT('Estado de cuenta generado exitosamente para el cliente con ID: ', id_cliente, '.');
END