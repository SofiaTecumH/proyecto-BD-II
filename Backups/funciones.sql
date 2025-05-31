CREATE DEFINER=`root`@`localhost` PROCEDURE `apertura_cuentas_aportes`(IN p_monto_aportacion decimal(12, 2),IN p_fecha_creacion DATETIME , IN p_id_clientes INT)
BEGIN
		DECLARE cuenta_existente INT;
            SELECT COUNT(*) INTO cuenta_existente
		    FROM cuentas_aportes
            WHERE id_clientes = p_id_clientes;
            
		IF cuenta_existente > 0 THEN
           SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El cliente ya tiene una cuenta de aportaciones abierta';
        END IF;
        
		IF p_monto_aportacion < 100 THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El monto inicial debe ser mayor que 100';
		END IF;

		INSERT INTO cuentas_aportes (monto_apertura, fecha_creacion, id_clientes)
		VALUES (p_monto_aportacion, now() , p_id_clientes);


    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `apertura_cuenta_monetaria` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `apertura_cuenta_monetaria`(IN p_saldo decimal(12, 2),IN p_fecha_creacion DATETIME, IN p_id_cliente INT)
BEGIN
		DECLARE cuenta_existente INT;
            SELECT COUNT(*) INTO cuenta_existente
		    FROM cuentas_monetarias
            WHERE id_cliente = p_id_cliente;
            
		IF cuenta_existente > 0 THEN
           SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El cliente ya tiene una cuenta monetaria abierta';
        END IF;
        
		IF p_saldo <= 0 THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El monto inicial debe ser mayor que 0';
		END IF;

		INSERT INTO cuentas_monetarias (saldo, fecha_creacion, id_cliente)
		VALUES (p_saldo, now(), p_id_cliente);


    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CalcularYAbonarIntereses` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GenerarEstadoCuenta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `generar_cuotas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `generar_cuotas`(
    IN p_id_prestamo INT,              -- ID del préstamo
    IN p_numero_cuotas INT,            -- Número de cuotas solicitadas por el cliente
    IN p_tasa_interes DECIMAL(5,2)     -- Tasa de interés que se aplicará
)
BEGIN
    DECLARE v_monto_base DECIMAL(12,2);
    DECLARE v_interes_total DECIMAL(12,2);
    DECLARE v_total_pagar DECIMAL(12,2);
    DECLARE v_monto_mensual DECIMAL(12,2);
    DECLARE v_fecha_inicio DATE;
    DECLARE v_monto_pendiente DECIMAL(12,2);
    DECLARE v_fecha_pago DATE;

    -- Obtener monto del préstamo y la fecha de inicio
    SELECT monto, DATE(fecha)
    INTO v_monto_base, v_fecha_inicio
    FROM prestamos
    WHERE id_prestamo = p_id_prestamo;

    -- Validar que el préstamo exista
    IF v_monto_base IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El préstamo con el ID especificado no existe.';
    END IF;

    -- Actualizar la tasa de interés en la tabla de préstamos
    UPDATE prestamos
    SET intereses = p_tasa_interes
    WHERE id_prestamo = p_id_prestamo;

    -- Calcular el total de intereses sobre el monto base
    SET v_interes_total = v_monto_base * (p_tasa_interes / 100);
    
    -- Calcular el monto total a pagar (monto base + intereses)
    SET v_total_pagar = v_monto_base + v_interes_total;

    -- Calcular el monto mensual de la cuota
    SET v_monto_mensual = ROUND(v_total_pagar / p_numero_cuotas, 2);

    -- Establecer el monto pendiente inicial (igual al monto total del préstamo)
    SET v_monto_pendiente = v_monto_base;

    -- Generar la fecha de pago (la primer cuota se paga en el primer mes)
    SET v_fecha_pago = DATE_ADD(v_fecha_inicio, INTERVAL 1 MONTH);  -- Primer cuota al mes siguiente de la fecha de inicio

    -- Insertar una sola cuota en la tabla `cuotas_prestamos`
    INSERT INTO cuotas_prestamos (
        id_prestamo, 
        fecha_pago, 
        estado, 
        no_cuotas, 
        monto_mensual, 
        monto_pendiente
    ) 
    VALUES (
        p_id_prestamo,
        v_fecha_pago,   -- Fecha de pago
        'PENDIENTE',    -- Estado de la cuota
        p_numero_cuotas, -- Número total de cuotas
        v_monto_mensual, -- Monto mensual calculado
        v_monto_pendiente -- Monto pendiente (igual al monto base en la primera cuota)
    );

    -- Devolver los resultados calculados
    SELECT 
        p_id_prestamo AS id_prestamo,
        v_monto_base AS monto_base,
        v_interes_total AS interes_total,
        v_total_pagar AS total_a_pagar,
        v_monto_mensual AS monto_mensual,
        v_monto_pendiente AS monto_pendiente,
        v_fecha_pago AS fecha_pago;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `manejo_tarjeta_chequera` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `manejo_tarjeta_chequera`(
  IN p_monto DECIMAL(12,2),
  IN p_id_tarjeta VARCHAR(20),
  IN p_id_chequera INT
)
BEGIN
  DECLARE v_saldo_actual DECIMAL(12,2);
  DECLARE v_id_cuenta_monetaria VARCHAR(20);
  DECLARE v_id_cliente INT;
  DECLARE v_cliente_nombre VARCHAR(200);
  DECLARE v_numero_cheque VARCHAR(50);

  -- Obtener datos desde tarjeta
  IF p_id_tarjeta IS NOT NULL THEN
    SELECT t.no_cuenta_monetaria, t.id_cliente
    INTO v_id_cuenta_monetaria, v_id_cliente
    FROM tarjeta t
    WHERE t.id_tarjeta = p_id_tarjeta;

  -- Obtener datos desde chequera
  ELSEIF p_id_chequera IS NOT NULL THEN
    SELECT ch.id_cuenta_monetaria, ch.id_cliente, ch.cliente
    INTO v_id_cuenta_monetaria, v_id_cliente, v_cliente_nombre
    FROM chequera ch
    WHERE ch.id = p_id_chequera;

  ELSE
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Debe proporcionar una tarjeta o chequera válida';
  END IF;

  -- Verificar saldo
  SELECT saldo INTO v_saldo_actual
  FROM cuentas_monetarias
  WHERE id_cuenta_monetaria = v_id_cuenta_monetaria;

  IF v_saldo_actual < p_monto THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Saldo insuficiente en cuenta monetaria';
  END IF;

  -- Descontar saldo
  UPDATE cuentas_monetarias
  SET saldo = saldo - p_monto
  WHERE id_cuenta_monetaria = v_id_cuenta_monetaria;

  -- Generar número de cheque aleatorio (solo números)
  SET v_numero_cheque = CONCAT(FLOOR(RAND() * 1000000));

  -- Registrar en manejo_chequera
  IF p_id_chequera IS NOT NULL THEN
    INSERT INTO manejo_chequera (
      cliente,
      numero_cuenta_monetaria,
      fecha,
      numero_cheque,
      descripcion,
      debito
    ) VALUES (
      v_cliente_nombre,
      v_id_cuenta_monetaria,
      NOW(),
      v_numero_cheque,
      'Retiro mediante chequera',
      p_monto
    );
  END IF;

  -- Registrar en manejo_tarjeta
  IF p_id_tarjeta IS NOT NULL THEN
    -- Si ya existe un registro, lo actualizamos
    IF EXISTS (SELECT 1 FROM manejo_tarjeta WHERE id_tarjeta = p_id_tarjeta) THEN
      UPDATE manejo_tarjeta
      SET estado = 'RETIRO',
          monto = p_monto,
          clientes_id_clientes = v_id_cliente
      WHERE id_tarjeta = p_id_tarjeta;
    ELSE
      -- Si no existe, lo insertamos
      INSERT INTO manejo_tarjeta (
        id_tarjeta,
        estado,
        monto,
        clientes_id_clientes
      ) VALUES (
        p_id_tarjeta,
        'RETIRO',
        p_monto,
        v_id_cliente
      );
    END IF;
  END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pagar_prestamo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pagar_prestamo`(
    IN p_prestamo_id INT,
    IN p_cuota_id INT,
    IN p_monto_pago DECIMAL(12,2),
    IN p_usuario_registro INT
)
BEGIN
    DECLARE v_monto_pendiente DECIMAL(12,2);
    DECLARE v_nuevo_monto_pendiente DECIMAL(12,2);
    DECLARE v_estado_actual ENUM('PENDIENTE','PAGADO');
    DECLARE v_nuevo_estado ENUM('PENDIENTE','PAGADO');

    -- Obtener monto pendiente y estado actual de la cuota
    SELECT monto_pendiente, estado
    INTO v_monto_pendiente, v_estado_actual
    FROM cuotas_prestamos
    WHERE id_cuota = p_cuota_id AND id_prestamo = p_prestamo_id;

    -- Validar si la cuota ya está pagada
    IF v_estado_actual = 'PAGADO' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede registrar el pago. La cuota ya está pagada.';
    END IF;

    -- Validar que el monto a pagar no exceda el monto pendiente
    IF p_monto_pago > v_monto_pendiente THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El monto del pago excede el saldo pendiente de la cuota.';
    END IF;

    -- Calcular nuevo monto pendiente
    SET v_nuevo_monto_pendiente = v_monto_pendiente - p_monto_pago;

    -- Determinar nuevo estado
    IF v_nuevo_monto_pendiente <= 0 THEN
        SET v_nuevo_estado = 'PAGADO';
        SET v_nuevo_monto_pendiente = 0; -- Evita valores negativos
    ELSE
        SET v_nuevo_estado = 'PENDIENTE';
    END IF;

    -- Actualizar cuota
    UPDATE cuotas_prestamos
    SET 
        monto_pendiente = v_nuevo_monto_pendiente,
        estado = v_nuevo_estado
    WHERE id_cuota = p_cuota_id;

    -- Insertar el registro del pago
    INSERT INTO pago_prestamo (
        prestamo_id, 
        monto, 
        usuario_registro, 
        fecha, 
        id_estado, 
        cuota_id
    ) VALUES (
        p_prestamo_id, 
        p_monto_pago, 
        p_usuario_registro, 
        CURDATE(), 
        1, -- estado registrado
        p_cuota_id
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RegistrarPrestamo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `registrar_operacion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `registrar_operacion`(
  IN p_monto DECIMAL(12,2),
  IN p_id_cuenta_ahorro VARCHAR(20),
  IN p_id_cuenta_monetaria VARCHAR(20),
  IN p_operacion ENUM('DEPOSITO','RETIRO')
)
BEGIN
  DECLARE v_saldo_actual DECIMAL(12,2);

  -- Operación en cuenta de ahorro
  IF p_id_cuenta_ahorro IS NOT NULL THEN
    -- Obtener saldo actual
    SELECT monto INTO v_saldo_actual
    FROM cuentas_ahorro
    WHERE id_cuenta_ahorro = p_id_cuenta_ahorro;

    IF p_operacion = 'DEPOSITO' THEN
      -- Actualizar saldo
      UPDATE cuentas_ahorro
      SET monto = monto + p_monto
      WHERE id_cuenta_ahorro = p_id_cuenta_ahorro;

    ELSEIF p_operacion = 'RETIRO' THEN
      IF v_saldo_actual >= p_monto THEN
        UPDATE cuentas_ahorro
        SET monto = monto - p_monto
        WHERE id_cuenta_ahorro = p_id_cuenta_ahorro;
      ELSE
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Saldo insuficiente en cuenta de ahorro';
      END IF;
    END IF;

    -- Registrar operación
    INSERT INTO operaciones_bancarias (monto, id_cuenta_ahorro, operacion)
    VALUES (p_monto, p_id_cuenta_ahorro, p_operacion);

  -- Operación en cuenta monetaria
  ELSEIF p_id_cuenta_monetaria IS NOT NULL THEN
    -- Obtener saldo actual
    SELECT saldo INTO v_saldo_actual
    FROM cuentas_monetarias
    WHERE id_cuenta_monetaria = p_id_cuenta_monetaria;

    IF p_operacion = 'DEPOSITO' THEN
      UPDATE cuentas_monetarias
      SET saldo = saldo + p_monto
      WHERE id_cuenta_monetaria = p_id_cuenta_monetaria;

    ELSEIF p_operacion = 'RETIRO' THEN
      IF v_saldo_actual >= p_monto THEN
        UPDATE cuentas_monetarias
        SET saldo = saldo - p_monto
        WHERE id_cuenta_monetaria = p_id_cuenta_monetaria;
      ELSE
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Saldo insuficiente en cuenta monetaria';
      END IF;
    END IF;

    -- Registrar operación
    INSERT INTO operaciones_bancarias (monto, id_cuenta_monetaria, operacion)
    VALUES (p_monto, p_id_cuenta_monetaria, p_operacion);

  ELSE
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Debe especificarse una cuenta válida (ahorro o monetaria)';
  END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `registro_suarios` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `registro_suarios`(IN p_nombre VARCHAR(100), IN p_telefono VARCHAR(20), 
IN p_correo VARCHAR(100),IN p_nacimiento DATE, IN p_tipo VARCHAR(30),
IN p_estado VARCHAR(30), IN p_contrasena VARCHAR(300))
BEGIN

    IF EXISTS (SELECT 1 FROM cooperativa_db.usuarios WHERE correo_electronico = p_correo) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El correo electrónico ya está registrado.';
    END IF;

	INSERT INTO cooperativa_db.usuarios(nombre, telefono, correo_electronico, fecha_nacimiento, tipo_usuario, estado, contrasena)
    VALUES(p_nombre, p_telefono, p_correo, p_nacimiento, p_tipo, p_estado, sha1(p_contrasena));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `detallepagosprestamos`
