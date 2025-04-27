CREATE DEFINER=`root`@`localhost` PROCEDURE `CalcularYAbonarIntereses`()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE cuentaId VARCHAR(20);  -- Ajustado al tipo de dato correcto según la tabla
    DECLARE monto DECIMAL(12,2);  -- Ajustado al nombre correcto en `cuentas_ahorro`
    DECLARE tasa_interes DECIMAL(12,2);
    DECLARE cur CURSOR FOR
        SELECT id_cuenta_ahorro, monto
        FROM cuentas_ahorro;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    --  Abrimos el cursor para iterar por las cuentas de ahorro  
    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO cuentaId, monto;
        IF done THEN
            LEAVE read_loop;
        END IF;

        --  Obtener la tasa de interés correspondiente  
        SELECT tasa_interes
        INTO tasa_interes
        FROM cuentas_ahorro
        WHERE id_cuenta_ahorro = cuentaId;

        --  Calcular los intereses  
        SET monto = monto + (monto * tasa_interes / 100);

        --  Actualizar el saldo en `cuentas_ahorro`  
        UPDATE cuentas_ahorro
        SET monto = monto
        WHERE id_cuenta_ahorro = cuentaId;
    END LOOP;

    -- Cerramos el cursor  
    CLOSE cur;
END
