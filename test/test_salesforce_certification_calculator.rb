require "minitest/autorun"
require "salesforce_certification_calculator"

class SalesforceTest < Minitest::Test
    SFC = SalesforceCertificationCalculator
    @@calculator = SFC.new
    @@methods = @@calculator.methods

    def test_initialize_exam_exists
        assert_includes @@methods, :exam, "should create an object with an exam attribute"
    end

    def test_initialize_exam_type
        assert_instance_of SFC::Exam, @@calculator.exam, "should create an object with an exam attribute of type Exam"
    end

    def test_generate_exams_list_exists
        assert_includes @@methods, :generate_exams_list, "should create an object with a method called generate_exams_list"
    end

    def test_extract_initial_exam_data_exists
        assert_includes @@methods, :extract_initial_exam_data, "should create an object with a method called extract_initial_exam_data"
    end

    def test_calculate_total_exists
        assert_includes @@methods, :calculate_total, "should create an object with a method called calculate_total"
    end
    
    def test_generate_exams_list_makes_exams_attribute_contain_21_items
        @@calculator.generate_exams_list

        assert_equal 21, @@calculator.exams.length, "should make exams attribute contain 21 elements when invoke generate_exams_list"
    end
    
    def test_generate_exams_list_makes_exams_attribute_contain_exams
        @@calculator.generate_exams_list

        @@calculator.exams.each do |exam|
            assert_instance_of SFC::Exam, exam, "should make exams attribute contain Exam objects when invoke generate_exams_list"
        end
    end
    
    def test_generate_exams_list_contains_no_sections
        @@calculator.generate_exams_list

        @@calculator.exams.each do |exam|
            assert_equal 0, exam.sections.length, "should not fill any sections on any of the exams now included in the attribute"
        end
    end
    
    def test_generate_exams_list_contains_administrator
        @@calculator.generate_exams_list

        exists = @@calculator.exams.any? { |exam| exam.title == "Administrator - Spring 2022" }
        
        assert_equal true, exists, "should set exams attribute to an array containing one exam with the Administrator title when invoke generate_exams_list"
    end
    
    def test_generate_exams_list_contains_multiple_marketings
        @@calculator.generate_exams_list
        marketings = 0

        @@calculator.exams.each do |exam| 
            if exam.title.include? "Marketing"
                marketings += 1
            end
        end
        
        assert_operator marketings, :>, 1, "should set exams attribute to an array containing multiple objects with titles including Marketing when invoke generate_exams_list"
    end
    
    def test_extract_initial_exam_data_sets_exam_sections
        @@calculator.generate_exams_list
        @@calculator.exam = @@calculator.exams[0]
        @@calculator.extract_initial_exam_data

        assert_operator @@calculator.exam.sections.length, :>, 0, "should populate sections on exam attribute when invoke extract_initial_exam_data"
    end
    
    def test_calculate_total_returns_final_score
        @@calculator.generate_exams_list
        @@calculator.exam = @@calculator.exams[0]
        @@calculator.extract_initial_exam_data

        @@calculator.exam.sections.each do |section|
            section.score = 70
        end

        result = @@calculator.calculate_total

        assert_equal 70, result, "should return final score when invoke calculate_total"
    end
    
    def test_determine_percentage_manually_list_returns_float
        calculator = SFC.new
        result = 0
        
        OStreamCatcher.catch do
            string_io = StringIO.new
            string_io.puts "LIST"
            string_io.puts "1"

            (0..6).each do |i|
                string_io.puts "80"
            end

            string_io.rewind
            $stdin = string_io
            result = calculator.determine_percentage_manually
            $stdin = STDIN
        end

        assert_instance_of Float, result, "should return a float after calling determine_percentage_manually if user selects LIST"
    end
    
    def test_determine_percentage_manually_prompts_2_more_than_sections_if_list
        calculator = SFC.new
        sections = 7
        prompts = 2 + sections

        result = OStreamCatcher.catch do
            string_io = StringIO.new
            string_io.puts "LIST"
            string_io.puts "1"

            (1..sections).each do |i|
                string_io.puts "80"
            end

            string_io.rewind
            $stdin = string_io
            result = calculator.determine_percentage_manually
            $stdin = STDIN
        end

        assert_equal prompts, result[1].scan("?").length, "should prompt user for input 2 more than the number of sections in exam when call determine_percentage_manually and LIST selected"
    end
    
    def test_determine_percentage_manually_new_returns_float
        calculator = SFC.new
        result = 0
        
        OStreamCatcher.catch do
            string_io = StringIO.new
            string_io.puts "NEW"
            string_io.puts "My Test"
            string_io.puts "4"

            (1..4).each do |i|
                string_io.puts "Section #{i}"
                string_io.puts "25"
                string_io.puts "70"
            end

            string_io.rewind
            $stdin = string_io
            result = calculator.determine_percentage_manually
            $stdin = STDIN
        end

        assert_instance_of Float, result, "should return a float after calling determine_percentage_manually if user selects NEW"
    end

    def test_determine_percentage_manually_prompts_3_more_than_3_times_sections_if_new
        calculator = SFC.new
        sections = 4
        prompts = 3 + 3 * sections

        result = OStreamCatcher.catch do
            string_io = StringIO.new
            string_io.puts "NEW"
            string_io.puts "My Test"
            string_io.puts "#{sections}"

            (1..sections).each do |i|
                string_io.puts "Section #{i}"
                string_io.puts "25"
                string_io.puts "70"
            end

            string_io.rewind
            $stdin = string_io
            result = calculator.determine_percentage_manually
            $stdin = STDIN
        end

        assert_equal prompts, result[1].scan("\n").length, "should prompt user for input 3 more than 3 times the number of sections in exam when call determine_percentage_manually and NEW selected"
    end
end