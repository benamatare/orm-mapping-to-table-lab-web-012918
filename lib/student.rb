require 'pry'

class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

attr_accessor = :id, :name, :grade
attr_reader =

  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
    @id = id
    # binding.pry
  end

def name
  @name
end
def grade
  @grade
end
def id
  @id
end



def self.create_table
  sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name text,
      grade integer
    )
      SQL
      # binding.pry
  DB[:conn].execute(sql)
  #Set a variable sql equal to the actions I want to commit to a sql server
  #call that variable within the DB donnection line and utilize the execute method ON that thing
end

def self.drop_table
  sql = <<-SQL
    DROP TABLE students
      SQL
  DB[:conn].execute(sql)
end

def save
  sql = <<-SQL
    INSERT INTO students (name, grade)
    VALUES (?,?)
      SQL
  DB[:conn].execute(sql, self.name, self.grade)
  @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
end

def self.create(name:,grade:)
  student = Student.new(name, grade)
  student.save
  student
end
end
