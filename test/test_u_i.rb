require "minitest/autorun"
require "stringio"
require "o_stream_catcher"
require "salesforce_certification_calculator"

class UITest < Minitest::Test
    UI = SalesforceCertificationCalculator::UI
    @@ui = UI.new
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
end