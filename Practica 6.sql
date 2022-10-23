u--CASO 1
SELECT TO_CHAR(cli.numrun, '999G999G999')||'-'||cli.dvrun AS "RUN Cliente",
    INITCAP(cli.pnombre)||' '||INITCAP(cli.snombre)||' '||
    INITCAP(cli.appaterno)||' '||INITCAP(cli.apmaterno) AS "Nombre Cliente",
    pro.nombre_prof_ofic AS "Profesion/Oficio",
    TO_CHAR(cli.fecha_nacimiento, 'DD')||' de '||
    TO_CHAR(cli.fecha_nacimiento, 'Month') AS "Dìa de Cumpleaños"
FROM cliente cli
    JOIN profesion_oficio pro ON pro.cod_prof_ofic = cli.cod_prof_ofic
WHERE EXTRACT(MONTH FROM cli.fecha_nacimiento) = EXTRACT(MONTH FROM SYSDATE) -1
ORDER BY "Dìa de Cumpleaños", cli.appaterno ASC
;
--CASO 2
SELECT TO_CHAR(cli.numrun, '999G999G999')||'-'||cli.dvrun AS "RUN Cliente",
    cli.pnombre||' '||
    cli.snombre||' '||
    cli.appaterno||' '||
    cli.apmaterno AS "Nombre Cliente",
    TO_CHAR(SUM(crecli.monto_solicitado), '$999G999G999G999G999') AS "Monto solicitado Creditos",
    TO_CHAR(ROUND(SUM(crecli.monto_solicitado/100000)*1200), '$999G999G999G999') AS "Bonus"
FROM cliente cli
    JOIN credito_cliente crecli ON crecli.nro_cliente = cli.nro_cliente
WHERE EXTRACT(YEAR FROM crecli.fecha_solic_cred)< EXTRACT(YEAR FROM SYSDATE)
    AND EXTRACT(YEAR FROM crecli.fecha_solic_cred)> EXTRACT(YEAR FROM crecli.fecha_solic_cred)-1
GROUP BY cli.numrun, 
    cli.dvrun, cli.pnombre, 
    cli.pnombre, cli.snombre, 
    cli.appaterno,
    cli.apmaterno
ORDER BY "Bonus" ASC, cli.appaterno DESC
;
--CASO 3
SELECT TO_CHAR(crecli.fecha_solic_cred, 'MMYYYY') AS "Mes Transaccion",
    cre.nombre_credito "Tipo de credito",
    TO_CHAR(SUM(crecli.monto_credito), '$999G999G999G999') AS "Monto Solicitado Credito",
    CASE WHEN SUM(crecli.monto_credito) BETWEEN 100000 AND 1000000 THEN TO_CHAR(ROUND(SUM(crecli.monto_credito*0.01)), '$999G999G999G999')
        WHEN SUM(crecli.monto_credito) BETWEEN 1000001 AND 2000000 THEN TO_CHAR(ROUND(SUM(crecli.monto_credito*0.02)), '$999G999G999G999')
        WHEN SUM(crecli.monto_credito) BETWEEN 2000001 AND 4000000 THEN TO_CHAR(ROUND(SUM(crecli.monto_credito*0.03)), '$999G999G999G999')
        WHEN SUM(crecli.monto_credito) BETWEEN 4000001 AND 6000000 THEN TO_CHAR(ROUND(SUM(crecli.monto_credito*0.04)), '$999G999G999G999')
        WHEN SUM(crecli.monto_credito) > 6000000 THEN TO_CHAR(ROUND(SUM(crecli.monto_solicitado*0.07)),'$999G999G999G999')
    END AS "APORTE A LA SBIF"
    
FROM credito_cliente crecli 
    JOIN credito cre ON crecli.cod_credito = cre.cod_credito
WHERE EXTRACT(YEAR FROM crecli.fecha_solic_cred) = EXTRACT(YEAR FROM SYSDATE)-1
    AND EXTRACT(DAY FROM crecli.fecha_otorga_cred) <= EXTRACT(DAY FROM crecli.fecha_solic_cred)+5
GROUP BY TO_CHAR(crecli.fecha_solic_cred, 'MMYYYY'),
    cre.nombre_credito,
    cre.tasa_interes_anual,
    cre.cod_credito
    
ORDER BY "Mes Transaccion", "Tipo de credito"
;
select * from credito;

