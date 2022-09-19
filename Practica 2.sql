SELECT * FROM propiedad;
--CASO 1
--PARTE 1
SELECT fecha_entrega_propiedad
FROM propiedad
WHERE fecha_entrega_propiedad BETWEEN '01/01/2022' AND '30/12/2022';
--option 2 WHERE fecha_entrega_propiedad LIKE '%22'
--PARTE 2
SELECT fecini_arriendo
FROM propiedad_arrendada
WHERE fecini_arriendo LIKE '%22';
--CASO 2
--ID DE ESPADO CIVIL
SELECT *
FROM estado_civil;
--3 or 4, renta>800k
SELECT numrut_cli||'-'||dvrut_cli AS "RUT Cliente",
    nombre_cli||' '||appaterno_cli||' '||apmaterno_cli AS "Nombre Cliente",
    TO_CHAR(renta_cli, '$999,999,999,999.00') AS "Renta",
    fonofijo_cli AS "Telefono Fijo",
    celular_cli AS "Celular",
    id_estcivil
FROM cliente
WHERE id_estcivil = 1 OR (id_estcivil IN(3,4) AND renta_cli >= 800000)
ORDER BY appaterno_cli, nombre_cli;
--CASO 3
--PARTE 1
SELECT nombre_emp||' '||appaterno_emp||' '||apmaterno_emp AS "Nombre Empleado",
    TO_CHAR(sueldo_emp, '$999,999,999.00') AS "Sueldo Actual",
    TO_CHAR((sueldo_emp*1.085), '$999,999,999.00') AS "Sueldo Reajustado",
    TO_CHAR(sueldo_emp *0.085, '$999,999,999.00') AS "Aumento"
FROM empleado
ORDER BY sueldo_emp DESC;
--PARTE 2
SELECT nombre_emp||' '||appaterno_emp||' '||apmaterno_emp AS "Nombre Empleado",
    TO_CHAR(sueldo_emp, '$999,999,999.00') AS "Sueldo Actual",
    TO_CHAR((sueldo_emp*1.20), '$999,999,999.00') AS "Sueldo Reajustado",
    TO_CHAR(sueldo_emp *0.20, '$999,999,999.00') AS "Aumento"
FROM empleado
WHERE sueldo_emp BETWEEN 200000 AND 400000
ORDER BY sueldo_emp DESC;
--CASO 4
SELECT *
FROM categoria_empleado;
SELECT numrut_emp||'-'||dvrut_emp AS "RUN Empleado",
    nombre_emp||' '||appaterno_emp||' '||apmaterno_emp AS "Nombre Empleado",
    TO_CHAR(sueldo_emp, '$999,999,999.00') AS "Salario Actual",
    TO_CHAR((sueldo_emp*1.20), '$999,999,999.00') AS "Sueldo Reajustado",
    TO_CHAR(sueldo_emp *0.20, '$999,999,999.00') AS "Aumento",
    id_categoria_emp
FROM empleado
WHERE sueldo_emp <= 500000 AND id_categoria_emp != 3
ORDER BY sueldo_emp DESC;
--CASO 5
--INFORME 1
SELECT nro_propiedad AS "Numero Propiedad",
    fecha_entrega_propiedad AS "Fecha Entrega Propiedad",
    direccion_propiedad AS "Diereccion Propiedad",
    superficie AS "Superficie",
    nro_dormitorios AS "Nº Dormitorios",
    nro_banos AS "Cantidad de Baños",
    TO_CHAR(valor_arriendo, '$999,999,999.00') AS "Valor del Arriendo"
FROM propiedad
WHERE fecha_entrega_propiedad BETWEEN '01/01/2022' AND '31/12/2022'
ORDER BY fecha_entrega_propiedad DESC;
--INFORME 2
SELECT nro_propiedad AS "Numero Propiedad",
    fecha_entrega_propiedad AS "Fecha Entrega Propiedad",
    direccion_propiedad AS "Diereccion Propiedad",
    superficie AS "Superficie",
    nro_dormitorios AS "Nº Dormitorios",
    nro_banos AS "Cantidad de Baños",
    TO_CHAR(valor_arriendo, '$999,999,999.00') AS "Valor del Arriendo"
FROM propiedad
WHERE fecha_entrega_propiedad BETWEEN '01/02/2010' AND '28/02/2010';
--INFORME 3
SELECT nro_propiedad,
        fecha_entrega_propiedad,
        direccion_propiedad,
        superficie,
        nro_dormitorios,
        nro_banos,
        valor_arriendo
FROM propiedad
WHERE fecha_entrega_propiedad LIKE '%22'
ORDER BY fecha_entrega_propiedad DESC