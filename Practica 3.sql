--CASO 1
SELECT numrun_cli||' '||dvrun_cli AS "RUN CLIENTE",
    LOWER(pnombre_cli)||' '||
    INITCAP(snombre_cli)||' '||
    appaterno_cli||' '||
    apmaterno_cli AS "NOMBRE COMPLETO CLIENTE",
    TO_CHAR(fecha_nac_cli, 'DD/MM/YYYY') AS "Fecha Nacimiento",
    EXTRACT(DAY FROM fecha_nac_cli -1) AS "DIA" -- resta un dia

FROM cliente
WHERE EXTRACT (DAY FROM fecha_nac_cli-1) = &DIA AND--No toma el numero ingresado
    EXTRACT (MONTH FROM fecha_nac_cli) = &MES
ORDER BY appaterno_cli ASC;
--CASO 2
SELECT numrun_emp||'-'||dvrun_emp,
    pnombre_emp||' '||
    snombre_emp||' '||
    appaterno_emp||' '||
    apmaterno_emp AS "Nombre Completo Empleado",
    TO_CHAR(sueldo_base, '$999G999G999') AS "Sueldo Base",
    ROUND(TRUNC(sueldo_base/100000)) AS "Porcentaje Movilizacion",
    TO_CHAR(ROUND(Sueldo_base*TRUNC(sueldo_base/10000000,2)), '$999G999G999G999D00') AS "Valor Movilizacion"
FROM empleado
ORDER BY ROUND(TRUNC(sueldo_base/100000)) DESC;
--CASO 3
SELECT numrun_emp||'-'||dvrun_emp AS "Run Empleado",
    pnombre_emp||' '||snombre_emp||' '||appaterno_emp||' '||apmaterno_emp AS "Nombre Completo Empleado",
    TO_CHAR(sueldo_base, '$999G999G999G999D00') AS "Sueldo Base",
    TO_CHAR(fecha_nac, 'DD/MM/YYYY') AS "Fecha Nacimiento",
    SUBSTR(pnombre_emp,0,3)||
        LENGTH(pnombre_emp)||
        '*'||
        SUBSTR(sueldo_base,-1)||
        dvrun_emp||
        (EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM fecha_contrato))  AS "Usuario",
    fecha_contrato,    
    SUBSTR(numrun_emp,3,1)||
        EXTRACT(YEAR FROM fecha_contrato)+2||
        SUBSTR(sueldo_base,-3)-1||
        SUBSTR(appaterno_emp,-2)||
        EXTRACT(MONTH FROM fecha_contrato) AS "Clave"
FROM empleado
ORDER BY appaterno_emp;
--CASO 4
SELECT REPLACE(anio,anio,'2019') AS "Anho Proceso",
    nro_patente,
    valor_arriendo_dia,
    valor_garantia_dia,
    EXTRACT(YEAR FROM SYSDATE)-anio AS "Anho antiguedad",
    valor_arriendo_dia-(valor_arriendo_dia*(EXTRACT(YEAR FROM SYSDATE)-anio)/100) AS "Valor Arriendo dia CR",
    valor_garantia_dia-(valor_garantia_dia*(EXTRACT(YEAR FROM SYSDATE)-anio)/100) AS "Valor Garantia Dia CR"
FROM camion
WHERE EXTRACT(YEAR FROM SYSDATE)-anio > 5
ORDER BY EXTRACT(YEAR FROM SYSDATE)-anio DESC, nro_patente ASC;
--CASO 5
SELECT REPLACE(SYSDATE, SYSDATE, '09/2022') AS "Mes Anho Proceso",
    nro_patente AS "Numero Patente",
    fecha_ini_arriendo AS " Fecha Inicio Arriendo",
    dias_solicitados AS "Dias Solicitados",
    fecha_devolucion AS "Fecha Devolucion",
    fecha_devolucion - (fecha_ini_arriendo + dias_solicitados) AS "Dias de Atraso",
    (fecha_devolucion - (fecha_ini_arriendo + dias_solicitados)) * 25500 AS "Valor Multa"
FROM arriendo_camion
WHERE EXTRACT(MONTH FROM fecha_devolucion) = 7 
    AND EXTRACT(YEAR FROM fecha_devolucion) = 2022
    AND fecha_devolucion - (fecha_ini_arriendo + dias_solicitados) != 0
ORDER BY fecha_ini_arriendo ASC, nro_patente ASC