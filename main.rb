require 'date'

class Student
  attr_accessor :name, :surname, :date_of_birth


  @@students = []

  def initialize(name, surname, date_of_birth)
    @name = name
    @surname = surname
    @date_of_birth = date_of_birth

  
    if date_of_birth > Date.today
      raise ArgumentError, "День народження має бути в минулому"
    end


    unless @@students.any? { |s| s.name == name && s.surname == surname && s.date_of_birth == date_of_birth }
      @@students << self
    else
      puts "Студент з таким ім'ям, прізвищем і датою народження вже існує."
    end
  end

  def calculate_age
    ((Date.today - @date_of_birth).to_i / 365.25).floor
  end

  def self.add_student(student)
    @@students << student unless @@students.include?(student)
  end

  def self.remove_student(student)
    @@students.delete(student)
  end

  def self.get_students_by_age(age)
    @@students.select { |s| s.calculate_age == age }
  end

  def self.get_students_by_name(name)
    @@students.select { |s| s.name == name }
  end

  def self.all_students
    @@students
  end
end

loop do
  puts "\nВиберіть дію:"
  puts "1. Додати студента"
  puts "2. Знайти студентів за віком"
  puts "3. Знайти студентів за ім'ям"
  puts "4. Видалити студента"
  puts "5. Вивести список усіх студентів"
  puts "6. Вийти"
  print "Ваш вибір: "
  
  choice = gets.chomp.to_i

  case choice
  when 1
    puts "Введіть ім'я студента:"
    name = gets.chomp

    puts "Введіть прізвище студента:"
    surname = gets.chomp

    begin
      puts "Введіть дату народження (формат: рік-місяць-день, наприклад, 2006-01-20):"
      date_of_birth_input = gets.chomp
      date_of_birth = Date.parse(date_of_birth_input)

      student = Student.new(name, surname, date_of_birth)
      puts "Студента додано успішно!"

    rescue ArgumentError => e
      puts "Помилка: #{e.message}. Спробуйте ще раз."
    end

  when 2
    puts "Введіть вік для пошуку:"
    age = gets.chomp.to_i
    students = Student.get_students_by_age(age)
    
    if students.any?
      puts "Студенти з віком #{age}:"
      students.each { |s| puts "#{s.name} #{s.surname}, Дата народження: #{s.date_of_birth}" }
    else
      puts "Немає студентів з таким віком."
    end

  when 3
    puts "Введіть ім'я для пошуку:"
    name = gets.chomp
    students = Student.get_students_by_name(name)
    
    if students.any?
      puts "Студенти з ім'ям #{name}:"
      students.each { |s| puts "#{s.name} #{s.surname}, Дата народження: #{s.date_of_birth}" }
    else
      puts "Немає студентів з таким ім'ям."
    end

  when 4
    puts "Введіть ім'я студента для видалення:"
    name = gets.chomp

    puts "Введіть прізвище студента для видалення:"
    surname = gets.chomp

    puts "Введіть дату народження студента для видалення (формат: рік-місяць-день):"
    date_of_birth_input = gets.chomp
    date_of_birth = Date.parse(date_of_birth_input)

    Student.remove_student(name, surname, date_of_birth)
    puts "Студента видалено (якщо він існував у списку)."

  when 5
    puts "\nСписок всіх студентів:"
    Student.all_students.each do |s|
      puts "#{s.name} #{s.surname} - Вік: #{s.calculate_age}, Дата народження: #{s.date_of_birth}"
    end

  when 6
    puts "Завершення програми. До побачення!"
    break

  else
    puts "Невірний вибір. Спробуйте ще раз."
  end
end