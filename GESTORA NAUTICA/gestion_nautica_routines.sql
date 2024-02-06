-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: gestion_nautica
-- ------------------------------------------------------
-- Server version	8.0.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `tramites_inactivos`
--

DROP TABLE IF EXISTS `tramites_inactivos`;
/*!50001 DROP VIEW IF EXISTS `tramites_inactivos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `tramites_inactivos` AS SELECT 
 1 AS `ID`,
 1 AS `APELLIDO`,
 1 AS `NOMBRE`,
 1 AS `CUIL`,
 1 AS `CLAVE_CIDI`,
 1 AS `TELEFONO`,
 1 AS `TRAMITE`,
 1 AS `MATRICULA`,
 1 AS `OTORGADO`,
 1 AS `VENCIMIENTO`,
 1 AS `DIAS_RENOVACION`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `tramites_en_proceso`
--

DROP TABLE IF EXISTS `tramites_en_proceso`;
/*!50001 DROP VIEW IF EXISTS `tramites_en_proceso`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `tramites_en_proceso` AS SELECT 
 1 AS `ID`,
 1 AS `APELLIDO`,
 1 AS `NOMBRE`,
 1 AS `CUIL`,
 1 AS `CLAVE_CIDI`,
 1 AS `TELEFONO`,
 1 AS `TRAMITE`,
 1 AS `MATRICULA`,
 1 AS `OTORGADO`,
 1 AS `VENCIMIENTO`,
 1 AS `DIAS_RENOVACION`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `proximos_tramites`
--

DROP TABLE IF EXISTS `proximos_tramites`;
/*!50001 DROP VIEW IF EXISTS `proximos_tramites`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `proximos_tramites` AS SELECT 
 1 AS `ID`,
 1 AS `APELLIDO`,
 1 AS `NOMBRE`,
 1 AS `CUIL`,
 1 AS `CLAVE_CIDI`,
 1 AS `TELEFONO`,
 1 AS `TRAMITE`,
 1 AS `MATRICULA`,
 1 AS `OTORGADO`,
 1 AS `VENCIMIENTO`,
 1 AS `DIAS_RENOVACION`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `tramites_inactivos`
--

/*!50001 DROP VIEW IF EXISTS `tramites_inactivos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `tramites_inactivos` AS select `tramites`.`ID` AS `ID`,`tramites`.`APELLIDO` AS `APELLIDO`,`tramites`.`NOMBRE` AS `NOMBRE`,`tramites`.`CUIL` AS `CUIL`,`tramites`.`CLAVE_CIDI` AS `CLAVE_CIDI`,`tramites`.`TELEFONO` AS `TELEFONO`,`tramites`.`TRAMITE` AS `TRAMITE`,`tramites`.`MATRICULA` AS `MATRICULA`,`tramites`.`OTORGADO` AS `OTORGADO`,(case when (`tramites`.`TRAMITE` in ('Licencia D','Licencia A','Licencia C','Licencia O')) then (`tramites`.`OTORGADO` + interval 5 year) when (`tramites`.`TRAMITE` in ('Bianual','Matriculacion','Transferencia')) then (`tramites`.`OTORGADO` + interval 2 year) else (`tramites`.`OTORGADO` + interval 2 year) end) AS `VENCIMIENTO`,(to_days((case when (`tramites`.`TRAMITE` in ('Licencia D','Licencia A','Licencia C','Licencia O')) then (`tramites`.`OTORGADO` + interval 5 year) when (`tramites`.`TRAMITE` in ('Bianual','Matriculacion','Transferencia')) then (`tramites`.`OTORGADO` + interval 2 year) else (`tramites`.`OTORGADO` + interval 2 year) end)) - to_days(curdate())) AS `DIAS_RENOVACION` from `tramites` where (`tramites`.`TRAMITE` = 'INACTIVO') order by (case when (`tramites`.`TRAMITE` in ('Licencia D','Licencia A','Licencia C','Licencia O')) then (`tramites`.`OTORGADO` + interval 5 year) when (`tramites`.`TRAMITE` in ('Bianual','Matriculacion','Transferencia')) then (`tramites`.`OTORGADO` + interval 2 year) else (`tramites`.`OTORGADO` + interval 2 year) end) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `tramites_en_proceso`
--

/*!50001 DROP VIEW IF EXISTS `tramites_en_proceso`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `tramites_en_proceso` AS select `tramites`.`ID` AS `ID`,`tramites`.`APELLIDO` AS `APELLIDO`,`tramites`.`NOMBRE` AS `NOMBRE`,`tramites`.`CUIL` AS `CUIL`,`tramites`.`CLAVE_CIDI` AS `CLAVE_CIDI`,`tramites`.`TELEFONO` AS `TELEFONO`,`tramites`.`TRAMITE` AS `TRAMITE`,`tramites`.`MATRICULA` AS `MATRICULA`,`tramites`.`OTORGADO` AS `OTORGADO`,(case when (`tramites`.`TRAMITE` in ('Licencia D','Licencia A','Licencia C','Licencia O')) then (`tramites`.`OTORGADO` + interval 5 year) when (`tramites`.`TRAMITE` in ('Bianual','Matriculacion','Transferencia')) then (`tramites`.`OTORGADO` + interval 2 year) else (`tramites`.`OTORGADO` + interval 2 year) end) AS `VENCIMIENTO`,(to_days((case when (`tramites`.`TRAMITE` in ('Licencia D','Licencia A','Licencia C','Licencia O')) then (`tramites`.`OTORGADO` + interval 5 year) when (`tramites`.`TRAMITE` in ('Bianual','Matriculacion','Transferencia')) then (`tramites`.`OTORGADO` + interval 2 year) else (`tramites`.`OTORGADO` + interval 2 year) end)) - to_days(curdate())) AS `DIAS_RENOVACION` from `tramites` where ((`tramites`.`TRAMITE` <> 'INACTIVO') and ((to_days((case when (`tramites`.`TRAMITE` in ('Licencia D','Licencia A','Licencia C','Licencia O')) then (`tramites`.`OTORGADO` + interval 5 year) when (`tramites`.`TRAMITE` in ('Bianual','Matriculacion','Transferencia')) then (`tramites`.`OTORGADO` + interval 2 year) else (`tramites`.`OTORGADO` + interval 2 year) end)) - to_days(curdate())) < 0)) order by (case when (`tramites`.`TRAMITE` in ('Licencia D','Licencia A','Licencia C','Licencia O')) then (`tramites`.`OTORGADO` + interval 5 year) when (`tramites`.`TRAMITE` in ('Bianual','Matriculacion','Transferencia')) then (`tramites`.`OTORGADO` + interval 2 year) else (`tramites`.`OTORGADO` + interval 2 year) end) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `proximos_tramites`
--

/*!50001 DROP VIEW IF EXISTS `proximos_tramites`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `proximos_tramites` AS select `tramites`.`ID` AS `ID`,`tramites`.`APELLIDO` AS `APELLIDO`,`tramites`.`NOMBRE` AS `NOMBRE`,`tramites`.`CUIL` AS `CUIL`,`tramites`.`CLAVE_CIDI` AS `CLAVE_CIDI`,`tramites`.`TELEFONO` AS `TELEFONO`,`tramites`.`TRAMITE` AS `TRAMITE`,`tramites`.`MATRICULA` AS `MATRICULA`,`tramites`.`OTORGADO` AS `OTORGADO`,(case when (`tramites`.`TRAMITE` in ('Licencia D','Licencia A','Licencia C','Licencia O')) then (`tramites`.`OTORGADO` + interval 5 year) when (`tramites`.`TRAMITE` in ('Bianual','Matriculacion','Transferencia')) then (`tramites`.`OTORGADO` + interval 2 year) else (`tramites`.`OTORGADO` + interval 2 year) end) AS `VENCIMIENTO`,(to_days((case when (`tramites`.`TRAMITE` in ('Licencia D','Licencia A','Licencia C','Licencia O')) then (`tramites`.`OTORGADO` + interval 5 year) when (`tramites`.`TRAMITE` in ('Bianual','Matriculacion','Transferencia')) then (`tramites`.`OTORGADO` + interval 2 year) else (`tramites`.`OTORGADO` + interval 2 year) end)) - to_days(curdate())) AS `DIAS_RENOVACION` from `tramites` where ((`tramites`.`TRAMITE` <> 'INACTIVO') and ((to_days((case when (`tramites`.`TRAMITE` in ('Licencia D','Licencia A','Licencia C','Licencia O')) then (`tramites`.`OTORGADO` + interval 5 year) when (`tramites`.`TRAMITE` in ('Bianual','Matriculacion','Transferencia')) then (`tramites`.`OTORGADO` + interval 2 year) else (`tramites`.`OTORGADO` + interval 2 year) end)) - to_days(curdate())) >= 0)) order by (case when (`tramites`.`TRAMITE` in ('Licencia D','Licencia A','Licencia C','Licencia O')) then (`tramites`.`OTORGADO` + interval 5 year) when (`tramites`.`TRAMITE` in ('Bianual','Matriculacion','Transferencia')) then (`tramites`.`OTORGADO` + interval 2 year) else (`tramites`.`OTORGADO` + interval 2 year) end) */;
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

-- Dump completed on 2024-02-06 11:18:16
