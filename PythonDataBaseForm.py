import mysql.connector
from tkinter import messagebox
import tkinter as tk

def connect_db():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="05012007ffrr",
        database="student_performance"
    )

# Функція для пошуку даних студента за ID або прізвищем
def find_student():
    search_input = entry_student_id.get()
    db = connect_db()
    cursor = db.cursor()

    try:
        # Очищення попереднього виводу
        text_result.delete("1.0", tk.END)

        if search_input.isdigit():
            query = """
                SELECT student_id, first_name, last_name, date_of_birth, email, gender, phone_number, enrollment_year 
                FROM students 
                WHERE student_id = %s
            """
            cursor.execute(query, (search_input,))
        else:
            query = """
                SELECT student_id, first_name, last_name, date_of_birth, email, gender, phone_number, enrollment_year 
                FROM students 
                WHERE last_name = %s
            """
            cursor.execute(query, (search_input,))

        record = cursor.fetchone()

        if record:
            student_info = (f"ID: {record[0]}\nІм'я: {record[1]}\nПрізвище: {record[2]}\n"
                            f"Дата народження: {record[3]}\nEmail: {record[4]}\nСтать: {record[5]}\n"
                            f"Телефон: {record[6]}\nРік зарахування: {record[7]}")
            text_result.insert(tk.END, student_info)
        else:
            text_result.insert(tk.END, "Студента не знайдено.")

    except mysql.connector.Error as err:
        messagebox.showerror("Помилка", f"Помилка з базою даних: {err}")

    finally:
        cursor.close()
        db.close()


# Функція для відображення оцінок студента за ID або прізвищем
def show_grades():
    search_input = entry_student_id.get()
    db = connect_db()
    cursor = db.cursor()

    try:
        text_result.delete("1.0", tk.END)

        if search_input.isdigit():
            query = """
                SELECT c.course_name, g.grade 
                FROM grades g
                JOIN courses c ON g.course_id = c.course_id
                WHERE g.student_id = %s
            """
            cursor.execute(query, (search_input,))
        else:
            query = """
                SELECT c.course_name, g.grade 
                FROM grades g
                JOIN students s ON s.student_id = g.student_id
                JOIN courses c ON g.course_id = c.course_id
                WHERE s.last_name = %s
            """
            cursor.execute(query, (search_input,))

        records = cursor.fetchall()

        if records:
            grades_info = "Оцінки:\n" + "\n".join(f"{course}: {grade}" for course, grade in records)
            text_result.insert(tk.END, grades_info)
        else:
            text_result.insert(tk.END, "Оцінок немає.")

    except mysql.connector.Error as err:
        messagebox.showerror("Помилка", f"Помилка з базою даних: {err}")

    finally:
        cursor.close()
        db.close()


# Функція для розрахунку середнього значення оцінок студента за ID або прізвищем
def calculate_average():
    search_input = entry_student_id.get()
    db = connect_db()
    cursor = db.cursor()

    try:
        text_result.delete("1.0", tk.END)

        if search_input.isdigit():
            query = "SELECT AVG(grade) FROM grades WHERE student_id = %s"
            cursor.execute(query, (search_input,))
        else:
            query = """
                SELECT AVG(g.grade) 
                FROM grades g
                JOIN students s ON s.student_id = g.student_id
                WHERE s.last_name = %s
            """
            cursor.execute(query, (search_input,))

        avg_grade = cursor.fetchone()[0]
        result = f"Середній бал: {avg_grade:.2f}" if avg_grade else "Оцінок немає."
        text_result.insert(tk.END, result)

    except mysql.connector.Error as err:
        messagebox.showerror("Помилка", f"Помилка з базою даних: {err}")

    finally:
        cursor.close()
        db.close()


# Функція для відображення заліків з екзаменів студента
def show_enrollments():
    search_input = entry_student_id.get()
    db = connect_db()
    cursor = db.cursor()

    try:
        text_result.delete("1.0", tk.END)

        if search_input.isdigit():
            query = """
                SELECT c.course_name, e.semester
                FROM enrollments e
                JOIN courses c ON e.course_id = c.course_id
                WHERE e.student_id = %s
            """
            cursor.execute(query, (search_input,))
        else:
            query = """
                SELECT c.course_name, e.semester
                FROM enrollments e
                JOIN students s ON s.student_id = e.student_id
                JOIN courses c ON e.course_id = c.course_id
                WHERE s.last_name = %s
            """
            cursor.execute(query, (search_input,))

        records = cursor.fetchall()

        if records:
            enrollments_info = "Заліки з екзаменів:\n" + "\n".join(
                f"{course} - {semester}" for course, semester in records)
            text_result.insert(tk.END, enrollments_info)
        else:
            text_result.insert(tk.END, "Заліків з екзаменів немає.")

    except mysql.connector.Error as err:
        messagebox.showerror("Помилка", f"Помилка з базою даних: {err}")

    finally:
        cursor.close()
        db.close()


