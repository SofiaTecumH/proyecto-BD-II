CREATE DEFINER=`root`@`localhost` PROCEDURE `GenerarEstadoCuenta`(
    IN id_cliente INT,
    OUT mensaje TEXT
)
BEGIN
    -- Validar que el cliente exista  
    validaciones: BEGIN
        IF NOT EXISTS (
            SELECT 1 FROM clientes WHERE id_clientes = id_cliente
        ) THEN
            SET mensaje = 'Error: El cliente no existe.';
            LEAVE validaciones;
        END IF;
    END validaciones;

    -- Generar estado de cuenta para cuentas monetarias  
    SELECT  
        cm.id_cuenta_monetaria,  
        cm.saldo AS saldo,  
        ob.fecha AS fecha_operacion,  
        ob.operacion AS tipo_movimiento,  
        ob.monto AS monto,  
        hm.descripcion  
    FROM cuentas_monetarias cm  
    LEFT JOIN operaciones_bancarias ob ON cm.id_cuenta_monetaria = ob.id_cuenta_monetaria  
    LEFT JOIN historial_movimientos hm ON cm.id_cuenta_monetaria = hm.id_cuenta_monetaria  
    WHERE cm.id_cliente = id_cliente  
    ORDER BY ob.fecha ASC;

    -- Generar estado de cuenta para cuentas de ahorro  
    SELECT  
        ca.id_cuenta_ahorro,  
        ca.monto AS saldo,  
        ob.fecha AS fecha_operacion,  
        ob.operacion AS tipo_movimiento,  
        ob.monto AS monto,  
        hm.descripcion  
    FROM cuentas_ahorro ca  
    LEFT JOIN operaciones_bancarias ob ON ca.id_cuenta_ahorro = ob.id_cuenta_ahorro  
    LEFT JOIN historial_movimientos hm ON ca.id_cuenta_ahorro = hm.id_cuenta_ahorro  
    WHERE ca.id_clientes = id_cliente  
    ORDER BY ob.fecha ASC;

    -- Mensaje de éxito  
    SET mensaje = CONCAT('Estado de cuenta generado exitosamente para el cliente con ID: ', id_cliente, '.');
END
