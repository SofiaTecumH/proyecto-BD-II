SHOW CREATE TRIGGER tgBefore_AsignarBloqueoAportes;
SHOW CREATE TRIGGER ActualizarSaldoAportes;
SHOW CREATE TRIGGER BloquearRetirosAntesDe6Meses;

 -- --------------------------------------------------------------------------------------------------
 -- TRIGGER QUE DEFINE LA FECHA DE BLOQUEO DE LA CUENTA APORTES DESDE SU CREACION
  -- --------------------------------------------------------------------------------------------------
  
CREATE TRIGGER `tgBefore_AsignarBloqueoAportes` BEFORE INSERT ON `cuentas_aportes` FOR EACH ROW BEGIN
     SET NEW.bloqueo_hasta = DATE_ADD(NEW.fecha_creacion, INTERVAL 6 MONTH);
 END
 
  -- --------------------------------------------------------------------------------------------------
  -- TRIGGER QUE ACTUALIZA EL SALDO. Define un monto que no puede retirarse (minimo de aporte). El monto es lo que se maneja por transaccion
  -- el saldo es el total en la cuenta
   -- --------------------------------------------------------------------------------------------------
   CREATE TRIGGER `ActualizarSaldoAportes` BEFORE INSERT ON `manejo_aportes` FOR EACH ROW BEGIN
     DECLARE saldo_acumulado DECIMAL(12,2);
     DECLARE monto_minimo DECIMAL(12,2);
 
     -- Definir monto mínimo de aportación
     SET monto_minimo = 100.00;
 
     -- Obtener el saldo acumulado desde manejo_aportes
     SELECT COALESCE(SUM(monto), 0) INTO saldo_acumulado
     FROM manejo_aportes
     WHERE id_cuenta_aporte = NEW.id_cuenta_aporte;
 
     -- Si es el primer movimiento, incluir el monto de apertura como saldo inicial
     IF saldo_acumulado = 0 THEN
         SET saldo_acumulado = (SELECT monto_apertura FROM cuentas_aportes WHERE id_cuenta_aporte = NEW.id_cuenta_aporte);
     END IF;
 
     -- Validar el tipo de movimiento
     IF NEW.tipo_operacion = 'DEPOSITO' THEN
         SET NEW.saldo = saldo_acumulado + NEW.monto;
     ELSEIF NEW.tipo_operacion = 'RETIRO' AND (saldo_acumulado - NEW.monto >= monto_minimo) THEN
         SET NEW.saldo = saldo_acumulado - NEW.monto;
     ELSEIF NEW.tipo_operacion = 'RETIRO' AND (saldo_acumulado - NEW.monto < monto_minimo) THEN
         SIGNAL SQLSTATE '45000'
         SET MESSAGE_TEXT = 'Error: No puede retirar este monto porque reduciría el saldo por debajo del mínimo permitido (Q100).';
     ELSE
         SET NEW.saldo = saldo_acumulado + NEW.monto; -- Para intereses
     END IF;
 END
 
  -- --------------------------------------------------------------------------------------------------
  -- TRIGGER QUE BLOQUEA LOS RETIROS ANTES DE LOS 6 MESES
   -- --------------------------------------------------------------------------------------------------
   
   CREATE TRIGGER `BloquearRetirosAntesDe6Meses` BEFORE INSERT ON `manejo_aportes` FOR EACH ROW BEGIN
     DECLARE fecha_bloqueo DATE;
 
     -- Obtener la fecha de desbloqueo desde cuentas_aportes
     SELECT bloqueo_hasta INTO fecha_bloqueo
     FROM cuentas_aportes
     WHERE id_cuenta_aporte = NEW.id_cuenta_aporte;
 
     -- Bloquear el retiro si aún estamos dentro del período de 6 meses
     IF NEW.tipo_operacion = 'RETIRO' AND NOW() < fecha_bloqueo THEN
         SIGNAL SQLSTATE '45000'
         SET MESSAGE_TEXT = 'Error: No puedes retirar fondos de aportaciones antes de los 6 meses.';
     END IF;
 END