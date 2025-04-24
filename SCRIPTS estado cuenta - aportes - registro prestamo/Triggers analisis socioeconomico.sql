 -- --------------------------------------------------------------------------------------------------
-- 1.  TABLA referencias_personales. Valida si una referencia es válida o no
 -- --------------------------------------------------------------------------------------------------

CREATE TRIGGER `ValidarReferenciasPersonales` BEFORE INSERT ON `referencias_personales` FOR EACH ROW BEGIN
     -- Evaluar el criterio y asignar el estado correspondiente
     IF NEW.criterio = 'FAVORABLE' THEN
         SET NEW.estado = 'APROBADO';
     ELSEIF NEW.criterio = 'NO_FAVORABLE' THEN
         SET NEW.estado = 'RECHAZADO';
     ELSEIF NEW.criterio = 'POR EVALUAR' THEN
         SET NEW.estado = 'APROBADO';
     END IF;
 END
 
 -- --------------------------------------------------------------------------------------------------
 -- 2. TRIGGER BIENES INMUEBLES. Solicita al menos un bien inmueble dado los prestamos hipotecarios
 -- --------------------------------------------------------------------------------------------------
 
 CREATE TRIGGER `ValidarBienesInmueblesTrigger` BEFORE INSERT ON `bienes_inmuebles` FOR EACH ROW BEGIN
     IF NEW.valor >= 30000 THEN
         SET NEW.estado = 'APROBADO';
     ELSE
         SET NEW.estado = 'RECHAZADO';
     END IF;
 END
 
  -- --------------------------------------------------------------------------------------------------
 -- 3. TRIGGER OCUPACIÓN. Valida que el cliente tenga al menos un año de estabilidad laboral 
  -- --------------------------------------------------------------------------------------------------
 
 CREATE TRIGGER `ValidarOcupacion` BEFORE INSERT ON `ocupacion` FOR EACH ROW BEGIN
     -- Calcular antigüedad en meses usando TIMESTAMPDIFF
     DECLARE antiguedad_meses INT;
     SET antiguedad_meses = TIMESTAMPDIFF(MONTH, NEW.fecha_inicio_labores, CURRENT_DATE);
 
     -- Validar si cumple con el requisito de antigüedad mínima (12 meses)
     IF antiguedad_meses >= 12 THEN
         SET NEW.estado = 'APROBADO';
     ELSE
         SET NEW.estado = 'RECHAZADO';
     END IF;
 END
 
  -- --------------------------------------------------------------------------------------------------
 -- 4. TRIGGER INGRESOS FAMILIARES. Valida el promedio mensual, al menos debe ser de 1 salario mínimo mensual
  -- --------------------------------------------------------------------------------------------------
 
 CREATE TRIGGER `ValidarIngresosFamiliares` BEFORE INSERT ON `ingresos_familiares` FOR EACH ROW BEGIN
     -- Validar si el promedio mensual cumple con el mínimo requerido (3500)
 -- (al menos, un salario mínimo, cuenta el del solicitante)
     IF NEW.promedio_mensual >= 3500 THEN
         SET NEW.estado = 'APROBADO';
     ELSE
         SET NEW.estado = 'RECHAZADO';
     END IF;
 END
 
  -- --------------------------------------------------------------------------------------------------
 -- 5. OTROS INGRESOS. Tabla no obligatoria ya que en cuanto a analisis economico la estabilidad laboral es mas relevante, aprobará todos los ingresos 
  -- --------------------------------------------------------------------------------------------------
 
 CREATE DEFINER=`root`@`localhost` TRIGGER `ValidarOtrosIngresos` BEFORE INSERT ON `otros_ingresos` FOR EACH ROW BEGIN
     IF NEW.monto_promedio_mensual >= 0 THEN
         SET NEW.estado = 'APROBADO';
     ELSE
         SET NEW.estado = 'RECHAZADO';
     END IF;
 END
 
  -- --------------------------------------------------------------------------------------------------
 -- 6. VEHICULOS. No obligatorio, ya que el mismo prestamo puede usarse para adquirir uno
  -- --------------------------------------------------------------------------------------------------
 
CREATE TRIGGER `ValidarCantidadVehiculos` BEFORE INSERT ON `vehiculos` FOR EACH ROW BEGIN
     IF NEW.cantidad_vehiculos >= 0 THEN
         SET NEW.estado = 'APROBADO';
     ELSE
         SET NEW.estado = 'RECHAZADO';
     END IF;
 END
 
  -- --------------------------------------------------------------------------------------------------
 -- 7. HISTORIAL CREDITICIO. Si un prestamo es incumplido se rechaza la solicitud, de igual manera si la puntualidad es de menos del 90%
 -- se rechaza la solicitud. Si no se tiene historial unicamente setea "Sin historial"
  -- --------------------------------------------------------------------------------------------------
 
 CREATE TRIGGER `ValidarHistorialCrediticio` BEFORE INSERT ON `historial_crediticio` FOR EACH ROW BEGIN
     -- Verificar si no existe historial previo para la solicitud
     IF NOT EXISTS (
         SELECT 1 FROM historial_crediticio WHERE id_solicitud = NEW.id_solicitud
     ) THEN
         SET NEW.estado = 'SIN HISTORIAL';
     END IF;
 
     -- Verificar si el registro tiene estatus 'INCUMPLIDO'
     IF NEW.estatus = 'INCUMPLIDO' THEN
         SET NEW.estado = 'RECHAZADO';
     END IF;
 
     -- Verificar si la puntualidad mínima requerida no se cumple
     IF NEW.estatus IN ('PENDIENTE', 'PAGADO') AND NEW.puntualidad_pagos < 90 THEN
         SET NEW.estado = 'RECHAZADO';
     END IF;
 
     -- Si cumple con todas las validaciones
     IF NEW.puntualidad_pagos >= 90 THEN
         SET NEW.estado = 'APROBADO';
     END IF;
 END