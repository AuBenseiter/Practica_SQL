/*Caso 1*/
/** CREACION PERFILES */
/*Due?o*/
/*Perfil*/
CREATE PROFILE PRO_ADMIN LIMIT
SESSIONS_PER_USER 1
FAILED_LOGIN_ATTEMPTS 10
PASSWORD_LIFE_TIME 120;
/*Creacion*/
CREATE USER MDY2131_P13_1 IDENTIFIED BY "MDY2131.practica_13_1"
DEFAULT TABLESPACE "DATA"
TEMPORARY TABLESPACE "TEMP";
ALTER USER MDY2131_P13_1 QUOTA UNLIMITED ON DATA PROFILE PRO_ADMIN;
GRANT CREATE SESSION TO MDY2131_P13_1;
GRANT "RESOURCE" TO MDY2131_P13_1;
ALTER USER MDY2131_P13_1 DEFAULT ROLE "RESOURCE";
GRANT CREATE VIEW TO MDY2131_P13_1;
/*ROL*/
CREATE ROLE ROL_ADMIN;
GRANT CREATE ANY TABLE, UPDATE ANY TABLE, DROP ANY TABLE, CREATE ANY SYNONYM,
    CREATE ANY SEQUENCE, CREATE ANY INDEX, ALTER DATABASE TO ROL_ADMIN;
GRANT ROL_ADMIN TO MDY2131_P13_1;
ALTER USER MDY2131_P13_1 DEFAULT ROLE ROL_ADMIN
;
/*Permiso para crear sinonimos*/
GRANT SELECT ON dba_tables TO MDY2131_P13_2;
CREATE OR REPLACE PUBLIC SYNONYM syn_c
FOR MDY2131_P13_1.CLIENTE;
CREATE OR REPLACE PUBLIC SYNONYM syn_cc
FOR MDY2131_P13_1.CREDITO_CLIENTE;
/*Desarrollo*/
/*Perfil*/
CREATE PROFILE PRO_DESARROLLADOR LIMIT
SESSIONS_PER_USER 2
CONNECT_TIME 240
IDLE_TIME 60
FAILED_LOGIN_ATTEMPTS 5
PASSWORD_LOCK_TIME 1
PASSWORD_LIFE_TIME 90;
/*Creacion*/
/*13_2*/
DROP USER MDY2131_P13_3;
CREATE USER MDY2131_P13_2 IDENTIFIED BY "MDY2131.practica_13_2"
DEFAULT TABLESPACE "DATA"
TEMPORARY TABLESPACE "TEMP";
ALTER USER MDY2131_P13_2 QUOTA UNLIMITED ON DATA PROFILE PRO_DESARROLLADOR;