# Функція для пошуку студентів з оцінками нижче вказаного значення
def find_students_below_grade():
    grade_input = entry_grade.get()
    db = connect_db()
    cursor = db.cursor()

    try:
        text_result.delete("1.0", tk.END)

        query = """ 
        SELECT s.first_name, s.last_name, c.course_name, g.grade
        FROM grades g
        JOIN students s ON g.student_id = s.student_id
        JOIN courses c ON g.course_id = c.course_id
        WHERE g.grade < %s
        """
        cursor.execute(query, (grade_input,))
        records = cursor.fetchall()

        if records:
            result = "Студенти з оцінками нижче вказаного значення:\n" + \
                     "\n".join(
                         f"{first_name} {last_name} - {course}: {grade}" for first_name, last_name, course, grade in
                         records)
            text_result.insert(tk.END, result)
        else:
            text_result.insert(tk.END, "Не знайдено студентів з оцінками меншими за вказану.")

    except mysql.connector.Error as err:
        messagebox.showerror("Помилка", f"Помилка з базою даних: {err}")

    finally:
        cursor.close()
        db.close()


# Функція для пошуку найвищої оцінки студента по кожному предмету
def find_highest_grade():
    student_id_input = entry_student_id_highest.get()
    db = connect_db()
    cursor = db.cursor()

    try:
        text_result.delete("1.0", tk.END)

        query = """ 
        SELECT s.first_name, s.last_name, c.course_name, g.grade AS highest_grade
        FROM grades g
        JOIN students s ON g.student_id = s.student_id
        JOIN courses c ON g.course_id = c.course_id
        WHERE g.student_id = %s
        AND g.grade = (
            SELECT MAX(grade)
            FROM grades
            WHERE student_id = g.student_id
        )
        """
        cursor.execute(query, (student_id_input,))
        records = cursor.fetchall()

        if records:
            result = "Найвищі оцінки студента:\n" + \
                     "\n".join(f"{first_name} {last_name} - {course}: {highest_grade}" for
                               first_name, last_name, course, highest_grade in records)
            text_result.insert(tk.END, result)
        else:
            text_result.insert(tk.END, "Немає оцінок для цього студента.")

    except mysql.connector.Error as err:
        messagebox.showerror("Помилка", f"Помилка з базою даних: {err}")

    finally:
        cursor.close()
        db.close()


# Функція для підрахунку кількості предметів з середнім балом більшим за вказане значення
def find_courses_above_average():
    avg_input = entry_avg.get()
    db = connect_db()
    cursor = db.cursor()

    try:
        text_result.delete("1.0", tk.END)

        query = """ 
        SELECT s.first_name, s.last_name, COUNT(g.grade) AS courses_completed
        FROM grades g
        JOIN students s ON g.student_id = s.student_id
        WHERE g.grade >= %s
        GROUP BY s.student_id
        """
        cursor.execute(query, (avg_input,))
        records = cursor.fetchall()

        if records:
            result = "Кількість предметів з оцінкою вищою за середнє:\n" + \
                     "\n".join(f"{first_name} {last_name}: {courses_completed} предметів" for
                               first_name, last_name, courses_completed in records)
            text_result.insert(tk.END, result)
        else:
            text_result.insert(tk.END, "Немає студентів з оцінками більшими за вказане значення.")

    except mysql.connector.Error as err:
        messagebox.showerror("Помилка", f"Помилка з базою даних: {err}")

    finally:
        cursor.close()
        db.close()


# Функція для пошуку студентів, які не склали жодного предмета
def find_students_no_courses():
    db = connect_db()
    cursor = db.cursor()

    try:
        text_result.delete("1.0", tk.END)

        query = """ 
        SELECT s.first_name, s.last_name
        FROM students s
        LEFT JOIN grades g ON s.student_id = g.student_id
        WHERE g.grade IS NULL
        """
        cursor.execute(query)
        records = cursor.fetchall()

        if records:
            result = "Студенти, які не склали жодного предмета:\n" + \
                     "\n".join(f"{first_name} {last_name}" for first_name, last_name in records)
            text_result.insert(tk.END, result)
        else:
            text_result.insert(tk.END, "Немає студентів, які не склали жодного предмета.")

    except mysql.connector.Error as err:
        messagebox.showerror("Помилка", f"Помилка з базою даних: {err}")

    finally:
        cursor.close()
        db.close()


