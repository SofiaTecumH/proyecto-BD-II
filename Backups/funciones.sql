-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: cooperativa_db
-- ------------------------------------------------------
-- Server version	8.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auditoria`
--

DROP TABLE IF EXISTS `auditoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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

--
-- Dumping data for table `auditoria`
--

LOCK TABLES `auditoria` WRITE;
/*!40000 ALTER TABLE `auditoria` DISABLE KEYS */;
/*!40000 ALTER TABLE `auditoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bienes_inmuebles`
--

DROP TABLE IF EXISTS `bienes_inmuebles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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

--
-- Dumping data for table `bienes_inmuebles`
--

LOCK TABLES `bienes_inmuebles` WRITE;
/*!40000 ALTER TABLE `bienes_inmuebles` DISABLE KEYS */;
INSERT INTO `bienes_inmuebles` VALUES (3,'Residencial',40000.00,'Ciudad','RECHAZADO',1),(4,'Residencial',200.00,'Ciudad','RECHAZADO',1),(5,'terreno',40000.00,'Xela','APROBADO',2);
/*!40000 ALTER TABLE `bienes_inmuebles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bitacora`
--

DROP TABLE IF EXISTS `bitacora`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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

--
-- Dumping data for table `bitacora`
--

LOCK TABLES `bitacora` WRITE;
/*!40000 ALTER TABLE `bitacora` DISABLE KEYS */;
INSERT INTO `bitacora` VALUES (1,'Se insertó una operación bancaria con ID: 1','operaciones_bancarias','INSERT','2025-05-24 04:39:17','Operación: DEPOSITO, Monto: 300.00, Fecha: 2025-05-23 22:39:17, Cuenta Ahorro: , Cuenta Monetaria: NULL');
/*!40000 ALTER TABLE `bitacora` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogo_clientes`
--

DROP TABLE IF EXISTS `catalogo_clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalogo_clientes` (
  `id_clientes` varchar(20) NOT NULL,
  `tipo_cliente` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogo_clientes`
--

LOCK TABLES `catalogo_clientes` WRITE;
/*!40000 ALTER TABLE `catalogo_clientes` DISABLE KEYS */;
INSERT INTO `catalogo_clientes` VALUES ('1','CLIENTE_INDIVIDUAL'),('2','CLIENTE_JURIDICO'),('3','SOCIO');
/*!40000 ALTER TABLE `catalogo_clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogo_estado`
--

DROP TABLE IF EXISTS `catalogo_estado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalogo_estado` (
  `id_estado` int NOT NULL AUTO_INCREMENT,
  `estado` varchar(50) NOT NULL,
  PRIMARY KEY (`id_estado`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogo_estado`
--

LOCK TABLES `catalogo_estado` WRITE;
/*!40000 ALTER TABLE `catalogo_estado` DISABLE KEYS */;
INSERT INTO `catalogo_estado` VALUES (1,'ACTIVO'),(2,'INACTIVO');
/*!40000 ALTER TABLE `catalogo_estado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogo_estado_prestamo`
--

DROP TABLE IF EXISTS `catalogo_estado_prestamo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalogo_estado_prestamo` (
  `id_estado_prestamo` int NOT NULL AUTO_INCREMENT,
  `estado_prestamo` varchar(50) NOT NULL,
  PRIMARY KEY (`id_estado_prestamo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogo_estado_prestamo`
--

LOCK TABLES `catalogo_estado_prestamo` WRITE;
/*!40000 ALTER TABLE `catalogo_estado_prestamo` DISABLE KEYS */;
INSERT INTO `catalogo_estado_prestamo` VALUES (1,'PENDIENTE'),(2,'APROBADO'),(3,'PAGADO'),(4,'CANCELADO');
/*!40000 ALTER TABLE `catalogo_estado_prestamo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogo_tipo_operacion`
--

DROP TABLE IF EXISTS `catalogo_tipo_operacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalogo_tipo_operacion` (
  `id_tipo_operacion` int NOT NULL AUTO_INCREMENT,
  `tipo_operacion` varchar(50) NOT NULL,
  PRIMARY KEY (`id_tipo_operacion`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogo_tipo_operacion`
--

LOCK TABLES `catalogo_tipo_operacion` WRITE;
/*!40000 ALTER TABLE `catalogo_tipo_operacion` DISABLE KEYS */;
INSERT INTO `catalogo_tipo_operacion` VALUES (1,'DEPOSITO'),(2,'RETIRO'),(3,'TRANSFERENCIA'),(4,'PAGO_PRÉSTAMO'),(5,'DEPOSITO'),(6,'RETIRO'),(7,'TRANSFERENCIA'),(8,'PAGO_PRÉSTAMO');
/*!40000 ALTER TABLE `catalogo_tipo_operacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogo_tipo_usuario`
--

DROP TABLE IF EXISTS `catalogo_tipo_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalogo_tipo_usuario` (
  `id_tipo_usuario` int NOT NULL AUTO_INCREMENT,
  `tipo_usuario` varchar(50) NOT NULL,
  PRIMARY KEY (`id_tipo_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogo_tipo_usuario`
--

LOCK TABLES `catalogo_tipo_usuario` WRITE;
/*!40000 ALTER TABLE `catalogo_tipo_usuario` DISABLE KEYS */;
INSERT INTO `catalogo_tipo_usuario` VALUES (1,'SOCIO'),(2,'EMPLEADO'),(3,'ADMIN');
/*!40000 ALTER TABLE `catalogo_tipo_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogoconceptos`
--

DROP TABLE IF EXISTS `catalogoconceptos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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

--
-- Dumping data for table `catalogoconceptos`
--

LOCK TABLES `catalogoconceptos` WRITE;
/*!40000 ALTER TABLE `catalogoconceptos` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalogoconceptos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chequera`
--

DROP TABLE IF EXISTS `chequera`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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

--
-- Dumping data for table `chequera`
--

LOCK TABLES `chequera` WRITE;
/*!40000 ALTER TABLE `chequera` DISABLE KEYS */;
INSERT INTO `chequera` VALUES (3,21,'Cliente2','9349-05055-2042'),(4,26,'Cliente3','9432-54769-4421'),(7,25,'Cliente5','9567-51092-8522'),(8,24,'Cliente6','9703-86313-2043'),(9,1,'Cliente7','9728-08624-2453'),(11,20,'Cliente9','9869-73556-0688'),(12,27,'Cliente10','9884-90752-8852');
/*!40000 ALTER TABLE `chequera` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'ACTIVO',1,NULL,NULL),(2,'ACTIVO',2,NULL,NULL),(3,'ACTIVO',3,NULL,NULL),(4,'ACTIVO',4,NULL,NULL),(5,'ACTIVO',5,NULL,NULL),(6,'ACTIVO',6,NULL,NULL),(7,'ACTIVO',7,NULL,NULL),(8,'ACTIVO',9,NULL,NULL),(9,'ACTIVO',10,NULL,NULL),(10,'ACTIVO',11,NULL,NULL),(11,'ACTIVO',12,NULL,NULL),(12,'ACTIVO',13,NULL,NULL),(13,'ACTIVO',NULL,1,NULL),(14,'ACTIVO',NULL,2,NULL),(15,'ACTIVO',NULL,3,NULL),(16,'ACTIVO',NULL,4,NULL),(17,'ACTIVO',NULL,5,NULL),(18,'ACTIVO',NULL,NULL,1),(19,'ACTIVO',NULL,NULL,2),(20,'ACTIVO',NULL,NULL,3),(21,'ACTIVO',NULL,NULL,4),(22,'ACTIVO',NULL,NULL,5),(23,'ACTIVO',NULL,NULL,6),(24,'ACTIVO',NULL,NULL,7),(25,'ACTIVO',NULL,NULL,8),(26,'ACTIVO',NULL,NULL,9),(27,'ACTIVO',NULL,NULL,10);
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientes_individuales`
--

DROP TABLE IF EXISTS `clientes_individuales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
-- Dumping data for table `clientes_individuales`
--

LOCK TABLES `clientes_individuales` WRITE;
/*!40000 ALTER TABLE `clientes_individuales` DISABLE KEYS */;
INSERT INTO `clientes_individuales` VALUES (1,'1234567890101','Sofia','Isabel','Maria','Martinez','Lopez',NULL,'1990-05-15','SOLTERO',1,'Guatemala','Ciudad de Guatemala','Zona 10','Colonia Primavera','Calle 5','101-A','555-1234','sofia.martinez@example.com',NULL),(2,'111111111111','Maria',NULL,NULL,'Martinez','Lopez',NULL,'1990-03-15','CASADO',2,'Guatemala','Ciudad de Guatemala','Zona 10','Colonia Primavera','Calle 5','101-A','555-1234','naria.martinez@example.com',NULL),(3,'123456789','Juan','Carlos','Miguel','Perez','Lopez','Garcia','1985-06-15','CASADO',1,'Guatemala','Guatemala','Zona 1','Grupo A','Calle 10','123','5551234','juan.perez@example.com','Activo'),(4,'987654321','Maria','Elena',NULL,'Rodriguez','Martinez','Fernandez','1990-12-25','SOLTERO',2,'Escuintla','Escuintla','Zona 2','Grupo B','Avenida 5','456','5555678','maria.rodriguez@example.com','Activo'),(5,'456789123','Luis',NULL,NULL,'Gomez',NULL,NULL,'1980-03-10','CASADO',3,'Quetzaltenango','Quetzaltenango','Zona 3','Grupo C','Calle 20','789','5557890','luis.gomez@example.com','Activo'),(6,'321654987','Ana','Patricia','Isabel','Ramirez','Castillo','Lopez','1995-08-30','SOLTERO',4,'Chimaltenango','Chimaltenango','Zona 4','Grupo D','Avenida 15','321','5553210','ana.ramirez@example.com','Activo'),(7,'654321789','Carlos','Eduardo','Francisco','Sanchez','Mendez','Ruiz','1988-11-05','CASADO',5,'Jalapa','Jalapa','Zona 5','Grupo E','Calle 25','654','5556543','carlos.sanchez@example.com','Activo'),(9,'102030405','Ricardo','Andrés',NULL,'Mendoza','González',NULL,'1987-08-14','CASADO',6,'Quiché','Santa Cruz','Zona 11','Residencial Las Flores','Avenida Central','25','5551020','ricardo.mendoza@example.com','Activo'),(10,'203040506','Elena',NULL,NULL,'Vargas','López',NULL,'1993-04-26','SOLTERO',7,'Chimaltenango','San Martín','Zona 12','Condominio El Roble','Calle 3','12B','5552030','elena.vargas@example.com','Activo'),(11,'304050607','Carlos','Emilio',NULL,'Salazar',NULL,NULL,'1989-12-05','CASADO',8,'San Marcos','San Rafael','Zona 13','Residencial Los Cedros','Boulevard Principal','8','5553040','carlos.salazar@example.com','Activo'),(12,'405060708','Lucía',NULL,NULL,'Ramírez','Castillo',NULL,'1996-06-18','SOLTERO',9,'Alta Verapaz','Cobán','Zona 14','Urbanización Vista Verde','Calle 6','7A','5554050','lucia.ramirez@example.com','Activo'),(13,'506070809','Gabriel','Antonio',NULL,'Ortega','Muñoz',NULL,'1991-02-22','CASADO',10,'Santa Rosa','Cuilapa','Zona 15','Residencial Los Pinos','Avenida Norte','14','5555060','gabriel.ortega@example.com','Activo');
/*!40000 ALTER TABLE `clientes_individuales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientesjuridicos`
--

DROP TABLE IF EXISTS `clientesjuridicos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
-- Dumping data for table `clientesjuridicos`
--

LOCK TABLES `clientesjuridicos` WRITE;
/*!40000 ALTER TABLE `clientesjuridicos` DISABLE KEYS */;
INSERT INTO `clientesjuridicos` VALUES (1,'TechGlobal','TechGlobal S.A.','123456789','5551001','contacto@techglobal.com','2005-08-12 00:00:00','Carlos Mendoza','Corporación','Guatemala','Guatemala','Zona 10','Residencial Vista Hermosa','Avenida Reforma','101','Activo',1),(2,'EcoVerde','EcoVerde Ltda.','987654321','5552002','info@ecoverde.com','2012-04-20 00:00:00','Ana López','Cooperativa','Sacatepéquez','Antigua','Zona 2','Condominio Los Pinos','Calle 4','20A','Activo',2),(3,'Finanzas Plus','Finanzas Plus S.A.','456789123','5553003','servicios@finanzasplus.com','1999-12-15 00:00:00','Roberto García','Banco','Escuintla','Escuintla','Zona 4','Residencial El Lago','Boulevard Central','15','Activo',3),(4,'Constructora Avance','Constructora Avance S.A.','321654987','5554004','contacto@avance.com','2010-06-30 00:00:00','Laura Pérez','Empresa','Quetzaltenango','Quetzaltenango','Zona 7','Urbanización El Roble','Avenida Norte','12B','Activo',4),(5,'AgroSoluciones','AgroSoluciones Ltda.','654321789','5555005','soporte@agrosoluciones.com','2015-09-25 00:00:00','Diego Ramírez','Asociación','Alta Verapaz','Cobán','Zona 5','Residencial Las Palmas','Calle Principal','8','Activo',5);
/*!40000 ALTER TABLE `clientesjuridicos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cuentas_ahorro`
--

DROP TABLE IF EXISTS `cuentas_ahorro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
-- Dumping data for table `cuentas_ahorro`
--

LOCK TABLES `cuentas_ahorro` WRITE;
/*!40000 ALTER TABLE `cuentas_ahorro` DISABLE KEYS */;
INSERT INTO `cuentas_ahorro` VALUES (NULL,'2025-04-27 14:43:28',NULL,'23','3132-66056-9047'),(NULL,'2025-04-27 14:45:07',NULL,'21','3145-61115-0121'),(NULL,'2025-04-27 14:45:07',NULL,'18','3194-05115-6725'),(NULL,'2025-04-27 14:37:25',NULL,'27','3247-05092-5125'),(4.00,'2025-04-27 06:33:35',NULL,'1','3249-31595-5049'),(NULL,'2025-04-27 14:47:15',NULL,'15','3380-65700-1710'),(NULL,'2025-04-27 14:45:47',NULL,'16','3419-74554-4707'),(4.00,'2025-04-27 06:41:51',NULL,'1','3466-98914-5457'),(NULL,'2025-04-27 14:45:07',NULL,'17','3508-98566-4017'),(4.00,'2025-04-27 06:40:41',NULL,'1','3576-36900-1147'),(NULL,'2025-05-24 01:43:40',100.00,'13','3651-51071-6000'),(NULL,'2025-04-27 14:45:07',NULL,'22','3779-83787-8503'),(NULL,'2025-04-27 14:45:07',NULL,'20','3808-57552-4522'),(NULL,'2025-04-27 14:45:07',NULL,'19','3937-75395-9586');
/*!40000 ALTER TABLE `cuentas_ahorro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cuentas_aportes`
--

DROP TABLE IF EXISTS `cuentas_aportes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
-- Dumping data for table `cuentas_aportes`
--

LOCK TABLES `cuentas_aportes` WRITE;
/*!40000 ALTER TABLE `cuentas_aportes` DISABLE KEYS */;
INSERT INTO `cuentas_aportes` VALUES (NULL,200.00,'2025-04-27 14:47:15',15,'4116-17233-5109','2025-10-27'),(NULL,200.00,'2025-04-27 14:45:07',17,'4209-02958-5195','2025-10-27'),(NULL,200.00,'2025-04-27 14:45:07',20,'4227-10095-8222','2025-10-27'),(NULL,200.00,'2025-04-27 14:43:28',23,'4410-51294-3343','2025-10-27'),(NULL,200.00,'2025-04-27 14:45:47',16,'4519-05448-1164','2025-10-27'),(NULL,200.00,'2025-04-27 14:45:07',18,'4531-78009-3069','2025-10-27'),(NULL,200.00,'2025-04-27 14:45:07',19,'4534-31616-9771','2025-10-27'),(NULL,200.00,'2025-04-27 14:45:07',22,'4542-99591-3534','2025-10-27'),(NULL,100.00,'2025-05-24 01:43:40',13,'4578-19690-2483','2025-11-23'),(NULL,200.00,'2025-04-27 14:45:07',21,'4738-14042-4871','2025-10-27'),(100.00,NULL,'2025-04-27 14:37:25',27,'4939-24299-3952','2025-10-27'),(NULL,100.00,'2025-04-23 04:52:56',1,'APORT12345','2025-10-22');
/*!40000 ALTER TABLE `cuentas_aportes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cuentas_monetarias`
--

DROP TABLE IF EXISTS `cuentas_monetarias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cuentas_monetarias` (
  `saldo` decimal(12,2) DEFAULT '0.00',
  `fecha_creacion` datetime NOT NULL,
  `id_cliente` int NOT NULL,
  `id_cuenta_monetaria` varchar(20) NOT NULL,
  PRIMARY KEY (`id_cuenta_monetaria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cuentas_monetarias`
--

LOCK TABLES `cuentas_monetarias` WRITE;
/*!40000 ALTER TABLE `cuentas_monetarias` DISABLE KEYS */;
INSERT INTO `cuentas_monetarias` VALUES (100.00,'2025-04-27 08:53:06',12,'9137-48030-9894'),(100.00,'2025-04-27 08:53:06',21,'9349-05055-2042'),(100.00,'2025-04-27 08:53:06',26,'9432-54769-4421'),(100.00,'2025-04-27 08:53:06',9,'9506-56395-3003'),(100.00,'2025-04-27 08:53:06',25,'9567-51092-8522'),(100.00,'2025-04-27 08:53:06',13,'9703-86313-2043'),(100.00,'2025-04-27 08:53:06',24,'9728-08624-2453'),(0.00,'2025-04-27 00:01:30',1,'9756-10769-2696'),(100.00,'2025-04-27 08:53:06',22,'9781-04847-8989'),(100.00,'2025-04-27 08:53:06',20,'9869-73556-0688'),(100.00,'2025-04-27 08:50:13',27,'9884-90752-8852'),(100.00,'2025-04-27 08:53:06',23,'9968-10471-6190');
/*!40000 ALTER TABLE `cuentas_monetarias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cuotas_prestamos`
--

DROP TABLE IF EXISTS `cuotas_prestamos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
-- Dumping data for table `cuotas_prestamos`
--

LOCK TABLES `cuotas_prestamos` WRITE;
/*!40000 ALTER TABLE `cuotas_prestamos` DISABLE KEYS */;
INSERT INTO `cuotas_prestamos` VALUES (1,3,958.33,'2025-05-20 06:00:00','PENDIENTE',8083.34,12),(2,3,958.33,'2025-05-20 06:00:00','PENDIENTE',10000.00,12);
/*!40000 ALTER TABLE `cuotas_prestamos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `detallepagosprestamos`
--

DROP TABLE IF EXISTS `detallepagosprestamos`;
/*!50001 DROP VIEW IF EXISTS `detallepagosprestamos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
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
 1 AS `estado_prestamo`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `documentosclientes`
--

DROP TABLE IF EXISTS `documentosclientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
-- Dumping data for table `documentosclientes`
--

LOCK TABLES `documentosclientes` WRITE;
/*!40000 ALTER TABLE `documentosclientes` DISABLE KEYS */;
/*!40000 ALTER TABLE `documentosclientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleados`
--

DROP TABLE IF EXISTS `empleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
-- Dumping data for table `empleados`
--

LOCK TABLES `empleados` WRITE;
/*!40000 ALTER TABLE `empleados` DISABLE KEYS */;
/*!40000 ALTER TABLE `empleados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fiador`
--

DROP TABLE IF EXISTS `fiador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
-- Dumping data for table `fiador`
--

LOCK TABLES `fiador` WRITE;
/*!40000 ALTER TABLE `fiador` DISABLE KEYS */;
INSERT INTO `fiador` VALUES (1,1,'Hermano',10,'2025-04-17 23:15:00'),(2,2,'Hermano',10,'2025-04-17 23:15:00');
/*!40000 ALTER TABLE `fiador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historial_crediticio`
--

DROP TABLE IF EXISTS `historial_crediticio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
-- Dumping data for table `historial_crediticio`
--

LOCK TABLES `historial_crediticio` WRITE;
/*!40000 ALTER TABLE `historial_crediticio` DISABLE KEYS */;
INSERT INTO `historial_crediticio` VALUES (1,'Personal',15000.00,'PAGADO','APROBADO','CON_HISTORIAL',95.00,'El cliente ha cumplido con todos los pagos de forma puntual.',1),(2,'Hipotecario',80000.00,'INCUMPLIDO','RECHAZADO','CON_HISTORIAL',70.00,'Retraso en pagos por más de 6 meses.',1),(3,'Automotriz',25000.00,'PENDIENTE','APROBADO','SIN_HISTORIAL',NULL,'No se han registrado pagos debido a que el crédito es reciente.',1),(4,'Personal',20000.00,'PAGADO','APROBADO',NULL,95.00,'Pago puntual en todos los casos.',1),(5,'Automotriz',30000.00,'PENDIENTE','RECHAZADO',NULL,85.00,'Pago con retrasos esporádicos.',1),(6,'Hipotecario',100000.00,'INCUMPLIDO','RECHAZADO',NULL,NULL,'El cliente incumplió varios pagos.',1);
/*!40000 ALTER TABLE `historial_crediticio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historial_movimientos`
--

DROP TABLE IF EXISTS `historial_movimientos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
-- Dumping data for table `historial_movimientos`
--

LOCK TABLES `historial_movimientos` WRITE;
/*!40000 ALTER TABLE `historial_movimientos` DISABLE KEYS */;
/*!40000 ALTER TABLE `historial_movimientos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imagenescheques`
--

DROP TABLE IF EXISTS `imagenescheques`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
-- Dumping data for table `imagenescheques`
--

LOCK TABLES `imagenescheques` WRITE;
/*!40000 ALTER TABLE `imagenescheques` DISABLE KEYS */;
/*!40000 ALTER TABLE `imagenescheques` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingresos_familiares`
--

DROP TABLE IF EXISTS `ingresos_familiares`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
-- Dumping data for table `ingresos_familiares`
--

LOCK TABLES `ingresos_familiares` WRITE;
/*!40000 ALTER TABLE `ingresos_familiares` DISABLE KEYS */;
INSERT INTO `ingresos_familiares` VALUES (1,'Familiar',3,NULL,2000.00,'RECHAZADO',1),(2,'Familiar',3,NULL,12000.00,'APROBADO',1),(3,'Familiar',0,NULL,1200.00,'RECHAZADO',1);
/*!40000 ALTER TABLE `ingresos_familiares` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `intereses_prestamos`
--

DROP TABLE IF EXISTS `intereses_prestamos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
-- Dumping data for table `intereses_prestamos`
--

LOCK TABLES `intereses_prestamos` WRITE;
/*!40000 ALTER TABLE `intereses_prestamos` DISABLE KEYS */;
/*!40000 ALTER TABLE `intereses_prestamos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manejo_aportes`
--

DROP TABLE IF EXISTS `manejo_aportes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
-- Dumping data for table `manejo_aportes`
--

LOCK TABLES `manejo_aportes` WRITE;
/*!40000 ALTER TABLE `manejo_aportes` DISABLE KEYS */;
INSERT INTO `manejo_aportes` VALUES (1,'APORT12345',NULL,NULL,300.00,200.00,'DEPOSITO'),(2,'APORT12345',NULL,NULL,300.00,100.00,'DEPOSITO'),(3,'APORT12345',NULL,NULL,600.00,300.00,'DEPOSITO'),(4,'APORT12345',NULL,NULL,900.00,300.00,'DEPOSITO');
/*!40000 ALTER TABLE `manejo_aportes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manejo_chequera`
--

DROP TABLE IF EXISTS `manejo_chequera`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
-- Dumping data for table `manejo_chequera`
--

LOCK TABLES `manejo_chequera` WRITE;
/*!40000 ALTER TABLE `manejo_chequera` DISABLE KEYS */;
/*!40000 ALTER TABLE `manejo_chequera` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manejo_tarjeta`
--

DROP TABLE IF EXISTS `manejo_tarjeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
-- Dumping data for table `manejo_tarjeta`
--

LOCK TABLES `manejo_tarjeta` WRITE;
/*!40000 ALTER TABLE `manejo_tarjeta` DISABLE KEYS */;
/*!40000 ALTER TABLE `manejo_tarjeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ocupacion`
--

DROP TABLE IF EXISTS `ocupacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
-- Dumping data for table `ocupacion`
--

LOCK TABLES `ocupacion` WRITE;
/*!40000 ALTER TABLE `ocupacion` DISABLE KEYS */;
INSERT INTO `ocupacion` VALUES (1,'TechCorp','Ing. de Software','2020-01-15',5000.00,'APROBADO',1),(2,'SoftData','Analista','2024-01-01',4000.00,'APROBADO',1),(3,'SoftData','Analista','2024-05-01',4000.00,'APROBADO',1),(4,'SoftData','Servicio Cliente','2025-05-01',4000.00,'RECHAZADO',2);
/*!40000 ALTER TABLE `ocupacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operaciones_bancarias`
--

DROP TABLE IF EXISTS `operaciones_bancarias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
-- Dumping data for table `operaciones_bancarias`
--

LOCK TABLES `operaciones_bancarias` WRITE;
/*!40000 ALTER TABLE `operaciones_bancarias` DISABLE KEYS */;
INSERT INTO `operaciones_bancarias` VALUES (1,300.00,'2025-05-24 04:39:17','',NULL,'DEPOSITO');
/*!40000 ALTER TABLE `operaciones_bancarias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `otros_ingresos`
--

DROP TABLE IF EXISTS `otros_ingresos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
-- Dumping data for table `otros_ingresos`
--

LOCK TABLES `otros_ingresos` WRITE;
/*!40000 ALTER TABLE `otros_ingresos` DISABLE KEYS */;
INSERT INTO `otros_ingresos` VALUES (1,'cada 2 meses','Venta ocasional',800.00,'APROBADO',1),(2,'mensual','horas extra',300.00,'APROBADO',1);
/*!40000 ALTER TABLE `otros_ingresos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pago_prestamo`
--

DROP TABLE IF EXISTS `pago_prestamo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
-- Dumping data for table `pago_prestamo`
--

LOCK TABLES `pago_prestamo` WRITE;
/*!40000 ALTER TABLE `pago_prestamo` DISABLE KEYS */;
INSERT INTO `pago_prestamo` VALUES (1,3,958.33,1,'2025-04-26',1,1),(2,3,958.33,1,'2025-04-26',1,1);
/*!40000 ALTER TABLE `pago_prestamo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagos_intereses`
--

DROP TABLE IF EXISTS `pagos_intereses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
-- Dumping data for table `pagos_intereses`
--

LOCK TABLES `pagos_intereses` WRITE;
/*!40000 ALTER TABLE `pagos_intereses` DISABLE KEYS */;
/*!40000 ALTER TABLE `pagos_intereses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `porcentajes_intereses`
--

DROP TABLE IF EXISTS `porcentajes_intereses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
-- Dumping data for table `porcentajes_intereses`
--

LOCK TABLES `porcentajes_intereses` WRITE;
/*!40000 ALTER TABLE `porcentajes_intereses` DISABLE KEYS */;
/*!40000 ALTER TABLE `porcentajes_intereses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prestamos`
--

DROP TABLE IF EXISTS `prestamos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
-- Dumping data for table `prestamos`
--

LOCK TABLES `prestamos` WRITE;
/*!40000 ALTER TABLE `prestamos` DISABLE KEYS */;
INSERT INTO `prestamos` VALUES (2,10000.00,NULL,'2025-04-20 20:06:45',10000.00,'PENDIENTE',NULL,1,2,1),(3,10000.00,15.00,'2025-04-20 20:06:58',10000.00,'PENDIENTE',NULL,2,1,2),(4,10000.00,NULL,'2025-04-20 20:21:52',10000.00,'PENDIENTE',NULL,2,1,2),(5,10000.00,NULL,'2025-04-20 20:31:16',10000.00,'PENDIENTE',NULL,2,1,2),(6,10000.00,NULL,'2025-04-26 23:00:22',10000.00,'PENDIENTE',NULL,2,1,2),(7,10000.00,NULL,'2025-04-26 23:01:28',10000.00,'PENDIENTE',NULL,1,2,1),(8,10000.00,NULL,'2025-04-26 23:01:33',10000.00,'PENDIENTE',NULL,2,1,2),(9,10000.00,NULL,'2025-04-26 23:05:47',10000.00,'PENDIENTE',NULL,2,1,2);
/*!40000 ALTER TABLE `prestamos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `referencias_personales`
--

DROP TABLE IF EXISTS `referencias_personales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
-- Dumping data for table `referencias_personales`
--

LOCK TABLES `referencias_personales` WRITE;
/*!40000 ALTER TABLE `referencias_personales` DISABLE KEYS */;
INSERT INTO `referencias_personales` VALUES (1,'555-1234','Amigo','Carlos','Eduardo','Martinez','Ramirez','Lopez',NULL,'Guatemala','Ciudad de Guatemala','Zona 1','Primavera','Calle 5','12-A','1234567890101','APROBADO',1,'Ingeniero','FAVORABLE'),(2,'555-5678','Hermano','Ana','Isabel','Morales','Lopez','Garcia',NULL,'Guatemala','Ciudad de Guatemala','Zona 5','Las Rosas','Avenida 6','6-B','9876543210123','APROBADO',1,'Doctora','NO_FAVORABLE'),(3,'555-9999','Primo','Luis','Alfredo','Sanchez','Gomez','Martinez',NULL,'Guatemala','Ciudad de Guatemala','Zona 7','San José','Calle 8','15-C','5678901234567','APROBADO',1,'Contador','POR EVALUAR');
/*!40000 ALTER TABLE `referencias_personales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socios`
--

DROP TABLE IF EXISTS `socios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
-- Dumping data for table `socios`
--

LOCK TABLES `socios` WRITE;
/*!40000 ALTER TABLE `socios` DISABLE KEYS */;
INSERT INTO `socios` VALUES (1,'Juan',NULL,NULL,'González','Martínez',NULL,'Guatemala','Guatemala','Zona 1','Residencial Las Flores','Avenida Principal','101','502','5551010','juan.gonzalez@example.com','1985-05-12','ACTIVO'),(2,'María','Fernanda',NULL,'Lopez',NULL,NULL,'Sacatepéquez','Antigua Guatemala','Zona 2','Condominio Los Cedros','Calle 5','22B','502','5552020','maria.lopez@example.com','1992-08-30','ACTIVO'),(3,'Carlos',NULL,NULL,'Rodríguez','Hernández',NULL,'Escuintla','Escuintla','Zona 3','Urbanización Vista Verde','Calle 3','15','502','5553030','carlos.rodriguez@example.com','1990-04-20','ACTIVO'),(4,'Lucía',NULL,NULL,'Ramírez',NULL,NULL,'Chimaltenango','Chimaltenango','Zona 4','Residencial El Roble','Avenida 10','8A','502','5554040','lucia.ramirez@example.com','1995-12-10','ACTIVO'),(5,'Gabriel','Antonio',NULL,'Ortega','Muñoz',NULL,'Quetzaltenango','Quetzaltenango','Zona 5','Residencial Los Pinos','Boulevard Central','14','502','5555050','gabriel.ortega@example.com','1988-07-25','ACTIVO'),(6,'Emilio',NULL,NULL,'Navarro','Gómez',NULL,'Guatemala','Guatemala','Zona 6','Residencial Los Álamos','Avenida Principal','120','502','5556060','emilio.navarro@example.com','1982-09-14','ACTIVO'),(7,'Paula','Andrea',NULL,'Santos',NULL,NULL,'Sacatepéquez','Antigua Guatemala','Zona 7','Condominio El Encino','Calle 7','35B','502','5557070','paula.santos@example.com','1995-04-21','ACTIVO'),(8,'Javier',NULL,NULL,'Pérez',NULL,NULL,'Escuintla','Escuintla','Zona 8','Urbanización El Bosque','Calle 2','45','502','5558080','javier.perez@example.com','1989-07-30','ACTIVO'),(9,'Valentina',NULL,NULL,'Rojas','Mendoza',NULL,'Chimaltenango','Chimaltenango','Zona 9','Residencial Los Laureles','Avenida 5','28A','502','5559090','valentina.rojas@example.com','1992-12-05','ACTIVO'),(10,'Diego',NULL,NULL,'Ortega','Castillo',NULL,'Quetzaltenango','Quetzaltenango','Zona 10','Residencial El Prado','Boulevard Central','50','502','5551010','diego.ortega@example.com','1987-06-18','ACTIVO');
/*!40000 ALTER TABLE `socios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `solicitud_credito`
--

DROP TABLE IF EXISTS `solicitud_credito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
-- Dumping data for table `solicitud_credito`
--

LOCK TABLES `solicitud_credito` WRITE;
/*!40000 ALTER TABLE `solicitud_credito` DISABLE KEYS */;
INSERT INTO `solicitud_credito` VALUES (1,'sofia.martinez@example.com','SOLTERO','Comerciante','1234567890101',1,2,'APROBADO',NULL),(2,'nuevo_cliente@example.com','Casado','Abogado','9876543210987',2,1,'POR_EVALUAR',NULL);
/*!40000 ALTER TABLE `solicitud_credito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tarjeta`
--

DROP TABLE IF EXISTS `tarjeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
-- Dumping data for table `tarjeta`
--

LOCK TABLES `tarjeta` WRITE;
/*!40000 ALTER TABLE `tarjeta` DISABLE KEYS */;
INSERT INTO `tarjeta` VALUES ('9014 2522 2568 5277','9506-56395-3003','Cliente4',9,'2025-04-27 10:09:22','2028-04-27',867),('9195 9919 3727 8876','9756-10769-2696','Cliente8',1,'2025-04-27 10:09:39','2028-04-27',320),('9197 1663 4908 4044','9756-10769-2696','Cliente8',1,'2025-04-27 10:08:34','2028-04-27',549),('9227 2355 4964 7752','9432-54769-4421','Cliente3',26,'2025-04-27 10:08:34','2028-04-27',387),('9280 4024 1711 6484','9703-86313-2043','Cliente6',13,'2025-04-27 10:09:30','2028-04-27',728),('9329 8994 5096 8497','9349-05055-2042','Cliente2',21,'2025-04-27 10:09:14','2028-04-27',720),('9380 9651 6845 5271','9137-48030-9894','Cliente1',12,'2025-04-27 10:09:08','2028-04-27',582),('9421 2276 9872 8680','9869-73556-0688','Cliente10',27,'2025-04-27 10:09:53','2028-04-27',378),('9460 4960 9877 0057','9703-86313-2043','Cliente6',13,'2025-04-27 10:08:34','2028-04-27',732),('9466 7593 3985 7148','9137-48030-9894','Cliente1',12,'2025-04-27 10:08:34','2028-04-27',378),('9508 9410 3180 3078','9432-54769-4421','Cliente3',26,'2025-04-27 10:09:17','2028-04-27',584),('9609 8871 6065 3713','9506-56395-3003','Cliente4',9,'2025-04-27 10:08:34','2028-04-27',372),('9644 2681 1996 9178','9728-08624-2453','Cliente7',24,'2025-04-27 10:08:34','2028-04-27',990),('9698 3062 4359 2606','9728-08624-2453','Cliente7',24,'2025-04-27 10:09:35','2028-04-27',995),('9722 2495 3084 4055','9567-51092-8522','Cliente5',25,'2025-04-27 10:08:34','2028-04-27',935),('9746 5991 7554 9799','9349-05055-2042','Cliente2',21,'2025-04-27 10:08:34','2028-04-27',633),('9756 1780 6214 5728','9567-51092-8522','Cliente5',25,'2025-04-27 10:09:26','2028-04-27',999);
/*!40000 ALTER TABLE `tarjeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Juan Pérez',NULL,'555-1234','juan.perez@example.com','1990-05-15','SOCIO','ACTIVO','094e8e159db7824161b1e67ab209da503434c626'),(2,'Maria',NULL,'44444444','maria@ejemplo.com','2005-04-04','SOCIO','ACTIVO','011c945f30ce2cbafc452f39840f025693339c42');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios_cuenta_juridica`
--

DROP TABLE IF EXISTS `usuarios_cuenta_juridica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
-- Dumping data for table `usuarios_cuenta_juridica`
--

LOCK TABLES `usuarios_cuenta_juridica` WRITE;
/*!40000 ALTER TABLE `usuarios_cuenta_juridica` DISABLE KEYS */;
INSERT INTO `usuarios_cuenta_juridica` VALUES ('Luis','Fernando',NULL,'Gómez','Martínez',NULL,'Gerente Financiero','1234567890101','lgomez@empresa.com',1),('María',NULL,NULL,'Sánchez','Ramírez',NULL,'Asesora Jurídica','9876543210202','msanchez@corporativo.com',2),('Carlos','Emilio',NULL,'Pérez',NULL,NULL,'Director de Operaciones','4567891230303','cperez@negocios.com',3),('Lucía',NULL,NULL,'Ramírez','Castillo',NULL,'Analista Contable','3216549870404','lramirez@consultoria.com',4),('Gabriel','Antonio',NULL,'Ortega','Muñoz',NULL,'Supervisor de Ventas','6543217890505','gortega@empresa.com',5);
/*!40000 ALTER TABLE `usuarios_cuenta_juridica` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehiculos`
--

DROP TABLE IF EXISTS `vehiculos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
-- Dumping data for table `vehiculos`
--

LOCK TABLES `vehiculos` WRITE;
/*!40000 ALTER TABLE `vehiculos` DISABLE KEYS */;
INSERT INTO `vehiculos` VALUES (1,'Toyota','Corolla',2015,30000.00,'Sedán','USO_PERSONAL',2,'P12345','PAGADO','2023-05-15','NUEVO','APROBADO',1),(2,'Chevrolet','Camaro',2010,15000.00,'Hatchback','USO_COMERCIAL',0,'C67890','EN_PROCESO_DE_PAGO','2022-08-20','USADO','APROBADO',1);
/*!40000 ALTER TABLE `vehiculos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vistaclientescuentas`
--

DROP TABLE IF EXISTS `vistaclientescuentas`;
/*!50001 DROP VIEW IF EXISTS `vistaclientescuentas`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vistaclientescuentas` AS SELECT 
 1 AS `id_clientes`,
 1 AS `cuenta_aportes`,
 1 AS `monto_aportes`,
 1 AS `cuenta_ahorro`,
 1 AS `monto_ahorro`,
 1 AS `cuenta_monetaria`,
 1 AS `monto_monetaria`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vistamovbancarios`
--

DROP TABLE IF EXISTS `vistamovbancarios`;
/*!50001 DROP VIEW IF EXISTS `vistamovbancarios`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vistamovbancarios` AS SELECT 
 1 AS `id_clientes`,
 1 AS `cuenta_aportes`,
 1 AS `monto_aportes`,
 1 AS `cuenta_ahorro`,
 1 AS `monto_ahorro`,
 1 AS `cuenta_monetaria`,
 1 AS `monto_monetaria`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'cooperativa_db'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `AbonoInteresAhorro` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `AbonoInteresAhorro` ON SCHEDULE EVERY 1 YEAR STARTS '2025-04-28 00:00:00' ON COMPLETION NOT PRESERVE ENABLE DO CALL CalcularYAbonarIntereses() */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'cooperativa_db'
--
/*!50003 DROP PROCEDURE IF EXISTS `apertura_cuentas_aportes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
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
