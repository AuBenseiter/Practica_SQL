/*Caso 1*/
--INFORME 1
SELECT
    ts.descripcion||','|| s.descripcion AS "Sistema Salud",
    COUNT(a.ate_id) "Atenciones"
FROM atencion a
    JOIN paciente p ON a.pac_run = p.pac_run
    JOIN salud s ON p.sal_id = s.sal_id
    JOIN tipo_salud ts ON s.tipo_sal_id = ts.tipo_sal_id
WHERE EXTRACT(YEAR FROM a.fecha_atencion) = EXTRACT(YEAR FROM SYSDATE)
    AND EXTRACT(MONTH FROM a.fecha_atencion) = 9
GROUP BY ts.descripcion,
         s.descripcion
HAVING COUNT(a.ate_id) > (
                    SELECT 
                        AVG(COUNT (a.ate_id)) AS "Atenciones Diarias"
                        FROM atencion a
                            JOIN paciente p ON a.pac_run = p.pac_run
                            JOIN salud s ON p.sal_id = s.sal_id
                            JOIN tipo_salud ts ON s.tipo_sal_id = ts.tipo_sal_id
                        WHERE EXTRACT(YEAR FROM a.fecha_atencion) = EXTRACT(YEAR FROM SYSDATE)
                            AND EXTRACT(MONTH FROM a.fecha_atencion) = 9
                        GROUP BY ts.descripcion,
         s.descripcion
                        )
ORDER BY "Sistema Salud";

--INfORME 2
SELECT TO_CHAR(A.PAC_RUN,'09G999G999')||'-'||P.DV_RUN AS "RUT PACIENTE",
P.PNOMBRE||' '||P.SNOMBRE||' '||P.APATERNO||' '||P.AMATERNO AS "NOMBRE PACIENTE",
P.ANHOS,
'Le corresponde un '||PO.PORCENTAJE_DESCTO||'% de descuento en la primera consulta medica del año '||EXTRACT(YEAR FROM SYSDATE) AS "PORCENTAJE DESCUENTO"
FROM ATENCION A 
JOIN (SELECT PAC_RUN,DV_RUN,PNOMBRE,SNOMBRE,APATERNO,AMATERNO,
        ROUND(MONTHS_BETWEEN(SYSDATE,FECHA_NACIMIENTO)/12) AS "ANHOS"
        FROM PACIENTE P
        WHERE ROUND(MONTHS_BETWEEN(SYSDATE,FECHA_NACIMIENTO)/12) >= 65) P ON A.PAC_RUN = P.PAC_RUN
JOIN PORC_DESCTO_3RA_EDAD PO ON P.ANHOS BETWEEN PO.ANNO_INI AND PO.ANNO_TER
WHERE EXTRACT(YEAR FROM A.FECHA_ATENCION) = EXTRACT(YEAR FROM SYSDATE)
GROUP BY A.PAC_RUN,P.DV_RUN,P.PNOMBRE,P.SNOMBRE,P.APATERNO,P.AMATERNO,P.ANHOS,PO.PORCENTAJE_DESCTO
HAVING COUNT(A.PAC_RUN) > 4;

select EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM fecha_nacimiento)
from paciente
WHERE EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM fecha_nacimiento) > 65
;
/*CASO 2*/
/*CASO 3*/
SELECT *
FROM medico m
    RIGHT JOIN unidad u ON m.uni_id = u.uni_id
;
SELECT 
    u.nombre,
    COUNT(a.ate_id),
    m.pnombre,
    m.apaterno    
FROM atencion a
    RIGHT JOIN medico m ON a.med_run = m.med_run
    JOIN unidad u ON m.uni_id = u.uni_id
WHERE EXTRACT(YEAR FROM a.fecha_atencion) = EXTRACT(YEAR FROM SYSDATE)-1 OR a.fecha_atencion IS NULL
GROUP BY
    u.nombre,
    m.apaterno,
    m.pnombre,
    m.med_run
;
/*CASO 4*/
--INFORME 1
SELECT fecha_atencion,
    COUNT(ate_id)
FROM atencion
GROUP BY fecha_atencion
;
SELECT * FROM cargo;
SELECT * FROM atencion;
SELECT * FROM pago_atencion;