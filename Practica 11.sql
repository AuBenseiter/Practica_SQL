/*No funciona debido a que no tiene los permisos*/
SELECT * FROM MDY2131_P11_1.COMUNA;
/*No funciona poruqe no existe en la base de datos P11_2*/
SELECT * FROM CLIENTE;
/*Funciona porque se les dio los permisos al usuario P11_2 de ver*/
/*las tabalas del usuaio P11_1*/
SELECT * FROM MDY2131_P11_1.CLIENTE;
/*No se puede borrar la tabala porque los permisos eran de solo SELECT*/
DROP TABLE MDY2131_P11_1.CLIENTE;

/*CASO 1*/
--Ejecutado de de el 11_1
create or replace view v_MBY2131_P11_1
AS SELECT 
    TO_CHAR(numrun, '999G999G999G')||'-'||dvrun AS "Run Cliente",
    pnombre||' '||snombre||' '||appaterno||' '||apmaterno AS "Nombbre",
    po.nombre_prof_ofic,
    tc.nombre_tipo_contrato,
    TO_CHAR(sum(pic.monto_total_ahorrado), '$999G999G999G999') AS "Monto Total Ahorrado",
    (CASE 
        WHEN sum(pic.monto_total_ahorrado) BETWEEN 100000 AND 1000000
            THEN 'Bronce'
         WHEN sum(pic.monto_total_ahorrado) BETWEEN 1000001 AND 4000000
            THEN 'Plata'
         WHEN sum(pic.monto_total_ahorrado) BETWEEN 4000001 AND 8000000
            THEN 'Silver'
         WHEN sum(pic.monto_total_ahorrado) BETWEEN 8000001 AND 15000000
            THEN 'Gold'
        WHEN sum(pic.monto_total_ahorrado) > 15000001 
            THEN 'Platinum'
        ELSE 'Sin Categoria'
        END) AS "Categoria Cliente"   
FROM cliente c
    JOIN profesion_oficio po ON c.cod_prof_ofic = po.cod_prof_ofic
    JOIN tipo_contrato tc ON c.cod_tipo_contrato = tc.cod_tipo_contrato
    JOIN producto_inversion_cliente pic ON c.nro_cliente = pic.nro_cliente
GROUP BY c.numrun, c.dvrun,
    c.pnombre,c.snombre,c.appaterno,c.apmaterno,
    po.nombre_prof_ofic,
    tc.nombre_tipo_contrato
ORDER BY "Run Cliente" ASC, "Monto Total Ahorrado" DESC
;
/*Prueba de informe 1*/
SELECT *
FROM v_MBY2131_P11_1
;
/*INFORME 2*/
create or replace view v_MBY2131_P11_2
AS SELECT 
    TO_CHAR(c.fecha_otorga_cred, 'mmyyyy') AS "Mes Transaccion",
    cre.nombre_credito AS "Tipo Credito",
    SUM(c.monto_credito) AS "Monto Solicitado Credito",
    SUM(c.monto_credito*(aas.porc_entrega_sbif/100)) AS "Aporte a la SBIF"
FROM MDY2131_P11_1.CREDITO_CLIENTE c
    JOIN MDY2131_P11_1.CREDITO cre ON c.cod_credito = cre.cod_credito
    JOIN MDY2131_P11_1.APORTE_A_SBIF aas ON c.monto_credito BETWEEN monto_credito_desde AND monto_credito_hasta
WHERE EXTRACT(YEAR FROM fecha_otorga_cred) = EXTRACT(YEAR FROM SYSDATE)-1
    AND EXTRACT(MONTH FROM c.fecha_otorga_cred) = EXTRACT(MONTH FROM c.fecha_solic_cred)
    AND EXTRACT(DAY FROM c.fecha_solic_cred) < EXTRACT(DAY FROM c.fecha_solic_cred)+5
GROUP BY cre.nombre_credito, TO_CHAR(c.fecha_otorga_cred, 'mmyyyy')
ORDER BY "Mes Transaccion", "Tipo Credito"
;
/*Prueba de vista*/
select * from v_MBY2131_P11_2;