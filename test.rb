require "csv"
require "thread"
require_relative "module"


class Quiz
    def initialize
        @answer = ""
        @question = ""
        @score = 0
        @totalQuestions = 0
        @timer = 5
    end

    extend Header

    def test_question(q)
        @thread1 = Thread.new{
            @answer = gets.chomp()
        }
        @question = q
        print "What is #{@question}: "
        @answer = ""
        @thread1.join(@timer)
        @thread1.kill()
        @answer = @answer.strip
    end

    def get_total_questions
        @totalQuestions
    end

    def get_answer
        @answer
    end

    def increment_score
        @score = @score + 1
    end

    def increment_total_questions
        @totalQuestions = @totalQuestions + 1
    end

    def get_score
        @score
    end

    def get_total_questions
        @totalQuestions
    end
end

Quiz.display_top_header()
@file = CSV.read('problems.csv', headers: true, header_converters: :symbol)
obj = Quiz.new()
x = rand(@file.count)
@file[:question] = @file[:question].rotate(x)
@file[:answer] = @file[:answer].rotate(x)
i = 0
q = 1
while i < @file.count()
    print "\nQ # #{q} - "
    obj.test_question(@file[:question][i])
    if obj.get_answer() == @file[:answer][i]
        obj.increment_score()
    end
    obj.increment_total_questions()
    i = i + 1
    q = q + 1
end

puts "\nCorrect Answers: #{obj.get_score()}\t Incorrect Answers: #{(obj.get_total_questions() - obj.get_score())}"
puts "Score: #{obj.get_score} / #{obj.get_total_questions}"