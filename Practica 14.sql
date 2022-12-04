/*Creacion usuario QA para MDY2131_P14_2*/
/*Se hace en ADMIN*/
CREATE USER MDY2131_P14_2 IDENTIFIED BY "MDY2131.practica_14_2"
DEFAULT TABLESPACE "DATA"
TEMPORARY TABLESPACE "TEMP";
ALTER USER MDY2131_P14_2 QUOTA 100M ON DATA;
GRANT CREATE SESSION TO MDY2131_P14_2;
/*Privilegios*/
GRANT SELECT ON MDY2131_P14_1.APORTE_A_SBIF TO MDY2131_P14_2;
GRANT SELECT ON MDY2131_P14_1.CLIENTE TO MDY2131_P14_2;
GRANT SELECT ON MDY2131_P14_1.COMUNA TO MDY2131_P14_2;
GRANT SELECT ON MDY2131_P14_1.CREDITO TO MDY2131_P14_2;
GRANT SELECT ON MDY2131_P14_1.CREDITO_CLIENTE TO MDY2131_P14_2;
GRANT SELECT ON MDY2131_P14_1.CUOTA_CREDITO_CLIENTE TO MDY2131_P14_2;
GRANT SELECT ON MDY2131_P14_1.FORMA_PAGO TO MDY2131_P14_2;
GRANT SELECT ON MDY2131_P14_1.MOVIMIENTO TO MDY2131_P14_2;
GRANT SELECT ON MDY2131_P14_1.PRODUCTO_INVERSION TO MDY2131_P14_2;
GRANT SELECT ON MDY2131_P14_1.PRODUCTO_INVERSION_CLIENTE TO MDY2131_P14_2;
GRANT SELECT ON MDY2131_P14_1.PROFESION_OFICIO TO MDY2131_P14_2;
GRANT SELECT ON MDY2131_P14_1.PROVINCIA TO MDY2131_P14_2;
GRANT SELECT ON MDY2131_P14_1.REGION TO MDY2131_P14_2;
GRANT SELECT ON MDY2131_P14_1.SUCURSAL TO MDY2131_P14_2;
GRANT SELECT ON MDY2131_P14_1.TIPO_CONTRATO TO MDY2131_P14_2;

GRANT INDEX ON MDY2131_P14_1.APORTE_A_SBIF TO MDY2131_P14_2;
GRANT INDEX ON MDY2131_P14_1.CLIENTE TO MDY2131_P14_2;
GRANT INDEX ON MDY2131_P14_1.COMUNA TO MDY2131_P14_2;
GRANT INDEX ON MDY2131_P14_1.CREDITO TO MDY2131_P14_2;
GRANT INDEX ON MDY2131_P14_1.CREDITO_CLIENTE TO MDY2131_P14_2;
GRANT INDEX ON MDY2131_P14_1.CUOTA_CREDITO_CLIENTE TO MDY2131_P14_2;
GRANT INDEX ON MDY2131_P14_1.FORMA_PAGO TO MDY2131_P14_2;
GRANT INDEX ON MDY2131_P14_1.MOVIMIENTO TO MDY2131_P14_2;
GRANT INDEX ON MDY2131_P14_1.PRODUCTO_INVERSION TO MDY2131_P14_2;
GRANT INDEX ON MDY2131_P14_1.PRODUCTO_INVERSION_CLIENTE TO MDY2131_P14_2;
GRANT INDEX ON MDY2131_P14_1.PROFESION_OFICIO TO MDY2131_P14_2;
GRANT INDEX ON MDY2131_P14_1.PROVINCIA TO MDY2131_P14_2;
GRANT INDEX ON MDY2131_P14_1.REGION TO MDY2131_P14_2;
GRANT INDEX ON MDY2131_P14_1.SUCURSAL TO MDY2131_P14_2;
GRANT INDEX ON MDY2131_P14_1.TIPO_CONTRATO TO MDY2131_P14_2;
/*Creacion de vista*/
GRANT CREATE VIEW TO MDY2131_P14_1;

/*Sacado de Guias*/
/*Se ejecuta en P_14_1*/
/*1*/
CREATE VIEW V_CLIENTES_CON_MAS_PROD_INV AS
SELECT EXTRACT(YEAR FROM SYSDATE) "AÃ‘O TRIBUTARIO",
       TO_CHAR(c.numrun,'09G999G999') || '-' || UPPER(c.dvrun) "RUN CLIENTE",
       INITCAP(c.pnombre || ' ' || SUBSTR(c.snombre,1,1) || '. ' || c.appaterno || ' ' || c.apmaterno) "NOMBRE CLIENTE",
       COUNT(pic.nro_cliente) "TOTAL PROD. INV AFECTOS IMPTO",
       LPAD(TO_CHAR(SUM(pic.monto_total_ahorrado),'$999G999G999'),21, ' ') "MONTO TOTAL AHORRADO"
FROM cliente c JOIN producto_inversion_cliente pic
ON c.nro_cliente=pic.nro_cliente
WHERE pic.cod_prod_inv IN(30,35,40,45,50,55)
AND c.nro_cliente IN (SELECT MAX(COUNT(*))
                 FROM producto_inversion_cliente
                 GROUP BY nro_cliente)
GROUP BY numrun,c.dvrun,c.pnombre,c.snombre,c.appaterno,c.apmaterno
ORDER BY c.appaterno;

