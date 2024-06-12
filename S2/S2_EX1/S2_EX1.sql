USE tienda;
/*1*/ SELECT nombre FROM producto;
/*2*/ SELECT nombre, precio FROM producto;

/*3 corregido*/ SHOW COLUMNS FROM producto;

/*4*/ SELECT nombre, precio, ROUND((precio * 1.08), 2) FROM producto;
/*5*/ SELECT nombre AS productos, precio AS 'precio(€)', ROUND((precio * 1.08), 2) AS 'precio($)' FROM producto;
/*6*/ SELECT UPPER(nombre) AS producto, precio FROM producto;
/*7*/ SELECT LOWER(nombre) AS producto, precio FROM producto;
/*8*/ SELECT nombre, UPPER(SUBSTRING(nombre, 1, 2)) AS abreviatura FROM fabricante;
/*9*/ SELECT nombre, ROUND(precio) AS precio FROM producto;
/*10*/ SELECT nombre, TRUNCATE(precio, 0) AS precio FROM producto;

/*11 corregido*/ SELECT codigo_fabricante FROM producto;

/*12 corregido*/ SELECT DISTINCT codigo_fabricante FROM producto;

/*13*/ SELECT nombre FROM fabricante ORDER BY nombre;
/*14*/ SELECT nombre FROM fabricante ORDER BY nombre DESC;
/*15*/ SELECT nombre, precio FROM producto ORDER BY nombre, precio DESC;
/*16*/ SELECT * FROM fabricante LIMIT 5;
/*17*/ SELECT * FROM fabricante LIMIT 3,2;
/*18*/ SELECT nombre,precio FROM producto ORDER BY precio LIMIT 1;
/*19*/ SELECT nombre,precio FROM producto ORDER BY precio DESC LIMIT 1;
/*20*/ SELECT nombre, codigo_fabricante FROM producto WHERE codigo_fabricante = 2;
/*21*/ SELECT p.nombre, p.precio, f.nombre AS fabricante FROM fabricante f JOIN producto p ON (f.codigo = p.codigo_fabricante);
/*22*/ SELECT p.nombre, p.precio, f.nombre AS fabricante FROM fabricante f JOIN producto p ON (f.codigo = p.codigo_fabricante) ORDER BY f.nombre;
/*23*/ SELECT p.codigo AS Nºproducto, p.nombre, f.codigo AS Nºfabricante, f.nombre AS fabricante FROM fabricante f JOIN producto p ON (f.codigo = p.codigo_fabricante);
/*24*/ SELECT p.nombre AS producto , p.precio, f.nombre AS fabricante FROM producto p JOIN fabricante f ON (f.codigo = p.codigo_fabricante) ORDER BY p.precio LIMIT 1;

/*25 corregido*/ SELECT p.nombre AS producto , p.precio, f.nombre AS fabricante FROM producto p JOIN fabricante f ON (f.codigo = p.codigo_fabricante) ORDER BY p.precio DESC LIMIT 1;

/*26*/ SELECT p.nombre AS producto , p.precio, f.nombre AS fabricante FROM producto p JOIN fabricante f ON (f.codigo = p.codigo_fabricante) WHERE p.codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'lenovo');
/*27*/ SELECT p.nombre AS producto , p.precio, f.nombre AS fabricante FROM producto p JOIN fabricante f ON (f.codigo = p.codigo_fabricante) WHERE p.codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'crucial') && p.precio > 200;

/*28 corregido*/ SELECT p.nombre AS producto , p.precio, f.nombre AS fabricante FROM producto p JOIN fabricante f ON (f.codigo = p.codigo_fabricante) WHERE (f.nombre = 'Asus' OR f.nombre = 'Hewlett-Packard' OR f.nombre = 'Seagate');

/*29 corregido*/ SELECT p.nombre AS producto, p.precio, f.nombre AS fabricante FROM producto p JOIN fabricante f ON f.codigo = p.codigo_fabricante WHERE f.nombre IN ('Asus', 'Hewlett-Packard', 'Seagate');

