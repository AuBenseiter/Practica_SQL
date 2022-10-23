--CASO 1
SELECT carreraid,
    COUNT(carreraid) AS "Total Alumnos Matriculados",
    'Le Corresponden'||
    TO_CHAR(COUNT(carreraid)*30200, '$999G999G999')||
    ' '||'del presupuesto total asignado para publicidad' 
    AS "Monto por Publicidad"
FROM alumno
GROUP BY carreraid
ORDER BY COUNT(carreraid) DESC;
--CASO 2
SELECT carreraid,
    COUNT(carreraid) AS "Total Alumnos"
FROM alumno
GROUP BY carreraid
HAVING COUNT(carreraid) > 4
ORDER BY carreraid ASC;
--CASO 3
SELECT TO_CHAR(run_jefe, '999G999G999') "Run Jefe Sin DV",
    COUNT(run_jefe) AS "Total de Empleados a su Cargo",
    TO_CHAR(MAX(salario),'999G999G999') AS "Salario Maximo",
    COUNT(run_jefe)*10||'%'||' del Salario Maximo' AS "Porcentaje de Bonificacion",
    TO_CHAR(MAX(salario)*COUNT(run_jefe)/100,'999G999G999') AS "Bonificacion"
FROM empleado
HAVING run_jefe IS NOT NULL
GROUP BY run_jefe
ORDER BY "Total de Empleados a su Cargo";
--CASO 4
SELECT id_escolaridad "Escolaridad",
    CASE WHEN id_escolaridad = 10 THEN 'Basica'
    WHEN id_escolaridad = 20 THEN 'Media Cientifico Humanista'
    WHEN id_escolaridad = 30 THEN 'Media Tecnico Profesional'
    WHEN id_escolaridad = 40 THEN 'Superior Centro de Formacion Tecnica'
    WHEN id_escolaridad = 50 THEN 'Superior Instituto Profesional'
    WHEN id_escolaridad = 60 THEN 'Superior Universidad'
    END AS "Descripcion Escolaridad",
    COUNT(id_escolaridad) AS "Total de Empleados",
    TO_CHAR(MAX(salario), '$999G999G999') AS "Salario Maximo",
    TO_CHAR(MIN(salario), '$999G999G999') AS "Salario Minimo",
    TO_CHAR(SUM(salario), '$999G999G999') AS "Salario Total",--Suma todos los sueldos que tengan la misma escolaridad, debido a la condicion de abajo
    TO_CHAR(AVG(salario), '$999G999G999') AS "Salario Promedio"
FROM empleado
GROUP BY id_escolaridad;
--CASO 5
SELECT tituloid AS "Titulo",
    COUNT(tituloid) AS "Total de Veces Solicitado",
    CASE WHEN COUNT(tituloid) = 1 THEN 'No Se Requieren Nuevos Ejemplare'
    WHEN COUNT(tituloid) BETWEEN 2 AND 3 THEN 'Se Requiero Comprar 1 nuevo Ejemplares'
    WHEN COUNT(tituloid) BETWEEN 4 AND 5 THEN 'Se Requiero Comprar 2 nuevo Ejemplares'
    WHEN COUNT(tituloid) > 5 THEN 'Se Requiero 4 Nuevos Ejemplares'
    END AS "Sugerencias"
FROM prestamo
WHERE EXTRACT(YEAR FROM fecha_ini_prestamo) = 2021
GROUP BY tituloid
ORDER BY COUNT(tituloid) DESC;
--CASO 6
SELECT  TO_CHAR(run_emp, '999G999G999') AS "RUN Empleado",
    LPAD(TO_CHAR(fecha_ini_prestamo, 'MM/YYYY'),20) AS "Mes Prestamos Libros",
    COUNT(tituloid) AS "Total Prestamos Atendidos",
    LPAD(TO_CHAR(COUNT(tituloid)*10000, '$999G999G999'),20) AS "Asignacion por Prestamos"
FROM prestamo
WHERE TO_CHAR(fecha_ini_prestamo,'YYYY') = '2021'
GROUP BY run_emp, TO_CHAR(fecha_ini_prestamo, 'MM/YYYY')
HAVING COUNT(*) >= 3 --CUALQUIER SUMA DEBE SER MAYOR IGUAL A 3
ORDER BY TO_CHAR(fecha_ini_prestamo, 'MM/YYYY'),
    LPAD(TO_CHAR(COUNT(tituloid)*10000, '$999G999G999'),20) DESC,
    run_emp DESC;