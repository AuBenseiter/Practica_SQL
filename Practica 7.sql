/*CASO 1*/
SELECT c.numrun||'-'||c.dvrun AS "RUN Cliente", 
    INITCAP(c.pnombre)||' '||INITCAP(c.snombre)||' '||INITCAP(c.appaterno)
    ||' '||INITCAP(c.apmaterno) AS "Nombre Cliente",
    TO_CHAR(c.fecha_nacimiento, 'DD')
    ||' '||TO_CHAR(c.fecha_nacimiento, 'Month') AS "Dia de Cumpleaños",
    c.direccion||'/'||UPPER(re.nombre_region) AS "Direccion"
FROM cliente c
    JOIN comuna co ON c.cod_region = co.cod_region
        AND c.cod_provincia = co.cod_provincia
        AND c.cod_comuna = co.cod_comuna
    JOIN region re ON c.cod_region = re.cod_region
    
WHERE EXTRACT(MONTH FROM c.fecha_nacimiento) = 9 --Forma correcta EXTRACT(MONTH FROM SYSDATE)
    AND c.cod_region = 13
;
/*CASO 2*/
SELECT c.numrun||'-'||c.dvrun AS "RUN Cliente", 
    (c.pnombre)||' '||(c.snombre)||' '||(c.appaterno)
    ||' '||(c.apmaterno) AS "Nombre Cliente",
    /*Sumo las transacciones sin considerar su tipo*/
    LPAD(TO_CHAR(SUM(ttc.monto_transaccion), '$999G999G999'), 25) AS "Monto Compras/Avances/S.Avances",
    /*sumo todos los totales del mismo cliente y calculo los puntos*/
    TO_CHAR((SUM(ttc.monto_total_transaccion)/10000)*250, '999G999G999G999') AS "Total Puntos Acumulados"
    /*(ttc.monto_total_transaccion/10000)*250*/
FROM cliente c
    JOIN tarjeta_cliente tc ON tc.numrun = c.numrun
    JOIN transaccion_tarjeta_cliente ttc ON ttc.nro_tarjeta = tc.nro_tarjeta
WHERE EXTRACT(YEAR FROM fecha_transaccion) = 2021 /*EXTRACT(YEAR FROM SYSDATE)-1*/
GROUP BY c.numrun, c.dvrun, c.pnombre, c.snombre, appaterno, c.apmaterno
ORDER BY "Total Puntos Acumulados" ASC, c.appaterno ASC 

;
/*Extraccion de informacion*/
select * from tarjeta_cliente;
select * from transaccion_tarjeta_cliente;
select * from tipo_transaccion_tarjeta;

/*caso 3*/
SELECT TO_CHAR(ttc.fecha_transaccion, 'MMYYYY') AS "Fecha Transaccion",
    ttt.nombre_tptran_tarjeta AS "Tipo de Transaccion",
    TO_CHAR(SUM(ttc.monto_total_transaccion), '$999G999G999'),
    TO_CHAR(SUM(ttc.monto_total_transaccion * (asb.porc_aporte_sbif/100)), '$999G999G999') "Aporte a la SBIF"
FROM transaccion_tarjeta_cliente ttc
    JOIN tipo_transaccion_tarjeta ttt ON ttc.cod_tptran_tarjeta = ttt.cod_tptran_tarjeta
    JOIN aporte_sbif asb ON ttc.monto_total_transaccion
                        BETWEEN asb.monto_inf_av_sav AND asb.MONTO_SUP_AV_SAV
WHERE ttt.cod_tptran_tarjeta <> 101
GROUP BY to_CHAR(ttc.fecha_transaccion,'MMYYYY')
    ,ttt.nombre_tptran_tarjeta
;

/*CASO 4*/
SELECT TO_CHAR(c.numrun, '999G999G999')||'-'||c.dvrun AS "RUN Cliente", 
    (c.pnombre)||' '||(c.snombre)||' '||(c.appaterno)
    ||' '||(c.apmaterno) AS "Nombre Cliente",
    LPAD(TO_CHAR(NVL(SUM(ttc.monto_total_transaccion),0),'$99G999G999'), 22) AS "Compras/Avances/S.Avances",
    CASE WHEN NVL(SUM(ttc.monto_total_transaccion),0) BETWEEN 0 AND 100000 THEN 'SIN CATEGORIZACION'
    WHEN NVL(SUM(ttc.monto_total_transaccion),0) BETWEEN 100001 AND 1000000 THEN 'BRONCE'
    WHEN NVL(SUM(ttc.monto_total_transaccion),0) BETWEEN 1000001 AND 4000000 THEN 'PLATA'
    WHEN NVL(SUM(ttc.monto_total_transaccion),0) BETWEEN 4000001 AND 8000000 THEN 'SILVER'
    WHEN NVL(SUM(ttc.monto_total_transaccion),0) BETWEEN 8000001 AND 15000000 THEN 'GOLD'
    WHEN NVL(SUM(ttc.monto_total_transaccion),0) > 15000000 THEN 'PLATINUM'
    END AS "Categorizacion del Cliente "
FROM cliente c
    /*recordar que es un iner join, trae todo lo que tenga un match*/
    JOIN tarjeta_cliente tc ON tc.numrun = c.numrun
    /*Para traer todos los cliente*/
    LEFT JOIN transaccion_tarjeta_cliente ttc ON ttc.nro_tarjeta = tc.nro_tarjeta
GROUP BY c.numrun, c.dvrun, c.pnombre, c.snombre, c.appaterno, c.apmaterno
ORDER BY c.appaterno,"Compras/Avances/S.Avances" DESC
;
select * from transaccion_tarjeta_cliente;
select * from tarjeta_cliente;

/*CASO 5*/
