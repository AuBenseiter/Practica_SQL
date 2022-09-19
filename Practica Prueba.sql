--CASO 1
SELECT nro_patente AS "Patente",
    color AS "COLOR",
    anio AS "AÑO",
    valor_arriendo_dia AS "Valor Diario del Arriendo"
FROM camion
ORDER BY anio ASC, nro_patente DESC;
--CASO 2
SELECT nro_patente AS "Patente",
    id_marca AS "ID Marca",
    motor AS "Motor",
    color AS "COlor",
    EXTRACT(YEAR FROM SYSDATE) - anio AS "Años en servicio"
FROM camion
WHERE color=INITCAP('&colorBusqueda')
order by anio DESC;
--CASO 3
--A
SELECT *
FROM empleado;
SELECT SUBSTR(INITCAP(pnombre_emp),0,1)||' '||
    SUBSTR(NVL2(snombre_emp,snombre_emp,'BRITO'),0,1)||' '||
    appaterno_emp||' '||apmaterno_emp AS "Nombre Completo"
FROM empleado;
--B
SELECT TO_CHAR(EXTRACT(YEAR FROM fecha_contrato)) AS "Año de Contratacion"
FROM empleado;
--C
SELECT TO_CHAR(sueldo_base, '$999,999,999.00') AS "Sueldo"
FROM empleado;
--D
SELECT TO_CHAR(CASE id_tipo_sal WHEN 'F' THEN sueldo_base*0.072
    WHEN 'I' THEN sueldo_base*0.083
    WHEN 'FA' THEN sueldo_base*0.045
    WHEN 'C' THEN 0.053
    WHEN 'P' THEN 0.113
    ELSE sueldo_base END, '999,999,999.00') AS "Descuento"
FROM empleado;
--E
SELECT TO_CHAR(CASE NVL2(snombre_emp,snombre_emp,'BRITO') WHEN 'BRITO' THEN sueldo_base*0.2
    ELSE sueldo_base*0.01 END, '$999G999G999D00') AS "Aumento de Sueldo"
FROM empleado;
--F
SELECT TO_CHAR(CASE NVL2(snombre_emp,snombre_emp,'BRITO') WHEN 'BRITO' THEN sueldo_base*1.2
    ELSE sueldo_base*1.01 END, '$999G999G999D00') AS "Aumento de Sueldo"
FROM empleado