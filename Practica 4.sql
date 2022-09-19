--CASO 1
SELECT numrun_cli AS "RUN Cliente",
    appaterno_cli||' '||SUBSTR(apmaterno_cli,0,1)||'. '||pnombre_cli||' '|| snombre_cli AS "Nombre Cliente",
    direccion AS "Direccion",
    NVL(TO_CHAR(celular_cli),'No posee Telefono Fijo') AS "Telefono Fijo",
    NVL(TO_CHAR(celular_cli),'No posee celular') AS "Celular",
    id_comuna AS "Comuna"
FROM cliente
ORDER BY id_comuna ASC, appaterno_cli DESC;
--CASO 2
SELECT 'El empleado '||pnombre_emp||' '||appaterno_emp||' '||apmaterno_emp||
    ' estuvo de cumpleanhos el '||TO_CHAR(EXTRACT(DAY FROM fecha_nac))||
    ' de '||TO_CHAR(fecha_nac, 'Month')||
    ' Cumplio '||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)- EXTRACT(YEAR FROM fecha_nac))
    AS "Fecha Cumpleanhos"
FROM empleado
WHERE EXTRACT(MONTH FROM fecha_nac) = 7
ORDER BY TO_CHAR(fecha_nac,'dd "de" Month ') ASC;
--CASO 3
SELECT CASE WHEN id_tipo_camion = 'A' THEN 'Tradicional 6 Toneladas'
    WHEN id_tipo_camion = 'B' THEN 'Frigorifico'
    WHEN id_tipo_camion = 'C' THEN 'Camion 3/4'
    WHEN id_tipo_camion = 'D' THEN 'Trailer'
    WHEN id_tipo_camion = 'E' THEN 'Tolvo'
    ELSE 'Sin Calificar' END AS "Tipo Camion",
    nro_patente AS "Nro Patente",
    anio AS "Anho",
    TO_CHAR(valor_arriendo_dia, '$999G999G999') AS "Valor Arriendo Dia",
    NVL(TO_CHAR(valor_garantia_dia, '$999G999G999'),TO_CHAR('0','$999G999G999')) AS "Valor Garantia Dia",
    NULLIF(valor_arriendo_dia + NVL(valor_garantia_dia,0),0) AS "Valor Total Dias"
FROM camion
ORDER BY "Tipo Camion" ASC, valor_arriendo_dia DESC, valor_garantia_dia ASC, nro_patente ASC;
--CASO 4
SELECT TO_CHAR(sysdate,'mm/yyyy') AS "Fecha Proceso",
    numrun_emp||' '||dvrun_emp AS "Run Empleado",
    pnombre_emp||' '||snombre_emp||' '||appaterno_emp||' '||apmaterno_emp AS "Nombre Empleado",
    TO_CHAR(sueldo_base,'$999G999G999G999') AS "Sueldo Base",
    CASE WHEN sueldo_base>320000 AND sueldo_base<450000 THEN TO_CHAR((20000000*0.05),'$99G999G999')
    WHEN sueldo_base>450001 AND sueldo_base<600000 THEN TO_CHAR((20000000*0.035),'$99G999G999')
    WHEN sueldo_base>600001 AND sueldo_base<900000 THEN TO_CHAR((20000000*0.025),'$99G999G999')
    WHEN sueldo_base>900001 AND sueldo_base<1800000 THEN TO_CHAR((20000000*0.015),'$99G999G999')
    WHEN sueldo_base>1800001 THEN TO_CHAR((20000000*0.01),'$99G999G999')
    END "Bonificacion"
FROM empleado
ORDER BY appaterno_emp ASC;
--CASO 5
SELECT numrun_emp ||'-'||dvrun_emp AS "RUN Empleado",
    pnombre_emp||' '||snombre_emp||' '||appaterno_emp||' '||apmaterno_emp AS "Nombre Empleado",
    TRUNC((SYSDATE-fecha_contrato)/365) AS "Anhos de Servicio",
    TO_CHAR(sueldo_base,'$99G999G999') AS "Sueldo Base",
    CASE WHEN sueldo_base>=450000 THEN TO_CHAR((sueldo_base*(TRUNC((SYSDATE-fecha_contrato)/365)/100)),'$99G999G999')
    WHEN sueldo_base<450000 THEN TO_CHAR((sueldo_base*(TRUNC((SYSDATE-fecha_contrato)/365)/100)),'$99G999G999')   
    END "Valor Movilizacion",
    CASE WHEN sueldo_base>=450000 THEN TO_CHAR((sueldo_base*(SUBSTR(sueldo_base,0,1)/100)),'$99G999G999')
    WHEN sueldo_base<450000 THEN TO_CHAR((sueldo_base*(SUBSTR(sueldo_base,0,2)/100)),'$99G999G999')
    END "Bonificacion",
    CASE WHEN sueldo_base>=450000 THEN TO_CHAR((sueldo_base*(SUBSTR(sueldo_base,0,1)/100))+(sueldo_base*(TRUNC((SYSDATE-fecha_contrato)/365)/100)),'$99G999G999')
    WHEN sueldo_base<450000 THEN TO_CHAR((sueldo_base*(SUBSTR(sueldo_base,0,2)/100))+(sueldo_base*(TRUNC((SYSDATE-fecha_contrato)/365)/100)),'$99G999G999')
    END "Total" 
FROM empleado
WHERE id_comuna IN (117,118,120,122,126);
--CASO 6
SELECT EXTRACT(YEAR FROM SYSDATE) AS "Anho Tributario",
    TO_CHAR(numrun_emp,'99G999G999') ||'-'||dvrun_emp AS "RUN Empleado",
    pnombre_emp||' '||snombre_emp||' '||appaterno_emp||' '||apmaterno_emp AS "Nombre Empleado",
    TRUNC((SYSDATE-TO_DATE('01/01/22'))/31) AS "Meses Trabajados",
    TRUNC((SYSDATE-fecha_contrato)/365) AS "Anhos de Servicio",
    TO_CHAR(sueldo_base, '$999G999G999G999') AS "Sueldo Base Mensual",
    TO_CHAR(sueldo_base*12, '$999G999G999G999') AS "Sueldo Base Anual",
    TO_CHAR(TRUNC(sueldo_base*(TRUNC((SYSDATE-fecha_contrato)/365)/100))*12,'$999G999G999') AS "Bono por Anhos Anual",
    TO_CHAR(TRUNC(sueldo_base*0.12)*12, '$999G999G999G999') AS "Movilizacion Anual",
    TO_CHAR(TRUNC(sueldo_base*0.20)*12, '$999G999G999G999') AS "Colacion Anual",
    TO_CHAR(TRUNC(((sueldo_base*0.20)+(sueldo_base*0.12)+sueldo_base+(sueldo_base*(TRUNC((SYSDATE-fecha_contrato)/365)/100)))*12), '$999G999G999G999') AS "Sueldo Bruto Anual",
    TO_CHAR(TRUNC((sueldo_base+sueldo_base*(TRUNC((SYSDATE-fecha_contrato)/365)/100))*12), '$999G999G999G999') AS "Renta Imponible Anual"
    FROM empleado
ORDER BY numrun_emp;