/*13_3*/
CREATE USER MDY2131_P13_3 IDENTIFIED BY "MDY2131.practica_13_3"
DEFAULT TABLESPACE "DATA"
TEMPORARY TABLESPACE "TEMP";
ALTER USER MDY2131_P13_3 QUOTA UNLIMITED ON DATA PROFILE PRO_DESARROLLADOR;
/*Rol y Permisos*/
CREATE ROLE ROL_DESARROLLO;
GRANT CREATE ANY VIEW, CREATE ANY TRIGGER, CREATE ANY PROCEDURE, CREATE ANY MATERIALIZED VIEW TO ROL_DESARROLLO;
GRANT INSERT, UPDATE, DELETE ON MDY2131_P13_1.CREDITO_CLIENTE TO ROL_DESARROLLO;
GRANT INSERT, UPDATE, DELETE ON MDY2131_P13_1.PRODUCTO_INVERSION_CLIENTE TO ROL_DESARROLLO;
GRANT INSERT, UPDATE, DELETE ON MDY2131_P13_1.CUOTA_CREDITO_CLIENTE TO ROL_DESARROLLO;
GRANT CREATE SESSION TO MDY2131_P13_2, MDY2131_P13_3;
GRANT ROL_DESARROLLO TO MDY2131_P13_2, MDY2131_P13_3;
ALTER USER MDY2131_P13_3 DEFAULT ROLE ROL_DESARROLLO;
ALTER USER MDY2131_P13_2 DEFAULT ROLE ROL_DESARROLLO;
GRANT SELECT ON MDY2131_P13_1.CREDITO TO ROL_DESARROLLO;
GRANT SELECT ON MDY2131_P13_1.TIPO_CONTRATO TO ROL_DESARROLLO;
GRANT SELECT ON MDY2131_P13_1.REGION TO ROL_DESARROLLO;
GRANT SELECT ON MDY2131_P13_1.PROVINCIA TO ROL_DESARROLLO;
GRANT SELECT ON MDY2131_P13_1.COMUNA TO ROL_DESARROLLO;
GRANT SELECT ON MDY2131_P13_1.PROFESION_OFICIO TO ROL_DESARROLLO;
GRANT SELECT ON MDY2131_P13_1.CLIENTE TO ROL_DESARROLLO;
GRANT SELECT ON MDY2131_P13_1.PRODUCTO_INVERSION_CLIENTE TO ROL_DESARROLLO;
GRANT SELECT ON MDY2131_P13_1.TIPO_MOVIMIENTO TO ROL_DESARROLLO;
GRANT SELECT ON MDY2131_P13_1.MOVIMIENTO TO ROL_DESARROLLO;
GRANT SELECT ON MDY2131_P13_1.CREDITO_CLIENTE TO ROL_DESARROLLO;
GRANT SELECT ON MDY2131_P13_1.FORMA_PAGO TO ROL_DESARROLLO;
GRANT SELECT ON MDY2131_P13_1.CUOTA_CREDITO_CLIENTE TO ROL_DESARROLLO;
GRANT SELECT ON MDY2131_P13_1.SUCURSAL TO ROL_DESARROLLO;
GRANT SELECT ON MDY2131_P13_1.APORTE_A_SBIF TO ROL_DESARROLLO;
GRANT SELECT ON MDY2131_P13_1.PRODUCTO_INVERSION TO ROL_DESARROLLO;
/*Humanos y Transacciones*/
/*Perfil*/
CREATE PROFILE PRO_COMUN LIMIT
SESSIONS_PER_USER 3
CONNECT_TIME 120
IDLE_TIME 20
FAILED_LOGIN_ATTEMPTS 2
PASSWORD_LOCK_TIME 1
PASSWORD_LIFE_TIME 90
PASSWORD_GRACE_TIME 1;
/*Creacion*/
/*13_4*/
CREATE USER MDY2131_P13_4 IDENTIFIED BY "MDY2131.practica_13_4"
DEFAULT TABLESPACE "DATA"
TEMPORARY TABLESPACE "TEMP";
ALTER USER MDY2131_P13_4 QUOTA UNLIMITED ON DATA PROFILE PRO_COMUN;
/*13_5*/
CREATE USER MDY2131_P13_5 IDENTIFIED BY "MDY2131.practica_13_5"
DEFAULT TABLESPACE "DATA"
TEMPORARY TABLESPACE "TEMP";
ALTER USER MDY2131_P13_5 QUOTA UNLIMITED ON DATA PROFILE PRO_COMUN;
/*13_6*/
CREATE USER MDY2131_P13_6 IDENTIFIED BY "MDY2131.practica_13_6"
DEFAULT TABLESPACE "DATA"
TEMPORARY TABLESPACE "TEMP";
ALTER USER MDY2131_P13_6 QUOTA UNLIMITED ON DATA PROFILE PRO_COMUN;
/*Rol*/
/*13_4*/
CREATE ROLE ROL_HUMAN;
GRANT SELECT ON MDY2131_P13_1.TIPO_MOVIMIENTO TO ROL_HUMAN;
GRANT SELECT ON MDY2131_P13_1.SUCURSAL TO ROL_HUMAN;
GRANT SELECT ON MDY2131_P13_1.TIPO_CONTRATO TO ROL_HUMAN;
GRANT SELECT ON MDY2131_P13_1.CLIENTE TO ROL_HUMAN;
GRANT SELECT ON MDY2131_P13_1.REGION TO ROL_HUMAN;
GRANT SELECT ON MDY2131_P13_1.PROVINCIA TO ROL_HUMAN;
GRANT SELECT ON MDY2131_P13_1.COMUNA TO ROL_HUMAN;
GRANT CREATE SESSION TO MDY2131_P13_4;
GRANT ROL_HUMAN TO MDY2131_P13_4;
ALTER USER MDY2131_P13_4 DEFAULT ROLE ROL_HUMAN;
/*13_5 and 13_6*/
CREATE ROLE ROL_TRANSA;
GRANT SELECT ON MDY2131_P13_1.COMUNA TO ROL_TRANSA;
GRANT SELECT ON MDY2131_P13_1.REGION TO ROL_TRANSA;
GRANT SELECT ON MDY2131_P13_1.PROVINCIA TO ROL_TRANSA;
GRANT SELECT ON MDY2131_P13_1.CLIENTE TO ROL_TRANSA;
GRANT CREATE SESSION TO MDY2131_P13_5, MDY2131_P13_6;
GRANT ROL_TRANSA TO MDY2131_P13_5, MDY2131_P13_6;
ALTER USER MDY2131_P13_5 DEFAULT ROLE ROL_TRANSA;
ALTER USER MDY2131_P13_6 DEFAULT ROLE ROL_TRANSA;