# Функція для виведення студентів, які мають найвищий бал за вказаний курс
def find_students_highest_grade_in_course():
    course_input = entry_course.get()
    db = connect_db()
    cursor = db.cursor()

    try:
        text_result.delete("1.0", tk.END)

        query = """ 
        SELECT s.first_name, s.last_name, MAX(g.grade) AS highest_grade
        FROM grades g
        JOIN students s ON g.student_id = s.student_id
        JOIN courses c ON g.course_id = c.course_id
        WHERE c.course_name = %s
        GROUP BY s.student_id
        HAVING MAX(g.grade) = (
            SELECT MAX(g2.grade)
            FROM grades g2
            JOIN courses c2 ON g2.course_id = c2.course_id
            WHERE c2.course_name = %s
        )
        """
        cursor.execute(query, (course_input, course_input))
        records = cursor.fetchall()

        if records:
            result = "Студенти з найвищим балом на курсі:\n" + \
                     "\n".join(f"{first_name} {last_name} - {highest_grade}" for first_name, last_name, highest_grade in
                               records)
            text_result.insert(tk.END, result)
        else:
            text_result.insert(tk.END, "Немає студентів з найвищим балом на цьому курсі.")

    except mysql.connector.Error as err:
        messagebox.showerror("Помилка", f"Помилка з базою даних: {err}")

    finally:
        cursor.close()
        db.close()


root = tk.Tk()
root.title("Студентська база даних")
root.geometry("1250x600")

# Перша секція: Пошук за ID чи прізвищем
tk.Label(root, text="ID або прізвище студента:").grid(row=0, column=0, padx=(10, 5), pady=5, sticky="e")
entry_student_id = tk.Entry(root)
entry_student_id.grid(row=0, column=1, padx=(0, 10), pady=5, sticky="w")

tk.Button(root, text="Інформація про студента", command=find_student, width=20, height=1).grid(row=0, column=2, padx=10,
                                                                                               pady=5)
tk.Button(root, text="Оцінки", command=show_grades, width=20, height=1).grid(row=1, column=2, padx=10, pady=5)
tk.Button(root, text="Середня оцінка", command=calculate_average, width=20, height=1).grid(row=2, column=2, padx=10,
                                                                                           pady=5)
tk.Button(root, text="Заліки з екзаменів студента", command=show_enrollments, width=20, height=1).grid(row=3, column=2,
                                                                                                       padx=10, pady=5)

# Друга секція: Пошук за оцінкою
tk.Label(root, text="Введіть оцінку для пошуку студентів з оцінкою меншою за вказану:").grid(row=4, column=0,
                                                                                             columnspan=2, padx=10,
                                                                                             pady=5, sticky="w")
entry_grade = tk.Entry(root)
entry_grade.grid(row=4, column=2, padx=10, pady=5)
tk.Button(root, text="Пошук студентів", command=find_students_below_grade, width=20, height=1).grid(row=4, column=3,
                                                                                                    padx=10, pady=5)

# Третя секція: Найвища оцінка студента
tk.Label(root, text="Введіть ID студента для пошуку найвищої оцінки по предметах:").grid(row=5, column=0, columnspan=2,
                                                                                         padx=10, pady=5, sticky="w")
entry_student_id_highest = tk.Entry(root)
entry_student_id_highest.grid(row=5, column=2, padx=10, pady=5)
tk.Button(root, text="Найвища оцінка студента", command=find_highest_grade, width=20, height=1).grid(row=5, column=3,
                                                                                                     padx=10, pady=5)

# Четверта секція: Підрахунок предметів із середнім балом більшим за вказане
tk.Label(root, text="Кількість предметів, які студент пройшов із середнім балом більшим за вказане значення:").grid(
    row=6, column=0, columnspan=2, padx=10, pady=5, sticky="w")
entry_avg = tk.Entry(root)
entry_avg.grid(row=6, column=2, padx=10, pady=5)
tk.Button(root, text="Кількість предметів", command=find_courses_above_average, width=20, height=1).grid(row=6,
                                                                                                         column=3,
                                                                                                         padx=10,
                                                                                                         pady=5)

# П'ята секція: Пошук студентів без оцінок
tk.Button(root, text="Студенти без оцінок", command=find_students_no_courses, width=20, height=1).grid(row=7, column=3,
                                                                                                       padx=10, pady=5)

# Шоста секція: Пошук студентів з найвищим балом за вказаний курс
tk.Label(root, text="Введіть назву курсу для пошуку студентів з найвищим балом:").grid(row=8, column=0, columnspan=2,
                                                                                       padx=10, pady=5, sticky="w")
entry_course = tk.Entry(root)
entry_course.grid(row=8, column=2, padx=10, pady=5)
tk.Button(root, text="Найвищий бал на курсі", command=find_students_highest_grade_in_course, width=20, height=1).grid(
    row=8, column=3, padx=10, pady=5)

# Поле для виведення результату з прокруткою
frame_result = tk.Frame(root)
frame_result.grid(row=0, column=4, rowspan=9, padx=20, pady=10, sticky="nsew")

# Створення текстового поля з скроллом
scrollbar = tk.Scrollbar(frame_result, orient="vertical")
text_result = tk.Text(frame_result, wrap="word", yscrollcommand=scrollbar.set, width=40, height=20, relief="sunken")
scrollbar.config(command=text_result.yview)

text_result.grid(row=0, column=0, sticky="nsew")
scrollbar.grid(row=0, column=1, sticky="ns")

frame_result.grid_rowconfigure(0, weight=1)
frame_result.grid_columnconfigure(0, weight=1)

root.mainloop()
