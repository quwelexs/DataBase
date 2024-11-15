DROP DATABASE IF EXISTS student_performance;
CREATE DATABASE student_performance;
USE student_performance;

-- Таблиця для студентів
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    email VARCHAR(100) NOT NULL,
    gender ENUM('male', 'female') NOT NULL,
    phone_number VARCHAR(30),
    enrollment_year YEAR DEFAULT 2022
);

-- Таблиця для курсів
CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credits INT
);

-- Таблиця для викладачів
CREATE TABLE teachers (
    teacher_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100)
);

-- Таблиця для заліків
CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    course_id INT,
    semester VARCHAR(20),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Таблиця для оцінок студентів
CREATE TABLE grades (
    grade_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    grade INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Вставка даних у таблицю студентів
INSERT INTO students (first_name, last_name, date_of_birth, email, gender, phone_number, enrollment_year) VALUES 
('Микола', 'Бестюк', '2007-06-26', 'mbestiuk@rcit.ukr.education', 'male', '+380-67-123-4567', 2022),
('Олександр', 'Бугайчук', '2006-11-15', 'obugaychuk@rcit.ukr.education', 'male', '+380-67-234-5678', 2022),
('Іван', 'Войтюк', '2006-08-03', 'ivoityuk@rcit.ukr.education', 'male', '+380-67-345-6789', 2022),
('Максим', 'Дейнека', '2007-02-12', 'mdeyneka@rcit.ukr.education', 'male', '+380-67-456-7890', 2022),
('Роман', 'Демчук', '2007-01-22', 'rdemchuk@rcit.ukr.education', 'male', '+380-67-567-8901', 2022),
('Микита', 'Дзюба', '2006-07-14', 'mdzyuba@rcit.ukr.education', 'male', '+380-67-678-9012', 2022),
('Ангеліна', 'Жуковська', '2007-04-25', 'azhukovska@rcit.ukr.education', 'female', '+380-67-789-0123', 2022),
('Максим', 'Завальнюк', '2006-09-30', 'mzavalnyuk@rcit.ukr.education', 'male', '+380-67-890-1234', 2022),
('Богдан', 'Карнасевич', '2007-05-18', 'bkarnasevych@rcit.ukr.education', 'male', '+380-67-901-2345', 2022),
('Валерій', 'Кочубей', '2007-03-09', 'vkochubey@rcit.ukr.education', 'male', '+380-67-012-3456', 2022),
('Роман', 'Мазурок', '2006-12-27', 'rmazurok@rcit.ukr.education', 'male', '+380-67-123-4568', 2022),
('Олександр', 'Мальцев', '2007-06-10', 'omalcev@rcit.ukr.education', 'male', '+380-67-234-5679', 2022),
('Антон', 'Новосвітний', '2006-11-02', 'anovosvitniy@rcit.ukr.education', 'male', '+380-67-345-6780', 2022),
('Вадим', 'Плисюк', '2007-01-30', 'vplisyuk@rcit.ukr.education', 'male', '+380-67-456-7891', 2022),
('Станіслав', 'Скорий', '2006-08-19', 'sskoriy@rcit.ukr.education', 'male', '+380-67-567-8902', 2022),
('Степан', 'Сухецький', '2007-05-07', 'ssuheckiy@rcit.ukr.education', 'male', '+380-67-678-9013', 2022),
('Максим', 'Сущук', '2006-10-16', 'msushchuk@rcit.ukr.education', 'male', '+380-67-789-0124', 2022),
('Руслана', 'Ткачук-Чуреєва', '2007-04-01', 'rtkachukchur@rcit.ukr.education', 'female', '+380-67-890-1235', 2022),
('Іван', 'Тополюк', '2006-09-05', 'itopolyuk@rcit.ukr.education', 'male', '+380-67-901-2346', 2022),
('Даниїл', 'Хоровець', '2007-02-18', 'dhorovets@rcit.ukr.education', 'male', '+380-67-012-3457', 2022),
('Вероніка', 'Швець', '2007-03-27', 'vshvets@rcit.ukr.education', 'female', '+380-67-123-4569', 2022);

-- Вставка даних у таблицю викладачів
INSERT INTO teachers (first_name, last_name, email) VALUES
('Андрій', 'Ніколаєнко', 'a.i.nikolaienko@rcit.ukr.education'),
('Вікторія', 'Гонтар', 'v.gontar@rcit.ukr.education'),
('Тамара', 'Вербило', 't.verbilo@rcit.ukr.education'),
('Тарас', 'Мельник', 't.melnik@rcit.ukr.education'),
('Любов', 'Шостак', 'l.shostak@rcit.ukr.education'),
('Іван', 'Конончук', 'i.kononchuk@rcit.ukr.education'),
('Олександр', 'Шпортько', 'o.shportko@rcit.ukr.education');

-- Вставка даних у таблицю курсів
INSERT INTO courses (course_name, credits) VALUES
('Database', 3),
('English', 2),
('Ukrainian Language', 2),
('Algorithms and Data Structures', 5),
('Software Quality Assurance', 3),
('Software Engineering & System Design', 4),
('Physical Education', 1),
('Programming Fundamentals', 3);

-- Вставка даних у таблицю заліків
INSERT INTO enrollments (student_id, first_name, last_name, course_id, semester) VALUES
(1, 'Микола', 'Бестюк', 1, 'Fall 2024'), (1, 'Микола', 'Бестюк', 2, 'Fall 2024'),
(2, 'Олександр', 'Бугайчук', 1, 'Fall 2024'), (2, 'Олександр', 'Бугайчук', 3, 'Fall 2024'),
(3, 'Іван', 'Войтюк', 1, 'Fall 2024'), (3, 'Іван', 'Войтюк', 4, 'Fall 2024'),
(4, 'Максим', 'Дейнека', 2, 'Fall 2024'), (4, 'Максим', 'Дейнека', 5, 'Fall 2024'),
(5, 'Роман', 'Демчук', 1, 'Fall 2024'), (5, 'Роман', 'Демчук', 6, 'Fall 2024'),
(6, 'Микита', 'Дзюба', 3, 'Fall 2024'), (6, 'Микита', 'Дзюба', 7, 'Fall 2024'),
(7, 'Ангеліна', 'Жуковська', 2, 'Fall 2024'), (7, 'Ангеліна', 'Жуковська', 4, 'Fall 2024'),
(8, 'Максим', 'Завальнюк', 1, 'Fall 2024'), (8, 'Максим', 'Завальнюк', 5, 'Fall 2024'),
(9, 'Богдан', 'Карнасевич', 6, 'Fall 2024'), (9, 'Богдан', 'Карнасевич', 7, 'Fall 2024'),
(10, 'Валерій', 'Кочубей', 3, 'Fall 2024'), (10, 'Валерій', 'Кочубей', 8, 'Fall 2024'),
(11, 'Роман', 'Мазурок', 2, 'Fall 2024'), (11, 'Роман', 'Мазурок', 5, 'Fall 2024'),
(12, 'Олександр', 'Мальцев', 1, 'Fall 2024'), (12, 'Олександр', 'Мальцев', 6, 'Fall 2024'),
(13, 'Антон', 'Новосвітний', 4, 'Fall 2024'), (13, 'Антон', 'Новосвітний', 7, 'Fall 2024'),
(14, 'Вадим', 'Плисюк', 3, 'Fall 2024'), (14, 'Вадим', 'Плисюк', 8, 'Fall 2024'),
(15, 'Станіслав', 'Скорий', 2, 'Fall 2024'), (15, 'Станіслав', 'Скорий', 5, 'Fall 2024'),
(16, 'Степан', 'Сухецький', 1, 'Fall 2024'), (16, 'Степан', 'Сухецький', 6, 'Fall 2024'),
(17, 'Максим', 'Сущук', 4, 'Fall 2024'), (17, 'Максим', 'Сущук', 7, 'Fall 2024'),
(18, 'Руслана', 'Ткачук-Чуреєва', 3, 'Fall 2024'), (18, 'Руслана', 'Ткачук-Чуреєва', 8, 'Fall 2024'),
(19, 'Іван', 'Тополюк', 1, 'Fall 2024'), (19, 'Іван', 'Тополюк', 6, 'Fall 2024'),
(20, 'Даниїл', 'Хоровець', 4, 'Fall 2024'), (20, 'Даниїл', 'Хоровець', 7, 'Fall 2024'),
(21, 'Вероніка', 'Швець', 3, 'Fall 2024'), (21, 'Вероніка', 'Швець', 8, 'Fall 2024');

-- Вставка даних у таблицю оцінок
INSERT INTO grades (student_id, course_id, grade) VALUES 
(1, 1, FLOOR(RAND() * 4) + 2), (1, 2, FLOOR(RAND() * 4) + 2), (1, 3, FLOOR(RAND() * 4) + 2), 
(1, 4, FLOOR(RAND() * 4) + 2), (1, 5, FLOOR(RAND() * 4) + 2), (1, 6, FLOOR(RAND() * 4) + 2), 
(1, 7, FLOOR(RAND() * 4) + 2), (1, 8, FLOOR(RAND() * 4) + 2),
(2, 1, FLOOR(RAND() * 4) + 2), (2, 2, FLOOR(RAND() * 4) + 2), (2, 3, FLOOR(RAND() * 4) + 2), 
(2, 4, FLOOR(RAND() * 4) + 2), (2, 5, FLOOR(RAND() * 4) + 2), (2, 6, FLOOR(RAND() * 4) + 2), 
(2, 7, FLOOR(RAND() * 4) + 2), (2, 8, FLOOR(RAND() * 4) + 2),
(3, 1, FLOOR(RAND() * 4) + 2), (3, 2, FLOOR(RAND() * 4) + 2), (3, 3, FLOOR(RAND() * 4) + 2), 
(3, 4, FLOOR(RAND() * 4) + 2), (3, 5, FLOOR(RAND() * 4) + 2), (3, 6, FLOOR(RAND() * 4) + 2), 
(3, 7, FLOOR(RAND() * 4) + 2), (3, 8, FLOOR(RAND() * 4) + 2),
(4, 1, FLOOR(RAND() * 4) + 2), (4, 2, FLOOR(RAND() * 4) + 2), (4, 3, FLOOR(RAND() * 4) + 2), 
(4, 4, FLOOR(RAND() * 4) + 2), (4, 5, FLOOR(RAND() * 4) + 2), (4, 6, FLOOR(RAND() * 4) + 2), 
(4, 7, FLOOR(RAND() * 4) + 2), (4, 8, FLOOR(RAND() * 4) + 2),
(5, 1, FLOOR(RAND() * 4) + 2), (5, 2, FLOOR(RAND() * 4) + 2), (5, 3, FLOOR(RAND() * 4) + 2), 
(5, 4, FLOOR(RAND() * 4) + 2), (5, 5, FLOOR(RAND() * 4) + 2), (5, 6, FLOOR(RAND() * 4) + 2), 
(5, 7, FLOOR(RAND() * 4) + 2), (5, 8, FLOOR(RAND() * 4) + 2),
(6, 1, FLOOR(RAND() * 4) + 2), (6, 2, FLOOR(RAND() * 4) + 2), (6, 3, FLOOR(RAND() * 4) + 2), 
(6, 4, FLOOR(RAND() * 4) + 2), (6, 5, FLOOR(RAND() * 4) + 2), (6, 6, FLOOR(RAND() * 4) + 2), 
(6, 7, FLOOR(RAND() * 4) + 2), (6, 8, FLOOR(RAND() * 4) + 2),
(7, 1, FLOOR(RAND() * 4) + 2), (7, 2, FLOOR(RAND() * 4) + 2), (7, 3, FLOOR(RAND() * 4) + 2), 
(7, 4, FLOOR(RAND() * 4) + 2), (7, 5, FLOOR(RAND() * 4) + 2), (7, 6, FLOOR(RAND() * 4) + 2), 
(7, 7, FLOOR(RAND() * 4) + 2), (7, 8, FLOOR(RAND() * 4) + 2),
(8, 1, FLOOR(RAND() * 4) + 2), (8, 2, FLOOR(RAND() * 4) + 2), (8, 3, FLOOR(RAND() * 4) + 2), 
(8, 4, FLOOR(RAND() * 4) + 2), (8, 5, FLOOR(RAND() * 4) + 2), (8, 6, FLOOR(RAND() * 4) + 2), 
(8, 7, FLOOR(RAND() * 4) + 2), (8, 8, FLOOR(RAND() * 4) + 2),
(9, 1, FLOOR(RAND() * 4) + 2), (9, 2, FLOOR(RAND() * 4) + 2), (9, 3, FLOOR(RAND() * 4) + 2), 
(9, 4, FLOOR(RAND() * 4) + 2), (9, 5, FLOOR(RAND() * 4) + 2), (9, 6, FLOOR(RAND() * 4) + 2), 
(9, 7, FLOOR(RAND() * 4) + 2), (9, 8, FLOOR(RAND() * 4) + 2),
(10, 1, FLOOR(RAND() * 4) + 2), (10, 2, FLOOR(RAND() * 4) + 2), (10, 3, FLOOR(RAND() * 4) + 2), 
(10, 4, FLOOR(RAND() * 4) + 2), (10, 5, FLOOR(RAND() * 4) + 2), (10, 6, FLOOR(RAND() * 4) + 2), 
(10, 7, FLOOR(RAND() * 4) + 2), (10, 8, FLOOR(RAND() * 4) + 2),
(11, 1, FLOOR(RAND() * 4) + 2), (11, 2, FLOOR(RAND() * 4) + 2), (11, 3, FLOOR(RAND() * 4) + 2), 
(11, 4, FLOOR(RAND() * 4) + 2), (11, 5, FLOOR(RAND() * 4) + 2), (11, 6, FLOOR(RAND() * 4) + 2), 
(11, 7, FLOOR(RAND() * 4) + 2), (11, 8, FLOOR(RAND() * 4) + 2),
(12, 1, FLOOR(RAND() * 4) + 2), (12, 2, FLOOR(RAND() * 4) + 2), (12, 3, FLOOR(RAND() * 4) + 2), 
(12, 4, FLOOR(RAND() * 4) + 2), (12, 5, FLOOR(RAND() * 4) + 2), (12, 6, FLOOR(RAND() * 4) + 2), 
(12, 7, FLOOR(RAND() * 4) + 2), (12, 8, FLOOR(RAND() * 4) + 2),
(13, 1, FLOOR(RAND() * 4) + 2), (13, 2, FLOOR(RAND() * 4) + 2), (13, 3, FLOOR(RAND() * 4) + 2), 
(13, 4, FLOOR(RAND() * 4) + 2), (13, 5, FLOOR(RAND() * 4) + 2), (13, 6, FLOOR(RAND() * 4) + 2), 
(13, 7, FLOOR(RAND() * 4) + 2), (13, 8, FLOOR(RAND() * 4) + 2),
(14, 1, FLOOR(RAND() * 4) + 2), (14, 2, FLOOR(RAND() * 4) + 2), (14, 3, FLOOR(RAND() * 4) + 2), 
(14, 4, FLOOR(RAND() * 4) + 2), (14, 5, FLOOR(RAND() * 4) + 2), (14, 6, FLOOR(RAND() * 4) + 2), 
(14, 7, FLOOR(RAND() * 4) + 2), (14, 8, FLOOR(RAND() * 4) + 2),
(15, 1, FLOOR(RAND() * 4) + 2), (15, 2, FLOOR(RAND() * 4) + 2), (15, 3, FLOOR(RAND() * 4) + 2), 
(15, 4, FLOOR(RAND() * 4) + 2), (15, 5, FLOOR(RAND() * 4) + 2), (15, 6, FLOOR(RAND() * 4) + 2), 
(15, 7, FLOOR(RAND() * 4) + 2), (15, 8, FLOOR(RAND() * 4) + 2),
(16, 1, FLOOR(RAND() * 4) + 2), (16, 2, FLOOR(RAND() * 4) + 2), (16, 3, FLOOR(RAND() * 4) + 2), 
(16, 4, FLOOR(RAND() * 4) + 2), (16, 5, FLOOR(RAND() * 4) + 2), (16, 6, FLOOR(RAND() * 4) + 2), 
(16, 7, FLOOR(RAND() * 4) + 2), (16, 8, FLOOR(RAND() * 4) + 2),
(17, 1, FLOOR(RAND() * 4) + 2), (17, 2, FLOOR(RAND() * 4) + 2), (17, 3, FLOOR(RAND() * 4) + 2), 
(17, 4, FLOOR(RAND() * 4) + 2), (17, 5, FLOOR(RAND() * 4) + 2), (17, 6, FLOOR(RAND() * 4) + 2), 
(17, 7, FLOOR(RAND() * 4) + 2), (17, 8, FLOOR(RAND() * 4) + 2),
(18, 1, FLOOR(RAND() * 4) + 2), (18, 2, FLOOR(RAND() * 4) + 2), (18, 3, FLOOR(RAND() * 4) + 2), 
(18, 4, FLOOR(RAND() * 4) + 2), (18, 5, FLOOR(RAND() * 4) + 2), (18, 6, FLOOR(RAND() * 4) + 2), 
(18, 7, FLOOR(RAND() * 4) + 2), (18, 8, FLOOR(RAND() * 4) + 2),
(19, 1, FLOOR(RAND() * 4) + 2), (19, 2, FLOOR(RAND() * 4) + 2), (19, 3, FLOOR(RAND() * 4) + 2), 
(19, 4, FLOOR(RAND() * 4) + 2), (19, 5, FLOOR(RAND() * 4) + 2), (19, 6, FLOOR(RAND() * 4) + 2), 
(19, 7, FLOOR(RAND() * 4) + 2), (19, 8, FLOOR(RAND() * 4) + 2),
(20, 1, FLOOR(RAND() * 4) + 2), (20, 2, FLOOR(RAND() * 4) + 2), (20, 3, FLOOR(RAND() * 4) + 2), 
(20, 4, FLOOR(RAND() * 4) + 2), (20, 5, FLOOR(RAND() * 4) + 2), (20, 6, FLOOR(RAND() * 4) + 2), 
(20, 7, FLOOR(RAND() * 4) + 2), (20, 8, FLOOR(RAND() * 4) + 2),
(21, 1, FLOOR(RAND() * 4) + 2), (21, 2, FLOOR(RAND() * 4) + 2), (21, 3, FLOOR(RAND() * 4) + 2), 
(21, 4, FLOOR(RAND() * 4) + 2), (21, 5, FLOOR(RAND() * 4) + 2), (21, 6, FLOOR(RAND() * 4) + 2), 
(21, 7, FLOOR(RAND() * 4) + 2), (21, 8, FLOOR(RAND() * 4) + 2);

SELECT * FROM students;
SELECT * FROM courses;
SELECT * FROM teachers;
SELECT * FROM enrollments;

-- Пошук студента за ID
SELECT s.first_name, s.last_name, c.course_name, g.grade
FROM grades g
JOIN students s ON g.student_id = s.student_id
JOIN courses c ON g.course_id = c.course_id
WHERE s.student_id = 1;

-- Обчислення середнього балу студента
SELECT s.first_name, s.last_name, AVG(g.grade) AS average_grade
FROM grades g
JOIN students s ON g.student_id = s.student_id
GROUP BY s.student_id;

-- Пошук студентів у яких оцінка менша вказаної
SELECT s.first_name, s.last_name, c.course_name, g.grade
FROM grades g
JOIN students s ON g.student_id = s.student_id
JOIN courses c ON g.course_id = c.course_id
WHERE g.grade < 4;

 -- Пошук найвищої оцінки студента по кожному предмету
SELECT s.first_name, s.last_name, c.course_name, g.grade AS highest_grade
FROM grades g
JOIN students s ON g.student_id = s.student_id
JOIN courses c ON g.course_id = c.course_id
WHERE g.student_id = 2 -- ID студента тут
  AND g.grade = (
    SELECT MAX(grade)
    FROM grades
    WHERE student_id = g.student_id
  );

-- Підрахунок кількості предметів, які студент пройшов із середнім балом більшим за вказане значення
SELECT s.first_name, s.last_name, COUNT(g.grade) AS courses_completed
FROM grades g
JOIN students s ON g.student_id = s.student_id
WHERE g.grade >= 4
GROUP BY s.student_id;

-- Пошук студентів, які не склали жодного предмета
SELECT s.first_name, s.last_name
FROM students s
LEFT JOIN grades g ON s.student_id = g.student_id
WHERE g.grade IS NULL;

-- Виведення студентів, що мають найвищий бал за вказаний курс
SELECT s.first_name, s.last_name, MAX(g.grade) AS highest_grade
FROM grades g
JOIN students s ON g.student_id = s.student_id
JOIN courses c ON g.course_id = c.course_id
WHERE (c.course_name = 'Database' OR c.course_id = 1)
GROUP BY s.student_id
HAVING MAX(g.grade) = (
    SELECT MAX(g2.grade)
    FROM grades g2
    JOIN courses c2 ON g2.course_id = c2.course_id
    WHERE (c2.course_name = 'Database' OR c2.course_id = 1)
);

show tables;