/*2*/
CREATE OR REPLACE VIEW V_CLIENTES_CREDIT_MAYOR_PROM AS
SELECT TO_CHAR(crc.fecha_otorga_cred,'MMYYYY') "MES TRANSACCIÃ“N",
       c.nombre_credito "TIPO CREDITO",
       SUM(crc.monto_credito) "MONTO SOLICITADO CREDITO",
       SUM(CASE WHEN crc.monto_credito BETWEEN 100000 AND 1000000 THEN ROUND(crc.monto_credito*0.01)
            WHEN crc.monto_credito BETWEEN 1000001 AND 2000000 THEN ROUND(crc.monto_credito*0.02)
            WHEN crc.monto_credito BETWEEN 2000001 AND 4000000 THEN ROUND(crc.monto_credito*0.03)
            WHEN crc.monto_credito BETWEEN 4000001 AND 6000000 THEN ROUND(crc.monto_credito*0.04)
       ELSE ROUND(crc.monto_credito*0.07) END) "APORTE A LA SBIF"
FROM credito_cliente crc JOIN credito c
ON crc.cod_credito=c.cod_credito
AND crc.monto_credito > (SELECT ROUND(AVG(monto_credito))
                          FROM credito_cliente)
GROUP BY TO_CHAR(crc.fecha_otorga_cred,'MMYYYY'), c.nombre_credito
ORDER BY TO_CHAR(crc.fecha_otorga_cred,'MMYYYY'), c.nombre_credito;
/*3*/
CREATE OR REPLACE VIEW V_CLIENTES_CON_MAS_PROD_INV AS
SELECT EXTRACT(YEAR FROM SYSDATE) "AÃ‘O TRIBUTARIO",
       TO_CHAR(c.numrun,'09G999G999') || '-' || UPPER(c.dvrun) "RUN CLIENTE",
       INITCAP(c.pnombre || ' ' || SUBSTR(c.snombre,1,1) || '. ' || c.appaterno || ' ' || c.apmaterno) "NOMBRE CLIENTE",
       COUNT(pic.nro_cliente) "TOTAL PROD. INV AFECTOS IMPTO",
       LPAD(TO_CHAR(SUM(pic.monto_total_ahorrado),'$999G999G999'),21, ' ') "MONTO TOTAL AHORRADO"
FROM cliente c JOIN producto_inversion_cliente pic
ON c.nro_cliente=pic.nro_cliente
WHERE pic.cod_prod_inv IN(30,35,40,45,50,55)
AND c.nro_cliente IN (SELECT MAX(COUNT(*))
                 FROM producto_inversion_cliente
                 GROUP BY nro_cliente)
GROUP BY numrun,c.dvrun,c.pnombre,c.snombre,c.appaterno,c.apmaterno
ORDER BY c.appaterno;
/*4*/
/*Solo un select simple*/
SELECT TO_CHAR(c.numrun,'09G999G999') || '-' || UPPER(c.dvrun) "RUN CLIENTE",
       INITCAP(c.pnombre || ' ' || c.snombre || ' ' || c.appaterno || ' ' || c.apmaterno) "NOMBRE CLIENTE",
       pi.nombre_prod_inv "PRODUCTO DE INVERSION",
       pic.monto_total_ahorrado "MONTO TOTAL AHORRADO"
FROM cliente c JOIN producto_inversion_cliente pic
ON c.nro_cliente = pic.nro_cliente
JOIN producto_inversion pi
ON pic.cod_prod_inv=pi.cod_prod_inv
AND EXTRACT(YEAR FROM pic.fecha_solic_prod)=EXTRACT(YEAR FROM SYSDATE)
AND c.cod_tipo_contrato = 1
ORDER BY c.appaterno;

/*Permisos*/
GRANT SELECT ON MDY2131_P14_1.V_CLIENTES_CON_MAS_PROD_INV TO MDY2131_P14_2;
GRANT SELECT ON MDY2131_P14_1.V_CLIENTES_CREDIT_MAYOR_PROM TO MDY2131_P14_2;
/*Manito de dios mortal*/
-- 4.- Informe que visualiza información de los clientes que poseen créditos con 
-- monto mayor al promedio: se debe generar índice para lograr un plan de 
-- ejecución como el que se presenta:

CREATE INDEX MDY2131_P14_1.IDX_CREDITO_CLIENTE ON MDY2131_P14_1.CREDITO_CLIENTE (MONTO_CREDITO) 
TABLESPACE "DATA" ;

-- 5.- Sentencia SQL que es parte del proceso que genera información al SII de 
-- los clientes dependientes que contrataron algún producto de inversión en 
-- KOPERA durante el año: se deben generar los índices para lograr un plan de 
-- ejecución como el que se presenta:

CREATE INDEX MDY2131_P14_1.IDX_PROD_CLIENTES_DEPEN ON MDY2131_P14_1.CLIENTE (CASE WHEN COD_TIPO_CONTRATO = 1 THEN COD_TIPO_CONTRATO ELSE NULL END)
TABLESPACE "DATA" ;

CREATE INDEX MDY2131_P14_1.IDX_PROD_INV_CLIENTES_ANUAL ON MDY2131_P14_1.PRODUCTO_INVERSION_CLIENTE (EXTRACT(YEAR FROM fecha_solic_prod))
TABLESPACE "DATA" ;