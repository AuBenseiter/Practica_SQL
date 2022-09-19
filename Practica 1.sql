SELECT * FROM cliente;
SELECT * FROM empleado;
SELECT * FROM propiedad_arrendada;
--CASO UNO
SELECT 'EL empleado '||' '|| nombre_emp ||' '|| appaterno_emp ||' '|| apmaterno_emp ||' nacio el '||fecnac_emp
FROM empleado
ORDER BY fecnac_emp,appaterno_emp ASC;
--CASO DOS
SELECT
    numrut_cli AS "Numero RUT",
    dvrut_cli AS "Digito Verificador",
    appaterno_cli||' '||apmaterno_cli||' '||nombre_cli AS Nombre,
    renta_cli AS Renta,
    fonofijo_cli AS "Telefono Fijo",
    celular_cli AS Celular
FROM cliente
ORDER BY appaterno_cli, apmaterno_cli ASC;
--CASO TRES
SELECT 
    nombre_emp||' '||appaterno_emp||' '||apmaterno_emp AS "Nombre Empleado",
    sueldo_emp AS Sueldo,
    sueldo_emp*0.5 AS "Bono por Capacitacion"
FROM empleado
ORDER BY "Bono por Capacitacion" DESC;
--CASO CUATRO
SELECT
    nro_propiedad AS "Numero de Propiedad",
    numrut_prop AS "RUT Propietario",
    direccion_propiedad AS "Direccion",
    valor_arriendo AS "Valor Arriendo",
    valor_arriendo*0.054 AS "Valor Compensacion"
FROM propiedad
ORDER BY numrut_prop ASC;
--CASO QUINTO
SELECT
    numrut_emp||'-'||dvrut_emp AS "RUN Empleado",
    nombre_emp||' '||appaterno_emp||' '||apmaterno_emp AS "Nombre Empleado",
    sueldo_emp AS "Salario Actual",
    ((sueldo_emp(13.5/100))+sueldo_emp) AS "Salario Reajustado",
    sueldo_emp*0.0135 AS "Reajuste"
FROM empleado
ORDER BY ((sueldo_emp*0.135)+sueldo_emp), appaterno_emp ASC;
--CASO SEIS
SELECT nombre_emp||' '||appaterno_emp||' '||apmaterno_emp AS "Nombre Completo",
    sueldo_emp AS "Sueldo",
    sueldo_emp*0.055 AS "Colacion",
    sueldo_emp*(17.8/100) AS "Movilizacion",
    sueldo_emp*0.078 AS "Salud",
    sueldo_emp*0.065 AS "AFP",
    sueldo_emp + sueldo_emp*(5.5/100)+sueldo_emp*(17.8/100) - sueldo_emp*0.078 - sueldo_emp*0.065 AS "Alcance Liquido"
FROM empleado
ORDER BY appaterno_emp ASC