/*CASO 1*/
SELECT TO_CHAR(c.numrun, '999G999G999')||'-'||c.dvrun AS "RUN Cliente", 
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
SELECT TO_CHAR(c.numrun, '999G999G999')||'-'||c.dvrun AS "RUN Cliente", 
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
SELECT TO_CHAR(c.numrun, '999G999G999')||'-'||c.dvrun AS "Run Cliente",
    INITCAP(c.pnombre)||' '||SUBSTR(c.snombre,0,1)||'. '||
    INITCAP(c.appaterno)||' '||INITCAP(c.apmaterno) AS "Nombre Cliente"
    
FROM cliente c
    INNER JOIN tarjeta_cliente tc ON c.numrun = tc.numrun
    INNER JOIN transaccion_tarjeta_cliente ttc ON tc.nro_tarjeta = ttc.nro_tarjeta
    /*Solo para verificar el codigo de transaccion*/
    INNER JOIN tipo_transaccion_tarjeta ttt ON ttc.cod_tptran_tarjeta = ttt.cod_tptran_tarjeta
WHERE ttt.cod_tptran_tarjeta = 103
GROUP BY c.numrun, c.dvrun, c.pnombre, c.snombre, c.appaterno, c.apmaterno
ORDER BY appaterno
;
select * from transaccion_tarjeta_cliente;
select * from tipo_transaccion_tarjeta;

/*CASO 6*/

/*Informe 1*/
SELECT TO_CHAR(c.numrun, '999G999G999')||'-'||c.dvrun AS "Run Cliente",
    INITCAP(c.pnombre)||' '||SUBSTR(c.snombre, 0, 1)||'. '||
    INITCAP(c.appaterno)||' '||INITCAP(c.apmaterno) AS "Nombre Cliente",
    c.direccion AS "Direccion",
    prov.nombre_provincia AS "Provincia",
    reg.nombre_region AS "Region",
    /*1*/
    LPAD(COALESCE(COUNT(CASE ttc.cod_tptran_tarjeta
        WHEN 101 THEN ttc.nro_tarjeta
        ELSE null END), 0), 15) AS "Compras Vigentes",
    LPAD(COALESCE(TO_CHAR(SUM(CASE ttc.cod_tptran_tarjeta
        WHEN 101 THEN ttc.monto_total_transaccion
        ELSE null END),'$999G999G999G999'), '0'), 15) AS "Monto Total Compras",
    /*102*/
    LPAD(COALESCE(COUNT(CASE ttc.cod_tptran_tarjeta
        WHEN 102 THEN ttc.nro_tarjeta
        ELSE null END), 0), 15) AS "Avances Vigentes",
    LPAD(COALESCE(TO_CHAR(SUM(CASE ttc.cod_tptran_tarjeta
        WHEN 102 THEN ttc.monto_total_transaccion
        ELSE null END), '$999G999G999G999'), '0'), 15) AS "Monto Total Avances",
    /*103*/
    LPAD(COALESCE(COUNT(CASE ttc.cod_tptran_tarjeta
        WHEN 103 THEN ttc.nro_tarjeta
        ELSE null END), 0), 15) AS "Super Avances Vigentes",
    LPAD(COALESCE(TO_CHAR(SUM(CASE ttc.cod_tptran_tarjeta
        WHEN 103 THEN ttc.monto_total_transaccion
        ELSE null END), '$999G999G999G999'), '0'), 15) AS "Monto Total Super Avances"
    
FROM cliente c
    INNER JOIN region reg ON reg.cod_region = C.cod_region
    INNER JOIN TARJETA_CLIENTE TC ON tc.numrun = c.numrun
    INNER JOIN provincia prov ON prov.cod_provincia = c.cod_provincia
                        AND prov.cod_region = c.cod_region
    /*Para traer los null*/
    LEFT JOIN transaccion_tarjeta_cliente ttc ON tc.nro_tarjeta = ttc.nro_tarjeta
    /*Como tienen llave compuesta se generan los duplicados*/
    /*Forma "Correcta"*/
    /*INNER JOIN tarjeta_cliente tc ON c.numrun = tc.numrun
    INNER JOIN transaccion_tarjeta_cliente ttc ON tc.nro_tarjeta = ttc.nro_tarjeta
    INNER JOIN sucursal_retail sr ON ttc.id_sucursal = sr.id_sucursal
    INNER JOIN comuna co ON sr.cod_region = co.cod_region
                        AND sr.cod_provincia = co.cod_provincia
                        AND sr.cod_comuna = co.cod_comuna
    INNER JOIN provincia prov ON co.cod_provincia = prov.cod_provincia
                                AND co.cod_region = prov.cod_region
    INNER JOIN region reg ON prov.cod_region = reg.cod_region*/
GROUP BY c.numrun, c.dvrun, c.pnombre, c.snombre, c.appaterno, c.apmaterno,c.direccion,
    prov.nombre_provincia,
    reg.nombre_region
ORDER BY c.appaterno
;
select * from cliente;
select * from transaccion_tarjeta_cliente;
select * from tarjeta_cliente;
select * from sucursal_retail;
select * from tipo_transaccion_tarjeta;
select * from region;
select * from comuna;
select * from provincia;


