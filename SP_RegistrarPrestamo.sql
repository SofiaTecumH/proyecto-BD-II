CREATE DEFINER=`root`@`localhost` PROCEDURE `RegistrarPrestamo`(
    IN id_solicitud INT,
    IN id_cliente INT,
    IN id_fiador INT,
    OUT mensaje TEXT
)
BEGIN
    DECLARE solicitud_estado VARCHAR(20); -- Para manejar estados correctamente
    DECLARE monto DECIMAL(12,2); -- Fijar el monto a 10,000

    -- Asignar el valor fijo para el préstamo
    SET monto = 10000;

    -- Bloque de validación
    validaciones: BEGIN
        -- Validar que el cliente exista
        IF NOT EXISTS (
            SELECT 1 FROM clientes WHERE id_cliente = id_cliente
        ) THEN
            SET mensaje = 'Error: El cliente no existe.';
            LEAVE validaciones; -- Detener ejecución
        END IF; -- Cierra el bloque correctamente

        -- Validar que el fiador exista
        IF NOT EXISTS (
            SELECT 1 FROM clientes WHERE id_cliente = id_fiador
        ) THEN
            SET mensaje = 'Error: El fiador no existe.';
            LEAVE validaciones; -- Detener ejecución
        END IF; -- Cierra el bloque correctamente

        -- Obtener el estado de la solicitud
        SELECT estado_solicitud INTO solicitud_estado
        FROM solicitud_credito
        WHERE id_solicitud = id_solicitud;

        -- Validar que la solicitud exista
        IF solicitud_estado IS NULL THEN
            SET mensaje = 'Error: La solicitud no existe.';
            LEAVE validaciones; -- Detener ejecución
        END IF; -- Cierra el bloque correctamente

        -- Validar que la solicitud esté estrictamente en estado 'APROBADO'
        IF UPPER(TRIM(solicitud_estado)) != 'APROBADO' THEN
            SET mensaje = 'Error: La solicitud debe estar en estado APROBADO.';
            LEAVE validaciones; -- Detener ejecución
        END IF; -- Cierra el bloque correctamente
    END validaciones;

    -- Insertar el préstamo en la tabla 'prestamos'
    INSERT INTO prestamos (
        id_solicitud, id_cliente, id_fiador, monto, saldo_pendiente, fecha, estado
    ) VALUES (
        id_solicitud, id_cliente, id_fiador, monto, monto, NOW(), 'PENDIENTE'
    );

    -- Mensaje de confirmación
    SET mensaje = CONCAT('Préstamo registrado exitosamente con monto de ', monto, ' para el cliente ID: ', id_cliente);
END