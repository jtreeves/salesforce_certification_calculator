require "minitest/autorun"
require "stringio"
require "o_stream_catcher"
require "salesforce_certification_calculator"

class UITest < Minitest::Test
    UI = SalesforceCertificationCalculator::UI
    FR = SalesforceCertificationCalculator::FileReader
    Exam = SalesforceCertificationCalculator::Exam
    reader = FR.new
    @@ui = UI.new
    @@exams = reader.generate_exams_list
    @@methods = @@ui.methods
    
    def test_select_list_or_new_exists
        assert_includes @@methods, :select_list_or_new, "should create an object with a method called select_list_or_new"
    end
    
    def test_select_specific_exam_exists
        assert_includes @@methods, :select_specific_exam, "should create an object with a method called select_specific_exam"
    end
    
    def test_provide_scores_exists
        assert_includes @@methods, :provide_scores, "should create an object with a method called provide_scores"
    end
    
    def test_provide_all_details_manually_exists
        assert_includes @@methods, :provide_all_details_manually, "should create an object with a method called provide_all_details_manually"
    end

    def test_select_list_or_new_returns_string
        choice = ""
        
        OStreamCatcher.catch do
            string_io = StringIO.new
            string_io.puts "LIST"
            string_io.rewind
            $stdin = string_io
            choice = @@ui.select_list_or_new
            $stdin = STDIN
        end

        assert_instance_of String, choice, "should return string after calling select_list_or_new"
    end

    def test_select_list_or_new_returns_list
        choice = ""
        
        OStreamCatcher.catch do
            string_io = StringIO.new
            string_io.puts "LIST"
            string_io.rewind
            $stdin = string_io
            choice = @@ui.select_list_or_new
            $stdin = STDIN
        end

        assert_equal "LIST", choice, "should return LIST after calling select_list_or_new if user inputted LIST"
    end

    def test_select_list_or_new_called_once_if_list
        result = OStreamCatcher.catch do
            string_io = StringIO.new
            string_io.puts "LIST"
            string_io.rewind
            $stdin = string_io
            @@ui.select_list_or_new
            $stdin = STDIN
        end

        assert_equal 1, result[1].scan("Do you want to select").length, "should only call select_list_or_new once if user inputted LIST"
    end

    def test_select_list_or_new_returns_new
        choice = ""
        
        OStreamCatcher.catch do
            string_io = StringIO.new
            string_io.puts "NEW"
            string_io.rewind
            $stdin = string_io
            choice = @@ui.select_list_or_new
            $stdin = STDIN
        end

        assert_equal "NEW", choice, "should return NEW after calling select_list_or_new if user inputted NEW"
    end

    def test_select_list_or_new_called_once_if_new
        result = OStreamCatcher.catch do
            string_io = StringIO.new
            string_io.puts "NEW"
            string_io.rewind
            $stdin = string_io
            @@ui.select_list_or_new
            $stdin = STDIN
        end

        assert_equal 1, result[1].scan("Do you want to select").length, "should only call select_list_or_new once if user inputted NEW"
    end

    def test_select_list_or_new_recursion
        result = OStreamCatcher.catch do
            string_io = StringIO.new
            string_io.puts "a"
            string_io.puts "NEW"
            string_io.rewind
            $stdin = string_io
            @@ui.select_list_or_new
            $stdin = STDIN
        end

        assert_operator result[1].scan("Do you want to select").length, :>, 1, "should call select_list_or_new more than once if user initially inputted something other than LIST or NEW"
    end

    def test_select_specific_exam_returns_exam
        choice = {}

        OStreamCatcher.catch do
            string_io = StringIO.new
            string_io.puts "1"
            string_io.rewind
            $stdin = string_io
            choice = @@ui.select_specific_exam(@@exams)
            $stdin = STDIN
        end

        assert_instance_of Exam, choice, "should return Exam object after calling select_specific_exam"
    end

    def test_select_specific_exam_returns_first_if_1
        choice = {}

        OStreamCatcher.catch do
            string_io = StringIO.new
            string_io.puts "1"
            string_io.rewind
            $stdin = string_io
            choice = @@ui.select_specific_exam(@@exams)
            $stdin = STDIN
        end

        assert_equal @@exams[0], choice, "should return first Exam object in exams array after calling select_specific_exam if 1 inputted"
    end

    def test_select_specific_exam_called_once_if_1
        result = OStreamCatcher.catch do
            string_io = StringIO.new
            string_io.puts "1"
            string_io.rewind
            $stdin = string_io
            @@ui.select_specific_exam(@@exams)
            $stdin = STDIN
        end

        assert_equal 1, result[1].scan("Which one would you like to select").length, "should call select_specific_exam only once if user inputs 1"
    end

    def test_select_specific_exam_returns_second_if_2
        choice = {}

        OStreamCatcher.catch do
            string_io = StringIO.new
            string_io.puts "2"
            string_io.rewind
            $stdin = string_io
            choice = @@ui.select_specific_exam(@@exams)
            $stdin = STDIN
        end

        assert_equal @@exams[1], choice, "should return second Exam object in exams array after calling select_specific_exam if 2 inputted"
    end

    def test_select_specific_exam_called_once_if_2
        result = OStreamCatcher.catch do
            string_io = StringIO.new
            string_io.puts "2"
            string_io.rewind
            $stdin = string_io
            @@ui.select_specific_exam(@@exams)
            $stdin = STDIN
        end

        assert_equal 1, result[1].scan("Which one would you like to select").length, "should call select_specific_exam only once if user inputs 2"
    end

    def test_select_specific_exam_call_provide_manually
        result = OStreamCatcher.catch do
            string_io = StringIO.new
            string_io.puts "#{@@exams.length + 1}"
            string_io.puts "My Test"
            string_io.puts "4"

            (1..4).each do |i|
                string_io.puts "Section #{i}"
                string_io.puts "25"
                string_io.puts "80"
            end

            string_io.rewind
            $stdin = string_io
            @@ui.select_specific_exam(@@exams)
            $stdin = STDIN
        end

        assert_equal 1, result[1].scan("What is the title of this exam?").length, "should call provide_all_details_manually if user enters NOT LISTED option"
    end

    def test_select_specific_exam_recursion_greater
        result = OStreamCatcher.catch do
            string_io = StringIO.new
            string_io.puts "30"
            string_io.puts "1"
            string_io.rewind
            $stdin = string_io
            @@ui.select_specific_exam(@@exams)
            $stdin = STDIN
        end

        assert_operator result[1].scan("Which one would you like to select").length, :>, 1, "should call select_specific_exam more than once if user inputs number above length of options"
    end

    def test_select_specific_exam_recursion_0
        result = OStreamCatcher.catch do
            string_io = StringIO.new
            string_io.puts "0"
            string_io.puts "1"
            string_io.rewind
            $stdin = string_io
            @@ui.select_specific_exam(@@exams)
            $stdin = STDIN
        end

        assert_operator result[1].scan("Which one would you like to select").length, :>, 1, "should call select_specific_exam more than once if user inputs 0"
    end

    def test_select_specific_exam_recursion_letter
        result = OStreamCatcher.catch do
            string_io = StringIO.new
            string_io.puts "a"
            string_io.puts "1"
            string_io.rewind
            $stdin = string_io
            @@ui.select_specific_exam(@@exams)
            $stdin = STDIN
        end

        assert_operator result[1].scan("Which one would you like to select").length, :>, 1, "should call select_specific_exam more than once if user inputs letter"
    end

    def test_select_specific_exam_recursion_title
        result = OStreamCatcher.catch do
            string_io = StringIO.new
            string_io.puts "Advanced Administrator"
            string_io.puts "1"
            string_io.rewind
            $stdin = string_io
            @@ui.select_specific_exam(@@exams)
            $stdin = STDIN
        end

        assert_operator result[1].scan("Which one would you like to select").length, :>, 1, "should call select_specific_exam more than once if user inputs title of exam instead of number"
    end

    def test_provide_scores_returns_exam
        result = {}

        OStreamCatcher.catch do
            string_io = StringIO.new

            @@exams[0].sections.each do |section|
                string_io.puts "70"
            end

            string_io.rewind
            $stdin = string_io
            result = @@ui.provide_scores(@@exams[0])
            $stdin = STDIN
        end

        assert_instance_of Exam, result, "should return Exam object after calling provide_scores"
    end

    def test_provide_scores_prompts_user_for_each_section
        result = OStreamCatcher.catch do
            string_io = StringIO.new

            @@exams[0].sections.each do |section|
                string_io.puts "70"
            end

            string_io.rewind
            $stdin = string_io
            @@ui.provide_scores(@@exams[0])
            $stdin = STDIN
        end

        assert_equal @@exams[0].sections.length, result[1].scan("What score did you get").length, "should prompt user for input once for every section of exam parameter when call provide_scores"
    end

    def test_provide_all_details_manually_returns_exam
        result = {}
        
        OStreamCatcher.catch do
            string_io = StringIO.new
            string_io.puts "My Test"
            string_io.puts "4"

            (1..4).each do |i|
                string_io.puts "Section #{i}"
                string_io.puts "25"
                string_io.puts "80"
            end

            string_io.rewind
            $stdin = string_io
            result = @@ui.provide_all_details_manually
            $stdin = STDIN
        end

        assert_instance_of Exam, result, "should return Exam object after calling provide_all_details_manually"
    end

    def test_provide_all_details_manually_prompts_user_2_more_than_3_times_sections
        sections = 4
        prompts = 2 + 3 * sections

        result = OStreamCatcher.catch do
            string_io = StringIO.new
            string_io.puts "My Test"
            string_io.puts "#{sections}"

            (1..sections).each do |i|
                string_io.puts "Section #{i}"
                string_io.puts "25"
                string_io.puts "80"
            end

            string_io.rewind
            $stdin = string_io
            @@ui.provide_all_details_manually
            $stdin = STDIN
        end

        assert_equal prompts, result[1].scan("\n").length, "should prompt user for input 2 more than 3 times the number of sections entered when call provide_all_details_manually"
    end
end