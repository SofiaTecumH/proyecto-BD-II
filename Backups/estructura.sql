
-- Table structure for table `auditoria`

DROP TABLE IF EXISTS `auditoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auditoria` (
  `id_auditoria` int NOT NULL AUTO_INCREMENT,
  `usuario_responsable` int DEFAULT NULL,
  `tabla_afectada` varchar(50) DEFAULT NULL,
  `operacion` enum('INSERT','UPDATE','DELETE') DEFAULT NULL,
  `id_registro_afectado` int DEFAULT NULL,
  `fecha_operacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `detalles` text,
  PRIMARY KEY (`id_auditoria`),
  KEY `usuario_responsable` (`usuario_responsable`),
  CONSTRAINT `auditoria_ibfk_1` FOREIGN KEY (`usuario_responsable`) REFERENCES `usuarios` (`id_usuario`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

-- Table structure for table `bienes_inmuebles`

DROP TABLE IF EXISTS `bienes_inmuebles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bienes_inmuebles` (
  `id_bien` int NOT NULL AUTO_INCREMENT,
  `tipo` varchar(50) NOT NULL,
  `valor` decimal(12,2) DEFAULT '0.00',
  `ubicacion` varchar(200) NOT NULL,
  `estado` enum('APROBADO','RECHAZADO') DEFAULT NULL,
  `id_solicitud` int NOT NULL,
  PRIMARY KEY (`id_bien`),
  KEY `fk_bienes_inmuebles_solicitud_credito1` (`id_solicitud`),
  CONSTRAINT `fk_bienes_inmuebles_solicitud_credito1` FOREIGN KEY (`id_solicitud`) REFERENCES `solicitud_credito` (`id_solicitud`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

-- Table structure for table `bitacora`

DROP TABLE IF EXISTS `bitacora`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bitacora` (
  `id_bitacora` int NOT NULL AUTO_INCREMENT,
  `accion` varchar(255) NOT NULL,
  `tabla_afectada` varchar(50) NOT NULL,
  `tipo_accion` enum('INSERT','UPDATE','DELETE') NOT NULL,
  `fecha` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `detalles` text,
  PRIMARY KEY (`id_bitacora`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

-- Table structure for table `catalogo_clientes`

DROP TABLE IF EXISTS `catalogo_clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalogo_clientes` (
  `id_clientes` varchar(20) NOT NULL,
  `tipo_cliente` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

-- Table structure for table `catalogo_estado`

DROP TABLE IF EXISTS `catalogo_estado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalogo_estado` (
  `id_estado` int NOT NULL AUTO_INCREMENT,
  `estado` varchar(50) NOT NULL,
  PRIMARY KEY (`id_estado`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

-- Table structure for table `catalogo_estado_prestamo`

DROP TABLE IF EXISTS `catalogo_estado_prestamo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalogo_estado_prestamo` (
  `id_estado_prestamo` int NOT NULL AUTO_INCREMENT,
  `estado_prestamo` varchar(50) NOT NULL,
  PRIMARY KEY (`id_estado_prestamo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

-- Table structure for table `catalogo_tipo_operacion`

DROP TABLE IF EXISTS `catalogo_tipo_operacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalogo_tipo_operacion` (
  `id_tipo_operacion` int NOT NULL AUTO_INCREMENT,
  `tipo_operacion` varchar(50) NOT NULL,
  PRIMARY KEY (`id_tipo_operacion`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

-- Table structure for table `catalogo_tipo_usuario`

DROP TABLE IF EXISTS `catalogo_tipo_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalogo_tipo_usuario` (
  `id_tipo_usuario` int NOT NULL AUTO_INCREMENT,
  `tipo_usuario` varchar(50) NOT NULL,
  PRIMARY KEY (`id_tipo_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

-- Table structure for table `catalogoconceptos`

DROP TABLE IF EXISTS `catalogoconceptos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalogoconceptos` (
  `IDConcepto` int NOT NULL AUTO_INCREMENT,
  `Descripcion` varchar(50) NOT NULL,
  `TipoConcepto` varchar(20) NOT NULL,
  `prestamos_id_prestamo` int NOT NULL,
  PRIMARY KEY (`IDConcepto`),
  KEY `fk_catalogoconceptos_prestamos1_idx` (`prestamos_id_prestamo`),
  CONSTRAINT `fk_catalogoconceptos_prestamos1` FOREIGN KEY (`prestamos_id_prestamo`) REFERENCES `prestamos` (`id_prestamo`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

-- Table structure for table `chequera`

DROP TABLE IF EXISTS `chequera`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chequera` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int NOT NULL,
  `cliente` varchar(200) NOT NULL,
  `id_cuenta_monetaria` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_chequera_cuenta_monetaria` (`id_cuenta_monetaria`),
  CONSTRAINT `fk_chequera_cuenta_monetaria` FOREIGN KEY (`id_cuenta_monetaria`) REFERENCES `cuentas_monetarias` (`id_cuenta_monetaria`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

-- Table structure for table `clientes`

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clientes` (
  `id_clientes` int NOT NULL AUTO_INCREMENT,
  `estado` enum('ACTIVO','INACTIVO') DEFAULT 'ACTIVO',
  `id_cliente_individual` int DEFAULT NULL,
  `id_cliente_juridico` int DEFAULT NULL,
  `id_socio` int DEFAULT NULL,
  PRIMARY KEY (`id_clientes`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clientes_individuales`
--

DROP TABLE IF EXISTS `clientes_individuales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clientes_individuales` (
  `id_cliente_individual` int NOT NULL AUTO_INCREMENT,
  `dpi` varchar(20) NOT NULL,
  `primer_nombre` varchar(200) NOT NULL,
  `segundo_nombre` varchar(200) DEFAULT NULL,
  `otros_nombres` varchar(200) DEFAULT NULL,
  `primer_apellido` varchar(250) NOT NULL,
  `segundo_apellido` varchar(250) DEFAULT NULL,
  `otros_apellidos` varchar(250) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `estado_civil` enum('CASADO','SOLTERO') DEFAULT NULL,
  `clientes_id_clientes` int NOT NULL,
  `departamento` varchar(300) NOT NULL,
  `municipio` varchar(300) NOT NULL,
  `zona` varchar(300) NOT NULL,
  `grupo_habitacional` varchar(300) NOT NULL,
  `vialidad` varchar(300) NOT NULL,
  `numero_casa` varchar(300) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `correo_electronico` varchar(100) DEFAULT NULL,
  `estado` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_cliente_individual`,`clientes_id_clientes`),
  KEY `fk_clientes_individuales_clientes1_idx` (`clientes_id_clientes`),
  CONSTRAINT `fk_clientes_individuales_clientes1` FOREIGN KEY (`clientes_id_clientes`) REFERENCES `clientes` (`id_clientes`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clientesjuridicos`
--

DROP TABLE IF EXISTS `clientesjuridicos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clientesjuridicos` (
  `id_ClienteJuridico` int NOT NULL AUTO_INCREMENT,
  `nombre_comercial` varchar(255) NOT NULL,
  `razon_social` varchar(255) DEFAULT NULL,
  `NIT` varchar(13) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `mail` varchar(100) DEFAULT NULL,
  `fecha_constitucion` datetime DEFAULT CURRENT_TIMESTAMP,
  `representante_legal` varchar(255) DEFAULT NULL,
  `tipo_institucion` varchar(100) DEFAULT NULL,
  `departamento` varchar(300) NOT NULL,
  `municipio` varchar(300) NOT NULL,
  `zona` varchar(300) NOT NULL,
  `grupo_habitacional` varchar(300) DEFAULT NULL,
  `vialidad` varchar(300) DEFAULT NULL,
  `numero_casa` varchar(300) DEFAULT NULL,
  `estado` varchar(45) DEFAULT NULL,
  `id_usuarios_cuenta_juridica` int NOT NULL,
  PRIMARY KEY (`id_ClienteJuridico`),
  KEY `fk_usuarios_cuenta` (`id_usuarios_cuenta_juridica`),
  CONSTRAINT `fk_usuarios_cuenta` FOREIGN KEY (`id_usuarios_cuenta_juridica`) REFERENCES `usuarios_cuenta_juridica` (`id_usuarios_cuenta_juridica`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cuentas_ahorro`
--

DROP TABLE IF EXISTS `cuentas_ahorro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cuentas_ahorro` (
  `tasa_interes` decimal(12,2) DEFAULT '4.00',
  `fecha_apertura` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `monto` decimal(12,2) DEFAULT '0.00',
  `id_clientes` varchar(20) NOT NULL,
  `id_cuenta_ahorro` varchar(20) NOT NULL,
  PRIMARY KEY (`id_cuenta_ahorro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cuentas_aportes`
--

DROP TABLE IF EXISTS `cuentas_aportes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cuentas_aportes` (
  `monto_aportacion` decimal(12,2) DEFAULT NULL,
  `monto_apertura` decimal(12,2) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `id_clientes` int NOT NULL,
  `id_cuenta_aporte` varchar(20) NOT NULL,
  `bloqueo_hasta` date DEFAULT NULL,
  PRIMARY KEY (`id_cuenta_aporte`),
  KEY `fk_cliente_aporte` (`id_clientes`),
  CONSTRAINT `fk_cliente_aporte` FOREIGN KEY (`id_clientes`) REFERENCES `clientes` (`id_clientes`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cuentas_monetarias`
--

DROP TABLE IF EXISTS `cuentas_monetarias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cuentas_monetarias` (
  `saldo` decimal(12,2) DEFAULT '0.00',
  `fecha_creacion` datetime NOT NULL,
  `id_cliente` int NOT NULL,
  `id_cuenta_monetaria` varchar(20) NOT NULL,
  PRIMARY KEY (`id_cuenta_monetaria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cuotas_prestamos`
--

DROP TABLE IF EXISTS `cuotas_prestamos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cuotas_prestamos` (
  `id_cuota` int NOT NULL AUTO_INCREMENT,
  `id_prestamo` int DEFAULT NULL,
  `monto_mensual` decimal(12,2) DEFAULT NULL,
  `fecha_pago` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `estado` enum('PENDIENTE','PAGADO') DEFAULT 'PENDIENTE',
  `monto_pendiente` decimal(12,2) DEFAULT NULL,
  `no_cuotas` int DEFAULT NULL,
  PRIMARY KEY (`id_cuota`),
  KEY `id_prestamo` (`id_prestamo`),
  CONSTRAINT `cuotas_prestamos_ibfk_1` FOREIGN KEY (`id_prestamo`) REFERENCES `prestamos` (`id_prestamo`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `detallepagosprestamos`
--

DROP TABLE IF EXISTS `detallepagosprestamos`;
/*!50001 DROP VIEW IF EXISTS `detallepagosprestamos`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `detallepagosprestamos` AS SELECT
 1 AS `id_prestamo`,
  1 AS `id_clientes`,
  1 AS `monto_prestamo`,
  1 AS `intereses`,
  1 AS `saldo_pendiente`,
  1 AS `monto_pagado`,
  1 AS `fecha_pago_realizado`,
  1 AS `id_cuota`,
  1 AS `monto_cuota`,
  1 AS `fecha_pago_programado`,
  1 AS `estado_cuota`,
  1 AS `estado_prestamo` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `documentosclientes`
--

DROP TABLE IF EXISTS `documentosclientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documentosclientes` (
  `IDDocumento` int NOT NULL AUTO_INCREMENT,
  `URLDocumento` varchar(255) NOT NULL,
  `TipoDocumento` varchar(50) NOT NULL,
  `FechaSubida` datetime DEFAULT CURRENT_TIMESTAMP,
  `clientes_id_clientes` int NOT NULL,
  PRIMARY KEY (`IDDocumento`),
  KEY `fk_documentosclientes_clientes1_idx` (`clientes_id_clientes`),
  CONSTRAINT `fk_documentosclientes_clientes1` FOREIGN KEY (`clientes_id_clientes`) REFERENCES `clientes` (`id_clientes`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `empleados`
--

DROP TABLE IF EXISTS `empleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `empleados` (
  `id_empleados` int NOT NULL AUTO_INCREMENT,
  `primer_nombre` varchar(200) NOT NULL,
  `segundo_nombre` varchar(200) DEFAULT NULL,
  `otros_nombres` varchar(200) DEFAULT NULL,
  `primer_apellido` varchar(250) NOT NULL,
  `segundo_apellido` varchar(250) DEFAULT NULL,
  `otros_apellidos` varchar(250) DEFAULT NULL,
  `departamento` varchar(300) NOT NULL,
  `municipio` varchar(300) NOT NULL,
  `zona` varchar(300) NOT NULL,
  `grupo_habitacional` varchar(300) NOT NULL,
  `vialidad` varchar(300) NOT NULL,
  `numero_casa` varchar(300) NOT NULL,
  `prefijo` varchar(10) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `correo_electronico` varchar(100) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `estado` enum('ACTIVO','INACTIVO') DEFAULT 'ACTIVO',
  `puesto` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_empleados`),
  UNIQUE KEY `correo_electronico` (`correo_electronico`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fiador`
--

DROP TABLE IF EXISTS `fiador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fiador` (
  `id_fiador` int NOT NULL AUTO_INCREMENT,
  `cliente_id_cliente` int DEFAULT NULL,
  `parentesco` varchar(50) NOT NULL,
  `prestamo_id_prestamo` int NOT NULL,
  `fecha_registro` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_fiador`),
  KEY `cliente_id_cliente` (`cliente_id_cliente`),
  CONSTRAINT `fiador_ibfk_1` FOREIGN KEY (`cliente_id_cliente`) REFERENCES `clientes` (`id_clientes`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `historial_crediticio`
--

DROP TABLE IF EXISTS `historial_crediticio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `historial_crediticio` (
  `id_historial` int NOT NULL AUTO_INCREMENT,
  `tipo_credito` varchar(50) NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `estatus` enum('PENDIENTE','PAGADO','INCUMPLIDO') DEFAULT NULL,
  `estado` enum('APROBADO','RECHAZADO') DEFAULT NULL,
  `historial_cliente` enum('SIN_HISTORIAL','CON_HISTORIAL') DEFAULT NULL,
  `puntualidad_pagos` decimal(5,2) DEFAULT '0.00',
  `observaciones` text,
  `id_solicitud` int NOT NULL,
  PRIMARY KEY (`id_historial`),
  KEY `fk_bienes_inmuebles_solicitud_credito` (`id_solicitud`),
  CONSTRAINT `fk_bienes_inmuebles_solicitud_credito` FOREIGN KEY (`id_solicitud`) REFERENCES `solicitud_credito` (`id_solicitud`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `historial_movimientos`
--

DROP TABLE IF EXISTS `historial_movimientos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `historial_movimientos` (
  `id_movimiento` int NOT NULL AUTO_INCREMENT,
  `id_cuenta_ahorro` int DEFAULT NULL,
  `id_cuenta_monetaria` int DEFAULT NULL,
  `id_prestamo` int DEFAULT NULL,
  `tipo_movimiento` enum('DEPOSITO','RETIRO') DEFAULT NULL,
  `monto` decimal(12,2) DEFAULT NULL,
  `fecha` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `descripcion` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_movimiento`),
  KEY `id_cuenta_ahorro` (`id_cuenta_ahorro`),
  KEY `id_cuenta_monetaria` (`id_cuenta_monetaria`),
  KEY `id_prestamo` (`id_prestamo`),
  CONSTRAINT `historial_movimientos_ibfk_4` FOREIGN KEY (`id_prestamo`) REFERENCES `prestamos` (`id_prestamo`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `imagenescheques`
--

DROP TABLE IF EXISTS `imagenescheques`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imagenescheques` (
  `Id_cheque` int NOT NULL AUTO_INCREMENT,
  `url_cheque` varchar(255) NOT NULL,
  `num_cheque` varchar(50) NOT NULL,
  `FechaSubida` datetime DEFAULT CURRENT_TIMESTAMP,
  `chequera_id` int NOT NULL,
  PRIMARY KEY (`Id_cheque`),
  KEY `fk_imagenescheques_chequera1_idx` (`chequera_id`),
  CONSTRAINT `fk_imagenescheques_chequera1` FOREIGN KEY (`chequera_id`) REFERENCES `chequera` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ingresos_familiares`
--

DROP TABLE IF EXISTS `ingresos_familiares`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ingresos_familiares` (
  `id_ingreso` int NOT NULL AUTO_INCREMENT,
  `tipo_ingreso` varchar(50) NOT NULL,
  `cantidad_familiares` int DEFAULT NULL,
  `parentesco` varchar(20) DEFAULT NULL,
  `promedio_mensual` decimal(12,2) DEFAULT '0.00',
  `estado` enum('APROBADO','RECHAZADO') DEFAULT NULL,
  `id_solicitud` int NOT NULL,
  PRIMARY KEY (`id_ingreso`),
  KEY `fk_ingresos_familiares_solicitud_credito` (`id_solicitud`),
  CONSTRAINT `fk_ingresos_familiares_solicitud_credito` FOREIGN KEY (`id_solicitud`) REFERENCES `solicitud_credito` (`id_solicitud`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `intereses_prestamos`
--

DROP TABLE IF EXISTS `intereses_prestamos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `intereses_prestamos` (
  `id_intereses_prestamo` int NOT NULL,
  `fiduciario12_c` decimal(10,2) DEFAULT '0.00',
  `fiduciario18_c` decimal(10,2) DEFAULT '0.00',
  `fiduciario24_c` decimal(10,2) DEFAULT '0.00',
  `hipotecario12_c` decimal(10,2) DEFAULT '0.00',
  `hipotecario18_c` decimal(10,2) DEFAULT '0.00',
  `hipotecario24_c` decimal(10,2) DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `manejo_aportes`
--

DROP TABLE IF EXISTS `manejo_aportes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manejo_aportes` (
  `id_manejo_aporte` int NOT NULL AUTO_INCREMENT,
  `id_cuenta_aporte` varchar(20) NOT NULL,
  `fecha_operacion` datetime DEFAULT NULL,
  `concepto` varchar(50) DEFAULT NULL,
  `saldo` decimal(12,2) NOT NULL DEFAULT '0.00',
  `monto` decimal(12,2) NOT NULL,
  `tipo_operacion` enum('DEPOSITO','RETIRO','INTERESES') DEFAULT NULL,
  PRIMARY KEY (`id_manejo_aporte`),
  KEY `fk_manejo_cuenta` (`id_cuenta_aporte`),
  CONSTRAINT `fk_manejo_cuenta` FOREIGN KEY (`id_cuenta_aporte`) REFERENCES `cuentas_aportes` (`id_cuenta_aporte`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `manejo_chequera`
--

DROP TABLE IF EXISTS `manejo_chequera`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manejo_chequera` (
  `id_chequera` int NOT NULL AUTO_INCREMENT,
  `cliente` varchar(200) NOT NULL,
  `numero_cuenta_monetaria` varchar(20) NOT NULL,
  `fecha` datetime NOT NULL,
  `numero_cheque` varchar(50) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `debito` decimal(10,2) DEFAULT '0.00',
  PRIMARY KEY (`id_chequera`),
  CONSTRAINT `fk_manejo_chequera_chequera` FOREIGN KEY (`id_chequera`) REFERENCES `chequera` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `manejo_tarjeta`
--

DROP TABLE IF EXISTS `manejo_tarjeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manejo_tarjeta` (
  `id_tarjeta` varchar(20) NOT NULL,
  `estado` varchar(20) NOT NULL,
  `monto` decimal(10,2) DEFAULT NULL,
  `clientes_id_clientes` int NOT NULL,
  PRIMARY KEY (`id_tarjeta`),
  KEY `fk_manejo_tarjeta_clientes1_idx` (`clientes_id_clientes`),
  CONSTRAINT `fk_manejo_tarjeta_clientes1` FOREIGN KEY (`clientes_id_clientes`) REFERENCES `clientes` (`id_clientes`),
  CONSTRAINT `fk_manejo_tarjeta_tarjeta` FOREIGN KEY (`id_tarjeta`) REFERENCES `tarjeta` (`id_tarjeta`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ocupacion`
--

DROP TABLE IF EXISTS `ocupacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ocupacion` (
  `id_empleo` int NOT NULL AUTO_INCREMENT,
  `empresa` varchar(100) NOT NULL,
  `puesto` varchar(50) NOT NULL,
  `fecha_inicio_labores` date DEFAULT NULL,
  `ingresos_base` decimal(12,2) DEFAULT '0.00',
  `estado` enum('APROBADO','RECHAZADO') DEFAULT NULL,
  `id_solicitud` int NOT NULL,
  PRIMARY KEY (`id_empleo`),
  KEY `fk_ocupacion_solicitud_credito` (`id_solicitud`),
  CONSTRAINT `fk_ocupacion_solicitud_credito` FOREIGN KEY (`id_solicitud`) REFERENCES `solicitud_credito` (`id_solicitud`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `operaciones_bancarias`
--

DROP TABLE IF EXISTS `operaciones_bancarias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `operaciones_bancarias` (
  `id_operacion` int NOT NULL AUTO_INCREMENT,
  `monto` decimal(12,2) DEFAULT NULL,
  `fecha` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `id_cuenta_ahorro` varchar(20) DEFAULT NULL,
  `id_cuenta_monetaria` varchar(20) DEFAULT NULL,
  `operacion` enum('DEPOSITO','RETIRO') DEFAULT NULL,
  PRIMARY KEY (`id_operacion`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `otros_ingresos`
--

DROP TABLE IF EXISTS `otros_ingresos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `otros_ingresos` (
  `id_otro_ingreso` int NOT NULL AUTO_INCREMENT,
  `frecuencia` varchar(50) NOT NULL,
  `tipo_ingreso` varchar(100) NOT NULL,
  `monto_promedio_mensual` decimal(12,2) DEFAULT '0.00',
  `estado` enum('APROBADO','RECHAZADO') DEFAULT NULL,
  `id_solicitud` int NOT NULL,
  PRIMARY KEY (`id_otro_ingreso`),
  KEY `fk_otros_ingresos_solicitud_credito` (`id_solicitud`),
  CONSTRAINT `fk_otros_ingresos_solicitud_credito` FOREIGN KEY (`id_solicitud`) REFERENCES `solicitud_credito` (`id_solicitud`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pago_prestamo`
--

DROP TABLE IF EXISTS `pago_prestamo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pago_prestamo` (
  `id_pago_prestamo` int NOT NULL AUTO_INCREMENT,
  `prestamo_id` int NOT NULL,
  `monto` decimal(12,2) DEFAULT '0.00',
  `usuario_registro` int NOT NULL,
  `fecha` date DEFAULT NULL,
  `id_estado` int NOT NULL,
  `cuota_id` int DEFAULT NULL,
  PRIMARY KEY (`id_pago_prestamo`),
  KEY `id_estado` (`id_estado`),
  KEY `fk_cuota_id` (`cuota_id`),
  CONSTRAINT `fk_cuota_id` FOREIGN KEY (`cuota_id`) REFERENCES `cuotas_prestamos` (`id_cuota`) ON DELETE CASCADE,
  CONSTRAINT `pago_prestamo_ibfk_1` FOREIGN KEY (`id_estado`) REFERENCES `catalogo_estado_prestamo` (`id_estado_prestamo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pagos_intereses`
--

DROP TABLE IF EXISTS `pagos_intereses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pagos_intereses` (
  `id_pago_interes` int NOT NULL AUTO_INCREMENT,
  `id_cuenta_ahorro` int DEFAULT NULL,
  `monto_interes` decimal(12,2) DEFAULT NULL,
  `fecha_pago` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_pago_interes`),
  KEY `id_cuenta_ahorro` (`id_cuenta_ahorro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `porcentajes_intereses`
--

DROP TABLE IF EXISTS `porcentajes_intereses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `porcentajes_intereses` (
  `id_interes` int NOT NULL AUTO_INCREMENT,
  `tipo_cuenta` varchar(50) NOT NULL,
  `porcentaje` decimal(5,2) NOT NULL,
  `fecha_vigencia` date NOT NULL,
  `cuentas_ahorro_id_cuenta_ahorro` int NOT NULL,
  PRIMARY KEY (`id_interes`),
  KEY `fk_porcentajes_intereses_cuentas_ahorro1_idx` (`cuentas_ahorro_id_cuenta_ahorro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prestamos`
--

DROP TABLE IF EXISTS `prestamos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prestamos` (
  `id_prestamo` int NOT NULL AUTO_INCREMENT,
  `monto` decimal(12,2) DEFAULT '0.00',
  `intereses` decimal(5,2) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `saldo_pendiente` decimal(15,2) DEFAULT NULL,
  `estado` enum('PENDIENTE','APROBADO','PAGADO','CANCELADO') DEFAULT 'PENDIENTE',
  `solicitud_estado_prestamo` enum('APROBADO','RECHAZADO') DEFAULT NULL,
  `id_cliente` int NOT NULL,
  `id_fiador` int NOT NULL,
  `id_solicitud` int NOT NULL,
  PRIMARY KEY (`id_prestamo`),
  KEY `fk_solicitud_estado` (`solicitud_estado_prestamo`),
  KEY `fk_cliente` (`id_cliente`),
  KEY `fk_fiador` (`id_fiador`),
  KEY `fk_solicitud` (`id_solicitud`),
  CONSTRAINT `fk_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_clientes`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_fiador` FOREIGN KEY (`id_fiador`) REFERENCES `fiador` (`id_fiador`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_solicitud` FOREIGN KEY (`id_solicitud`) REFERENCES `solicitud_credito` (`id_solicitud`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_solicitud_estado` FOREIGN KEY (`solicitud_estado_prestamo`) REFERENCES `solicitud_credito` (`estado_solicitud`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `referencias_personales`
--

DROP TABLE IF EXISTS `referencias_personales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `referencias_personales` (
  `id_referencia` int NOT NULL AUTO_INCREMENT,
  `telefono` varchar(15) NOT NULL,
  `parentesco` varchar(50) NOT NULL,
  `primer_nombre` varchar(200) NOT NULL,
  `segundo_nombre` varchar(200) DEFAULT NULL,
  `otros_nombres` varchar(200) DEFAULT NULL,
  `primer_apellido` varchar(250) NOT NULL,
  `segundo_apellido` varchar(250) DEFAULT NULL,
  `otros_apellidos` varchar(100) DEFAULT NULL,
  `departamento` varchar(300) NOT NULL,
  `municipio` varchar(300) NOT NULL,
  `zona` varchar(300) NOT NULL,
  `grupo_habitacional` varchar(300) NOT NULL,
  `vialidad` varchar(300) NOT NULL,
  `numero_casa` varchar(300) NOT NULL,
  `DPI` varchar(20) NOT NULL,
  `estado` enum('APROBADO','RECHAZADO') DEFAULT NULL,
  `id_solicitud` int NOT NULL,
  `ocupacion_referencia` varchar(50) DEFAULT NULL,
  `criterio` enum('FAVORABLE','NO_FAVORABLE','POR EVALUAR') DEFAULT NULL,
  PRIMARY KEY (`id_referencia`),
  KEY `fk_referencias_personales_solicitud_credito` (`id_solicitud`),
  CONSTRAINT `fk_referencias_personales_solicitud_credito` FOREIGN KEY (`id_solicitud`) REFERENCES `solicitud_credito` (`id_solicitud`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `socios`
--

DROP TABLE IF EXISTS `socios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `socios` (
  `id_socio` int NOT NULL AUTO_INCREMENT,
  `primer_nombre` varchar(200) NOT NULL,
  `segundo_nombre` varchar(200) DEFAULT NULL,
  `otros_nombres` varchar(200) DEFAULT NULL,
  `primer_apellido` varchar(250) NOT NULL,
  `segundo_apellido` varchar(250) DEFAULT NULL,
  `otros_apellidos` varchar(250) DEFAULT NULL,
  `departamento` varchar(300) NOT NULL,
  `municipio` varchar(300) NOT NULL,
  `zona` varchar(300) NOT NULL,
  `grupo_habitacional` varchar(300) NOT NULL,
  `vialidad` varchar(300) NOT NULL,
  `numero_casa` varchar(300) NOT NULL,
  `prefijo` varchar(10) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `correo_electronico` varchar(100) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `estado` enum('ACTIVO','INACTIVO') DEFAULT 'ACTIVO',
  PRIMARY KEY (`id_socio`),
  UNIQUE KEY `correo_electronico` (`correo_electronico`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `solicitud_credito`
--

DROP TABLE IF EXISTS `solicitud_credito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `solicitud_credito` (
  `id_solicitud` int NOT NULL AUTO_INCREMENT,
  `correo_electronico` varchar(100) DEFAULT NULL,
  `estado_civil` varchar(20) DEFAULT NULL,
  `ocupacion` varchar(100) DEFAULT NULL,
  `DPI` varchar(20) NOT NULL,
  `cliente_id_cliente` int DEFAULT NULL,
  `fiador_id_fiador` int DEFAULT NULL,
  `estado_solicitud` enum('APROBADO','RECHAZADO','POR_EVALUAR') DEFAULT NULL,
  `tipo_prestamo` enum('FIDUCIARIO','HIPOTECARIO') DEFAULT NULL,
  PRIMARY KEY (`id_solicitud`),
  KEY `fk_id_cliente1` (`cliente_id_cliente`),
  KEY `fk_id_fiador` (`fiador_id_fiador`),
  KEY `estado_solicitud` (`estado_solicitud`),
  CONSTRAINT `fk_id_cliente1` FOREIGN KEY (`cliente_id_cliente`) REFERENCES `clientes` (`id_clientes`),
  CONSTRAINT `fk_id_fiador` FOREIGN KEY (`fiador_id_fiador`) REFERENCES `fiador` (`id_fiador`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tarjeta`
--

DROP TABLE IF EXISTS `tarjeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tarjeta` (
  `id_tarjeta` varchar(20) NOT NULL,
  `no_cuenta_monetaria` varchar(20) NOT NULL,
  `nombre_cliente` varchar(200) NOT NULL,
  `id_cliente` int NOT NULL,
  `fecha_creacion_tarjeta` datetime NOT NULL,
  `fecha_vencimiento` date DEFAULT NULL,
  `cvv` int NOT NULL,
  PRIMARY KEY (`id_tarjeta`),
  KEY `fk_tarjeta_cuenta_monetaria` (`no_cuenta_monetaria`),
  CONSTRAINT `fk_tarjeta_cuenta_monetaria` FOREIGN KEY (`no_cuenta_monetaria`) REFERENCES `cuentas_monetarias` (`id_cuenta_monetaria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `direccion` varchar(150) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `correo_electronico` varchar(100) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `tipo_usuario` enum('SOCIO','EMPLEADO','ADMIN') NOT NULL,
  `estado` enum('ACTIVO','INACTIVO') DEFAULT 'ACTIVO',
  `contrasena` varchar(300) NOT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `correo_electronico` (`correo_electronico`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usuarios_cuenta_juridica`
--

DROP TABLE IF EXISTS `usuarios_cuenta_juridica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios_cuenta_juridica` (
  `primer_nombre` varchar(100) NOT NULL,
  `segundo_nombre` varchar(100) DEFAULT NULL,
  `otros_nombres` varchar(100) DEFAULT NULL,
  `primer_apellido` varchar(250) NOT NULL,
  `segundo_apellido` varchar(250) DEFAULT NULL,
  `otros_apellidos` varchar(250) DEFAULT NULL,
  `puesto` varchar(100) DEFAULT NULL,
  `dpi_empleado` varchar(30) NOT NULL,
  `mail_corporativo` varchar(100) DEFAULT NULL,
  `id_usuarios_cuenta_juridica` int NOT NULL,
  PRIMARY KEY (`id_usuarios_cuenta_juridica`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vehiculos`
--

DROP TABLE IF EXISTS `vehiculos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehiculos` (
  `id_vehiculo` int NOT NULL AUTO_INCREMENT,
  `marca` varchar(50) NOT NULL,
  `modelo` varchar(50) NOT NULL,
  `año` int NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  `tipo_vehiculo` varchar(20) NOT NULL,
  `finalidad_vehiculo` enum('USO_PERSONAL','USO_COMERCIAL') NOT NULL,
  `cantidad_vehiculos` int NOT NULL,
  `placas` varchar(10) NOT NULL,
  `fase` enum('PAGADO','EN_PROCESO_DE_PAGO') NOT NULL,
  `fecha_compra` date DEFAULT NULL,
  `estado_vehiculo` enum('USADO','NUEVO') DEFAULT NULL,
  `estado` enum('APROBADO','RECHAZADO') DEFAULT NULL,
  `id_solicitud` int NOT NULL,
  PRIMARY KEY (`id_vehiculo`),
  KEY `fk_vehiculos_solicitud_credito` (`id_solicitud`),
  CONSTRAINT `fk_vehiculos_solicitud_credito` FOREIGN KEY (`id_solicitud`) REFERENCES `solicitud_credito` (`id_solicitud`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `vistaclientescuentas`
--

DROP TABLE IF EXISTS `vistaclientescuentas`;
/*!50001 DROP VIEW IF EXISTS `vistaclientescuentas`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vistaclientescuentas` AS SELECT
 1 AS `id_clientes`,
  1 AS `cuenta_aportes`,
  1 AS `monto_aportes`,
  1 AS `cuenta_ahorro`,
  1 AS `monto_ahorro`,
  1 AS `cuenta_monetaria`,
  1 AS `monto_monetaria` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vistamovbancarios`
--

DROP TABLE IF EXISTS `vistamovbancarios`;
/*!50001 DROP VIEW IF EXISTS `vistamovbancarios`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vistamovbancarios` AS SELECT
 1 AS `id_clientes`,
  1 AS `cuenta_aportes`,
  1 AS `monto_aportes`,
  1 AS `cuenta_ahorro`,
  1 AS `monto_ahorro`,
  1 AS `cuenta_monetaria`,
  1 AS `monto_monetaria` */;
SET character_set_client = @saved_cs_client;

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

-- Dump completed on 2025-05-30 22:35:51
