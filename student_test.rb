require 'minitest/autorun'
require 'minitest/reporters'
require_relative 'main' 
require 'date'

Minitest::Reporters.use! [Minitest::Reporters::HtmlReporter.new(reports_dir: './ruby_homework')]

class StudentUnitTest < Minitest::Test
  def setup

    @student1 = Student.new("Iryna", "Lomaka", Date.new(2006, 1, 20))
    @student2 = Student.new("Olga", "Shevchenko", Date.new(1998, 2, 20))
  end

  def test_initialize

    assert_equal "Iryna", @student1.name
    assert_equal "Lomaka", @student1.surname
    assert_equal 18, @student1.calculate_age 
  end

  def test_add_student
    Student.add_student(@student1)
    assert_includes Student.all_students, @student1
  end

  def test_remove_student
    Student.add_student(@student1)
    Student.remove_student(@student1)
    refute_includes Student.all_students, @student1
  end

  def test_get_students_by_age
    students = Student.get_students_by_age(18) 
    assert_includes students, @student1 if @student1.calculate_age == 18
  end

  def test_get_students_by_name
    students = Student.get_students_by_name("Iryna")
    assert_includes students, @student1
  end

  def test_date_of_birth_in_future
    assert_raises(ArgumentError) { Student.new("Test", "Future", Date.today + 1) }
  end
end


describe Student do
  before do
    @student1 = Student.new("Iryna", "Lomaka", Date.new(2000, 5, 15))
    @student2 = Student.new("Olga", "Shevchenko", Date.new(1998, 2, 20))
  end

  it "calculates age correctly" do
    _(@student1.calculate_age).must_equal 18 
  end

  it "adds a student to the list" do
    Student.add_student(@student1)
    _(Student.all_students).must_include @student1
  end

  it "removes a student from the list" do
    Student.add_student(@student1)
    Student.remove_student(@student1)
    _(Student.all_students).wont_include @student1
  end

  it "finds students by age" do
    students = Student.get_students_by_age(23)
    _(students).must_include @student1 if @student1.calculate_age == 18
  end

  it "finds students by name" do
    students = Student.get_students_by_name("Ivan")
    _(students).must_include @student1
  end

  it "raises error if date of birth is in the future" do
    expect { Student.new("Test", "Future", Date.today + 1) }.must_raise ArgumentError
  end
end