/*30*/ SELECT p.nombre AS producto , p.precio, f.nombre AS fabricante FROM producto p JOIN fabricante f ON (f.codigo = p.codigo_fabricante) WHERE f.nombre LIKE '%e';
/*31*/ SELECT p.nombre AS producto , p.precio, f.nombre AS fabricante FROM producto p JOIN fabricante f ON (f.codigo = p.codigo_fabricante) WHERE f.nombre LIKE '%w%';
/*32*/ SELECT p.nombre AS producto , p.precio, f.nombre AS fabricante FROM producto p JOIN fabricante f ON (f.codigo = p.codigo_fabricante) WHERE p.precio >= 180 ORDER BY p.precio DESC, p.nombre;
/*33*/ SELECT DISTINCT f.codigo, f.nombre AS fabricantes FROM fabricante f JOIN producto p ON (f.codigo = p.codigo_fabricante);
/*34*/ SELECT f.codigo, f.nombre AS fabricantes, p.nombre AS producto FROM fabricante f LEFT JOIN producto p ON (f.codigo = p.codigo_fabricante);
/*35*/ SELECT DISTINCT f.codigo, f.nombre AS fabricantes FROM fabricante f LEFT JOIN producto p ON (f.codigo = p.codigo_fabricante) WHERE p.nombre IS NULL;
/*36*/ SELECT p.nombre AS producto, f.nombre AS fabricante FROM producto p LEFT JOIN fabricante f ON (f.codigo = p.codigo_fabricante) WHERE f.nombre = 'lenovo';
/*37*/ SELECT * FROM producto p LEFT JOIN fabricante f ON (f.codigo = p.codigo_fabricante) WHERE p.precio = (SELECT MAX(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'lenovo'));
/*38*/ SELECT p.nombre AS producto, p.precio FROM producto p LEFT JOIN fabricante f ON (f.codigo = p.codigo_fabricante) WHERE f.nombre = 'lenovo' ORDER BY p.precio DESC LIMIT 1;
/*39*/ SELECT p.nombre AS producto, p.precio FROM producto p LEFT JOIN fabricante f ON (f.codigo = p.codigo_fabricante) WHERE f.nombre = 'Hewlett-Packard' ORDER BY p.precio LIMIT 1;
/*40*/ SELECT p.nombre AS producto, p.precio FROM producto p LEFT JOIN fabricante f ON (f.codigo = p.codigo_fabricante) WHERE p.precio >= (SELECT MAX(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo'))   ORDER BY p.precio;
/*41*/ SELECT p.nombre AS producto, p.precio FROM producto p JOIN fabricante f ON (f.codigo = p.codigo_fabricante) WHERE p.codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Asus') AND p.precio > (SELECT AVG(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Asus'));

USE universidad;
/*1*/ SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo = 'alumno' ORDER BY apellido1, apellido2, nombre;
/*2*/ SELECT nombre, apellido1, apellido2, telefono FROM persona WHERE tipo = 'alumno' AND telefono IS NULL;
/*3*/ SELECT nombre, apellido1, apellido2, fecha_nacimiento FROM persona WHERE tipo = 'alumno' AND fecha_nacimiento BETWEEN "1999-01-01" AND "1999-12-31";
/*4*/ SELECT nif, nombre, apellido1, apellido2, telefono FROM persona WHERE tipo = 'profesor' AND telefono IS NULL  AND nif LIKE "%k";
/*5*/ SELECT * FROM asignatura WHERE cuatrimestre = 1 AND curso = 3 AND id_grado =  7;
/*6*/ SELECT apellido1, apellido2, p.nombre, d.nombre AS departamento FROM persona p JOIN profesor pr ON (p.id = pr.id_profesor) JOIN departamento d ON (pr.id_departamento = d.id);
/*7*/ SELECT a.nombre, c.anyo_inicio, c.anyo_fin FROM persona p JOIN alumno_se_matricula_asignatura al ON (p.id = al.id_alumno) JOIN curso_escolar c ON (al.id_curso_escolar = c.id) JOIN asignatura a ON (al.id_asignatura = a.id) WHERE p.nif LIKE "26902806M";
/*8*/ SELECT DISTINCT d.nombre AS departamento FROM asignatura a JOIN profesor p ON (a.id_profesor = p.id_profesor) JOIN grado g ON (a.id_grado = g.id) JOIN departamento d ON (p.id_departamento = d.id) WHERE g.id = (SELECT id FROM grado WHERE nombre = 'Grado en Ingeniería Informática (Plan 2015)');
/*9*/ SELECT DISTINCT p.nombre, p.apellido1, p.apellido2, ce.anyo_inicio, ce.anyo_fin FROM persona p JOIN alumno_se_matricula_asignatura al ON (p.id = al.id_alumno)  JOIN asignatura asi ON (al.id_asignatura = asi.id) JOIN curso_escolar ce ON (al.id_curso_escolar = ce.id) WHERE ce.anyo_inicio = 2018;