--CASO 4
SELECT TO_CHAR(c.numrun, '999G999G999')||'-'||c.dvrun AS "Run Cliente",
    c.pnombre||' '||c.snombre||' '||c.appaterno||' '||c.apmaterno AS "Nombre Cliente",
    TO_CHAR(SUM(pic.monto_total_ahorrado), '$999G999G999G999') AS "Monto Total Ahorrado",
    CASE WHEN SUM(pic.monto_total_ahorrado) BETWEEN 100000 AND 1000000 THEN 'BRONCE'
    WHEN SUM(pic.monto_total_ahorrado) BETWEEN 1000001 AND 4000000 THEN 'PLATA'
    WHEN SUM(pic.monto_total_ahorrado) BETWEEN 4000001 AND 8000000 THEN 'SILVER'
    WHEN SUM(pic.monto_total_ahorrado) BETWEEN 8000001 AND 15000000 THEN 'GOLD'
    WHEN SUM(pic.monto_total_ahorrado) > 15000000 THEN 'PLATINUM'
    
    END AS "Categoria Cliente"
FROM  cliente c 
    JOIN producto_inversion_cliente pic ON c.nro_cliente = pic.nro_cliente
GROUP BY c.numrun, c.dvrun,
    c.pnombre, c.snombre, c.appaterno, c.apmaterno
ORDER BY c.appaterno ASC, TO_CHAR(SUM(pic.monto_total_ahorrado)) DESC
;
--CASO 5
SELECT EXTRACT(YEAR FROM SYSDATE) AS "Año Tributario",
    TO_CHAR(c.numrun, '999G999G999')||'-'||c.dvrun AS "Run CLeinte",
    INITCAP(c.pnombre)||' '||SUBSTR(c.snombre,0,1)||'. '||INITCAP(c.appaterno)||' '||INITCAP(c.apmaterno) AS "Nombre Cliente",
    COUNT(pi.cod_prod_inv) AS "Total Prod. Inv Afectos Impto",
    TO_CHAR(SUM(pic.monto_total_ahorrado), '$999G999G999') AS "Monto total ahorrado",
    pi.nombre_prod_inv
FROM cliente c
    JOIN producto_inversion_cliente pic ON c.nro_cliente=pic.nro_cliente
    JOIN producto_inversion pi ON pic.cod_prod_inv=pi.cod_prod_inv
WHERE pic.cod_prod_inv >= 30
GROUP BY c.numrun, c.dvrun,
    c.pnombre, c.snombre, c.appaterno, c.apmaterno,
    pi.nombre_prod_inv
ORDER BY c.appaterno ASC
;
select * from producto_inversion;
select * from producto_inversion_cliente;
select * from credito_cliente;
select * from cliente;

--CASO 6
--INFORME 1
SELECT TO_CHAR(c.numrun, '999G999G999')||'-'||c.dvrun AS "Run Ciente",
    INITCAP(c.pnombre)||' '||INITCAP(snombre)
    ||' '||INITCAP(c.appaterno)||' '||INITCAP(c.apmaterno) AS "Nombre Cliente",
    COUNT(cc.nro_cliente) AS "Total Creditos Solicitados",
    TO_CHAR(SUM(cc.monto_credito), '$999G999G999G999') AS "Monto Total Creditos"
FROM cliente c
    JOIN credito_cliente cc ON c.nro_cliente = cc.nro_cliente
WHERE cc.fecha_solic_cred <= cc.fecha_solic_cred + 5
    AND  EXTRACT(MONTH FROM cc.fecha_solic_cred) =  EXTRACT(MONTH FROM cc.fecha_otorga_cred)
    AND EXTRACT(YEAR FROM fecha_otorga_cred) = EXTRACT(YEAR FROM SYSDATE)-1    
GROUP BY c.numrun, c.dvrun,
    c.pnombre, c.snombre, c.appaterno, c.apmaterno
ORDER BY c.appaterno
;
--INFORME 2
SELECT TO_CHAR(c.numrun, '999G999G999')||'-'||c.dvrun AS "Run Ciente",
    INITCAP(c.pnombre)||' '||INITCAP(snombre)
    ||' '||INITCAP(c.appaterno)||' '||INITCAP(c.apmaterno) AS "Nombre Cliente",
    COALESCE(TO_CHAR(MAX(CASE WHEN m.cod_tipo_mov = 1 THEN m.monto_movimiento 
                            ELSE null END), '$999G999G999'), 'No realizó') as "ABONO",
    COALESCE(TO_CHAR(MAX(CASE WHEN m.cod_tipo_mov = 2 THEN m.monto_movimiento 
                            ELSE null END), '$999G999G999'), 'No realizó') as "RESCATES"

FROM cliente c
    JOIN movimiento m ON c.nro_cliente = m.nro_cliente
WHERE EXTRACT(YEAR FROM m.fecha_movimiento) = EXTRACT(YEAR FROM SYSDATE)
GROUP BY c.numrun, c.dvrun,
    c.pnombre, c.snombre, c.appaterno, c.apmaterno
ORDER BY appaterno
;
--MAS JOIN
SELECT *
FROM cliente cli
    JOIN comuna co ON cli.cod_comuna = co.cod_comuna
                AND cli.cod_provincia = co.cod_provincia
                AND cli.cod_region = co.cod_region
;