/*CASO 1*/
CREATE SYNONYM MDY2131_P13_2.SYN_T_CONT FOR MDY2131_P13_1.TIPO_CONTRATO;
CREATE SYNONYM MDY2131_P13_2.SYN_R FOR MDY2131_P13_1.REGION;
CREATE SYNONYM MDY2131_P13_2.SYN_P FOR MDY2131_P13_1.PROVINCIA;
CREATE SYNONYM MDY2131_P13_2.SYN_CO FOR MDY2131_P13_1.COMUNA;
CREATE SYNONYM MDY2131_P13_2.SYN_PROF_OF FOR MDY2131_P13_1.PROFESION_OFICIO;
CREATE SYNONYM MDY2131_P13_2.SYN_C FOR MDY2131_P13_1.CLIENTE;
CREATE SYNONYM MDY2131_P13_2.SYN_PROD_INV_CLI FOR MDY2131_P13_1.PRODUCTO_INVERSION_CLIENTE;
CREATE SYNONYM MDY2131_P13_2.SYN_T_MOV FOR MDY2131_P13_1.TIPO_MOVIMIENTO;
CREATE SYNONYM MDY2131_P13_2.SYN_MOV FOR MDY2131_P13_1.MOVIMIENTO;
CREATE SYNONYM MDY2131_P13_2.SYN_CC FOR MDY2131_P13_1.CREDITO_CLIENTE;
CREATE SYNONYM MDY2131_P13_2.SYN_F_PAGO FOR MDY2131_P13_1.FORMA_PAGO;
CREATE SYNONYM MDY2131_P13_2.SYN_CT_CRED_CLI FOR MDY2131_P13_1.CUOTA_CREDITO_CLIENTE;
CREATE SYNONYM MDY2131_P13_2.SYN_SUC FOR MDY2131_P13_1.SUCURSAL;
CREATE SYNONYM MDY2131_P13_2.SYN_A_SBIF FOR MDY2131_P13_1.APORTE_A_SBIF;
CREATE SYNONYM MDY2131_P13_2.SYN_PROD_INV FOR MDY2131_P13_1.PRODUCTO_INVERSION;

CREATE SYNONYM MDY2131_P13_3.SYN_CRED FOR MDY2131_P13_1.CREDITO;
CREATE SYNONYM MDY2131_P13_3.SYN_T_CONT FOR MDY2131_P13_1.TIPO_CONTRATO;
CREATE SYNONYM MDY2131_P13_3.SYN_R FOR MDY2131_P13_1.REGION;
CREATE SYNONYM MDY2131_P13_3.SYN_P FOR MDY2131_P13_1.PROVINCIA;
CREATE SYNONYM MDY2131_P13_3.SYN_CO FOR MDY2131_P13_1.COMUNA;
CREATE SYNONYM MDY2131_P13_3.SYN_PROF_OF FOR MDY2131_P13_1.PROFESION_OFICIO;
CREATE SYNONYM MDY2131_P13_3.SYN_C FOR MDY2131_P13_1.CLIENTE;
CREATE SYNONYM MDY2131_P13_3.SYN_PROD_INV_CLI FOR MDY2131_P13_1.PRODUCTO_INVERSION_CLIENTE;
CREATE SYNONYM MDY2131_P13_3.SYN_T_MOV FOR MDY2131_P13_1.TIPO_MOVIMIENTO;
CREATE SYNONYM MDY2131_P13_3.SYN_MOV FOR MDY2131_P13_1.MOVIMIENTO;
CREATE SYNONYM MDY2131_P13_3.SYN_CC FOR MDY2131_P13_1.CREDITO_CLIENTE;
CREATE SYNONYM MDY2131_P13_3.SYN_F_PAGO FOR MDY2131_P13_1.FORMA_PAGO;
CREATE SYNONYM MDY2131_P13_3.SYN_CT_CRED_CLI FOR MDY2131_P13_1.CUOTA_CREDITO_CLIENTE;
CREATE SYNONYM MDY2131_P13_3.SYN_SUC FOR MDY2131_P13_1.SUCURSAL;
CREATE SYNONYM MDY2131_P13_3.SYN_A_SBIF FOR MDY2131_P13_1.APORTE_A_SBIF;
CREATE SYNONYM MDY2131_P13_3.SYN_PROD_INV FOR MDY2131_P13_1.PRODUCTO_INVERSION;