/*1 corregido*/ SELECT pe.nombre, pe.apellido1, pe.apellido2, d.nombre AS departamento FROM persona pe LEFT JOIN profesor pr ON (pe.id = pr.id_profesor) LEFT JOIN departamento d ON (pr.id_departamento = d.id) WHERE tipo = 'profesor' ORDER BY d.nombre, pe.apellido1, pe.apellido2, pe.nombre;

/*2 corregido*/ SELECT * FROM persona pe LEFT JOIN profesor pr ON (pe.id = pr.id_profesor) LEFT JOIN departamento d ON (pr.id_departamento = d.id) WHERE tipo = 'profesor' AND d.nombre IS NULL; 

/*3*/ SELECT DISTINCT * FROM departamento de LEFT JOIN profesor p ON (de.id = p.id_departamento) WHERE p.id_profesor IS NULL;

/*4 corregido */ SELECT pe.nombre, pe.apellido1, pe.apellido2, asi.nombre AS asignatura FROM persona pe LEFT JOIN profesor pr ON (pe.id = pr.id_profesor) LEFT JOIN asignatura asi ON (asi.id_profesor = pr.id_profesor) WHERE asi.nombre IS NULL; 

/*5*/ SELECT * FROM asignatura WHERE id_profesor IS NULL;
/*6*/ SELECT DISTINCT d.nombre FROM departamento d LEFT JOIN profesor pr ON d.id = pr.id_departamento LEFT JOIN asignatura asi ON pr.id_profesor = asi.id_profesor WHERE asi.id IS NULL;

/*1 corregido*/ SELECT COUNT(*) FROM persona WHERE tipo = 'alumno';
	
/*2*/ SELECT COUNT(*) AS estudiantes FROM persona WHERE tipo = 'alumno' AND fecha_nacimiento BETWEEN "1999-01-01" AND "1999-12-31";

/*3 corregido*/ SELECT d.nombre, COUNT(*) AS profesores FROM persona pe JOIN profesor pr ON (pe.id = pr.id_profesor) LEFT JOIN departamento d ON (pr.id_departamento = d.id) GROUP BY d.nombre ORDER BY profesores DESC;

/*4*/ SELECT d.nombre AS departamento, COUNT(pr.id_profesor) AS profesores FROM departamento d LEFT JOIN profesor pr ON (d.id = pr.id_departamento) GROUP BY d.nombre;
/*5*/ SELECT g.nombre, COUNT(a.id) AS asignaturas FROM grado g LEFT JOIN asignatura a ON (a.id_grado = g.id) GROUP BY g.nombre ORDER BY COUNT(a.id) DESC;
/*6*/ SELECT g.nombre, COUNT(a.id) AS asignaturas FROM grado g LEFT JOIN asignatura a ON (a.id_grado = g.id) GROUP BY g.nombre HAVING (COUNT(a.id) > 40);
/*7*/ SELECT g.nombre, a.tipo, SUM(a.creditos) AS creditos FROM grado g LEFT JOIN asignatura a ON (a.id_grado = g.id) GROUP BY g.nombre, a.tipo;

/*8 corregido*/ SELECT ce.anyo_inicio, COUNT(DISTINCT asma.id_alumno) AS alumnos FROM asignatura a JOIN alumno_se_matricula_asignatura asma ON (asma.id_asignatura =a.id) JOIN curso_escolar ce ON (asma.id_curso_escolar = ce.id) GROUP BY asma.id_curso_escolar;

/*9 corregido*/ SELECT pe.id, pe.nombre, pe.apellido1, pe.apellido2, COUNT(asi.id) AS asignaturas FROM profesor pr JOIN persona pe ON (pr.id_profesor = pe.id) LEFT JOIN asignatura asi ON (asi.id_profesor = pr.id_profesor) GROUP BY pr.id_profesor ORDER BY asignaturas DESC;

/*10*/ SELECT * FROM persona WHERE tipo = 'alumno' ORDER BY fecha_nacimiento DESC LIMIT 1;
/*11*/ SELECT pe.nombre, pe.apellido1, pe.apellido2, COUNT(asi.id)  AS asignaturas  FROM profesor pr JOIN persona pe ON (pr.id_profesor = pe.id)LEFT JOIN departamento dp ON (dp.id = pr.id_departamento) LEFT JOIN asignatura asi ON (asi.id_profesor = pr.id_profesor) GROUP BY pr.id_profesor HAVING COUNT(asi.id) = 0;