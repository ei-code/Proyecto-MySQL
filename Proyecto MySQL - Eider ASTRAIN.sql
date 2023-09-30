-- Cree una base de datos SQL para una universidad que administre estudiantes, cursos, profesores y calificaciones.
CREATE DATABASE universidad;
-- Construya una base de datos con las siguientes tablas: Estudiantes, Cursos, Profesores, Calificaciones
USE universidad;
CREATE TABLE cursos (
    Id_curso INT NOT NULL AUTO_INCREMENT,
    materia VARCHAR(50),
    PRIMARY KEY (id_curso)
);
CREATE TABLE profesores (
    id_profesor INT NOT NULL AUTO_INCREMENT,
    id_curso_profesor INT NOT NULL,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    PRIMARY KEY (id_profesor),
	FOREIGN KEY (id_curso_profesor) REFERENCES cursos(id_curso)
);
CREATE TABLE estudiantes (
    id_estudiante INT NOT NULL AUTO_INCREMENT,
    id_curso_estudiante INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    PRIMARY KEY (id_estudiante),
	FOREIGN KEY (id_curso_estudiante) REFERENCES cursos(id_curso)
);
CREATE TABLE calificaciones (
    id_calificación INT AUTO_INCREMENT,
	id_profesor_calificación INT NOT NULL,
	id_estudiante_calificación INT NOT NULL,
    nota DECIMAL(4,2),
	PRIMARY KEY (id_calificación),
	FOREIGN KEY (id_profesor_calificación) REFERENCES profesores(id_profesor),
	FOREIGN KEY (id_estudiante_calificación) REFERENCES estudiantes(id_estudiante)
);
-- Cree un script que complete todas las tablas de la base de datos con datos de muestra
INSERT INTO cursos (materia)
VALUES
    ('Matemáticas'), 
    ('Historia');  
INSERT INTO estudiantes (nombre, apellido, email, id_curso_estudiante)
VALUES
    ('Juan', 'Pérez', 'juan@mail.com', 1),
    ('María', 'Gómez', 'maria@mail.com', 2),
    ('Pedro', 'lucio', 'pedro@mail.com', 1),
    ('Sonia', 'Garcia', 'sonia@mail.com', 1),
    ('Daniel', 'Sanchez', 'daniel@mail.com', 2),
    ('Luis', 'Martínez', 'luis@mail.com', 1);
INSERT INTO profesores (nombre, apellido, id_curso_profesor)
VALUES
    ('Juan', 'Pérez', 1),
    ('María', 'Gómez', 2);
SELECT* 
FROM estudiantes;
INSERT INTO calificaciones (nota, id_profesor_calificación, id_estudiante_calificación)
VALUES
    (8.2, 2, 7), -- Calificación para el estudiante con ID 1
    (6.5, 1, 8), -- Calificación para el estudiante con ID 2
    (4.5, 1, 9), -- Calificación para el estudiante con ID 3
    (9.4, 2, 10), -- Calificación para el estudiante con ID 4
    (7.7, 2, 11), -- Calificación para el estudiante con ID 5
    (5.8, 1, 12);-- Calificación para el estudiante con ID 6
-- Scripts de consulta SQL para:
-- La nota media que da cada profesor.
SELECT p.nombre AS "Nombre profesor", AVG(c.nota) AS "Nota Media"
FROM profesores p
JOIN calificaciones c ON p.id_profesor = c.id_profesor_calificación
GROUP BY p.nombre;
-- Las mejores calificaciones de cada estudiante.
SELECT e.nombre AS nombre_estudiante, MAX(c.nota) AS mejor_calificacion
FROM estudiantes e
JOIN calificaciones c ON e.id_estudiante = c.id_estudiante_calificación
GROUP BY e.nombre;
-- Ordenar a los estudiantes por los cursos en los que están matriculados.
SELECT e.nombre AS nombre_estudiante, c.materia AS curso_matriculado
FROM estudiantes e
JOIN cursos c ON e.id_curso_estudiante = c.id_curso;
-- Cree un informe resumido de los cursos y sus calificaciones promedio, ordenados desde el curso más desafiante (curso con la calificación promedio más baja) hasta el curso más fácil.
SELECT c.materia AS nombre_curso, AVG(cal.nota) AS calificacion_promedio
FROM cursos c
LEFT JOIN calificaciones cal ON c.id_curso = cal.id_profesor_calificación
GROUP BY c.materia
ORDER BY calificacion_promedio ASC;
-- Encontrar qué estudiante y profesor tienen más cursos en común
SELECT e.nombre AS nombre_estudiante, p.nombre AS nombre_profesor, COUNT(*) AS cantidad_cursos_en_comun
FROM estudiantes e
JOIN cursos ec ON e.id_curso_estudiante = ec.id_curso
JOIN profesores p ON ec.id_curso = p.id_curso_profesor
GROUP BY e.nombre, p.nombre
ORDER BY cantidad_cursos_en_comun DESC;