--

/*!50001 DROP VIEW IF EXISTS `detallepagosprestamos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `detallepagosprestamos` AS select `p`.`id_prestamo` AS `id_prestamo`,`c`.`id_clientes` AS `id_clientes`,`p`.`monto` AS `monto_prestamo`,`p`.`intereses` AS `intereses`,`p`.`saldo_pendiente` AS `saldo_pendiente`,`pp`.`monto` AS `monto_pagado`,`pp`.`fecha` AS `fecha_pago_realizado`,`cp`.`id_cuota` AS `id_cuota`,`cp`.`monto_mensual` AS `monto_cuota`,`cp`.`fecha_pago` AS `fecha_pago_programado`,`cp`.`estado` AS `estado_cuota`,(case when (`p`.`saldo_pendiente` = 0) then 'Pagado' else 'Pendiente' end) AS `estado_prestamo` from (((`prestamos` `p` join `pago_prestamo` `pp` on((`p`.`id_prestamo` = `pp`.`prestamo_id`))) join `cuotas_prestamos` `cp` on((`p`.`id_prestamo` = `cp`.`id_prestamo`))) join `clientes` `c` on((`p`.`id_cliente` = `c`.`id_clientes`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vistaclientescuentas`
--

/*!50001 DROP VIEW IF EXISTS `vistaclientescuentas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vistaclientescuentas` AS select `c`.`id_clientes` AS `id_clientes`,`ca`.`id_cuenta_aporte` AS `cuenta_aportes`,(select coalesce(sum(`manejo_aportes`.`monto`),0) from `manejo_aportes` where (`manejo_aportes`.`id_cuenta_aporte` = `ca`.`id_cuenta_aporte`)) AS `monto_aportes`,`sa`.`id_cuenta_ahorro` AS `cuenta_ahorro`,`sa`.`monto` AS `monto_ahorro`,`cm`.`id_cuenta_monetaria` AS `cuenta_monetaria`,`cm`.`saldo` AS `monto_monetaria` from (((`clientes` `c` left join `cuentas_aportes` `ca` on((`c`.`id_clientes` = `ca`.`id_clientes`))) left join `cuentas_ahorro` `sa` on((`c`.`id_clientes` = `sa`.`id_clientes`))) left join `cuentas_monetarias` `cm` on((`c`.`id_clientes` = `cm`.`id_cliente`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vistamovbancarios`
--

/*!50001 DROP VIEW IF EXISTS `vistamovbancarios`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vistamovbancarios` AS select `c`.`id_clientes` AS `id_clientes`,`ca`.`id_cuenta_aporte` AS `cuenta_aportes`,(select coalesce(sum(`manejo_aportes`.`monto`),0) from `manejo_aportes` where (`manejo_aportes`.`id_cuenta_aporte` = `ca`.`id_cuenta_aporte`)) AS `monto_aportes`,`sa`.`id_cuenta_ahorro` AS `cuenta_ahorro`,`sa`.`monto` AS `monto_ahorro`,`cm`.`id_cuenta_monetaria` AS `cuenta_monetaria`,`cm`.`saldo` AS `monto_monetaria` from (((`clientes` `c` left join `cuentas_aportes` `ca` on((`c`.`id_clientes` = `ca`.`id_clientes`))) left join `cuentas_ahorro` `sa` on((`c`.`id_clientes` = `sa`.`id_clientes`))) left join `cuentas_monetarias` `cm` on((`c`.`id_clientes` = `cm`.`id_cliente`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-30 22:54:16
