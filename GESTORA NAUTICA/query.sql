CREATE DATABASE gestion_nautica;
USE gestion_nautica;

CREATE TABLE tramites (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    APELLIDO VARCHAR(255),
    NOMBRE VARCHAR(255),
    CUIL VARCHAR(20),
    CLAVE_CIDI VARCHAR(20),
    TELEFONO VARCHAR(15),
    TRAMITE VARCHAR(50),
    MATRICULA VARCHAR(20),
    OTORGADO DATE
);

CREATE VIEW proximos_tramites AS
SELECT
    ID,
    APELLIDO,
    NOMBRE,
    CUIL,
    CLAVE_CIDI,
    TELEFONO,
    TRAMITE,
    MATRICULA,
    OTORGADO,
    CASE
        WHEN TRAMITE IN ('Licencia D', 'Licencia A', 'Licencia C', 'Licencia O') THEN OTORGADO + INTERVAL 5 YEAR
        WHEN TRAMITE IN ('Bianual', 'Matriculacion', 'Transferencia') THEN OTORGADO + INTERVAL 2 YEAR
        ELSE OTORGADO + INTERVAL 2 YEAR
    END AS VENCIMIENTO,
    DATEDIFF(
        CASE
            WHEN TRAMITE IN ('Licencia D', 'Licencia A', 'Licencia C', 'Licencia O') THEN OTORGADO + INTERVAL 5 YEAR
            WHEN TRAMITE IN ('Bianual', 'Matriculacion', 'Transferencia') THEN OTORGADO + INTERVAL 2 YEAR
            ELSE OTORGADO + INTERVAL 2 YEAR
        END,
        CURDATE()
    ) AS DIAS_RENOVACION
FROM tramites
WHERE TRAMITE <> 'INACTIVO'
  AND DATEDIFF(
        CASE
            WHEN TRAMITE IN ('Licencia D', 'Licencia A', 'Licencia C', 'Licencia O') THEN OTORGADO + INTERVAL 5 YEAR
            WHEN TRAMITE IN ('Bianual', 'Matriculacion', 'Transferencia') THEN OTORGADO + INTERVAL 2 YEAR
            ELSE OTORGADO + INTERVAL 2 YEAR
        END,
        CURDATE()
    ) >= 0
ORDER BY VENCIMIENTO ASC;

CREATE VIEW tramites_en_proceso AS
SELECT
    ID,
    APELLIDO,
    NOMBRE,
    CUIL,
    CLAVE_CIDI,
    TELEFONO,
    TRAMITE,
    MATRICULA,
    OTORGADO,
    CASE
        WHEN TRAMITE IN ('Licencia D', 'Licencia A', 'Licencia C', 'Licencia O') THEN OTORGADO + INTERVAL 5 YEAR
        WHEN TRAMITE IN ('Bianual', 'Matriculacion', 'Transferencia') THEN OTORGADO + INTERVAL 2 YEAR
        ELSE OTORGADO + INTERVAL 2 YEAR
    END AS VENCIMIENTO,
    DATEDIFF(
        CASE
            WHEN TRAMITE IN ('Licencia D', 'Licencia A', 'Licencia C', 'Licencia O') THEN OTORGADO + INTERVAL 5 YEAR
            WHEN TRAMITE IN ('Bianual', 'Matriculacion', 'Transferencia') THEN OTORGADO + INTERVAL 2 YEAR
            ELSE OTORGADO + INTERVAL 2 YEAR
        END,
        CURDATE()
    ) AS DIAS_RENOVACION
FROM tramites
WHERE TRAMITE <> 'INACTIVO'
  AND DATEDIFF(
        CASE
            WHEN TRAMITE IN ('Licencia D', 'Licencia A', 'Licencia C', 'Licencia O') THEN OTORGADO + INTERVAL 5 YEAR
            WHEN TRAMITE IN ('Bianual', 'Matriculacion', 'Transferencia') THEN OTORGADO + INTERVAL 2 YEAR
            ELSE OTORGADO + INTERVAL 2 YEAR
        END,
        CURDATE()
    ) < 0
ORDER BY VENCIMIENTO ASC;

USE gestion_nautica;
CREATE VIEW tramites_inactivos AS
SELECT
    ID,
    APELLIDO,
    NOMBRE,
    CUIL,
    CLAVE_CIDI,
    TELEFONO,
    TRAMITE,
    MATRICULA,
    OTORGADO,
    CASE
        WHEN TRAMITE IN ('Licencia D', 'Licencia A', 'Licencia C', 'Licencia O') THEN OTORGADO + INTERVAL 5 YEAR
        WHEN TRAMITE IN ('Bianual', 'Matriculacion', 'Transferencia') THEN OTORGADO + INTERVAL 2 YEAR
        ELSE OTORGADO + INTERVAL 2 YEAR
    END AS VENCIMIENTO,
    DATEDIFF(
        CASE
            WHEN TRAMITE IN ('Licencia D', 'Licencia A', 'Licencia C', 'Licencia O') THEN OTORGADO + INTERVAL 5 YEAR
            WHEN TRAMITE IN ('Bianual', 'Matriculacion', 'Transferencia') THEN OTORGADO + INTERVAL 2 YEAR
            ELSE OTORGADO + INTERVAL 2 YEAR
        END,
        CURDATE()
    ) AS DIAS_RENOVACION
FROM tramites
WHERE TRAMITE = 'INACTIVO'
ORDER BY VENCIMIENTO ASC;

