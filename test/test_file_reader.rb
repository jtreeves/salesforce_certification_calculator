require "minitest/autorun"
require "salesforce_certification_calculator"

class FileReaderTest < Minitest::Test
    FR = SalesforceCertificationCalculator::FileReader
    Exam = SalesforceCertificationCalculator::Exam
    reader = FR.new
    @@methods = reader.methods
    @@exams = reader.generate_exams_list
    @@exam = reader.extract_initial_exam_data(reader.generate_exams_list[0])
    
    def test_generate_exams_list_exists
        assert_includes @@methods, :generate_exams_list, "should create an object with a method called generate_exams_list"
    end
    
    def test_extract_initial_exam_data_exists
        assert_includes @@methods, :extract_initial_exam_data, "should create an object with a method called extract_initial_exam_data"
    end
    
    def test_generate_exams_list_returns_array
        assert_instance_of Array, @@exams, "should return array when invoke generate_exams_list"
    end
    
    def test_generate_exams_list_contains_21_items
        assert_equal 21, @@exams.length, "should return array with 21 elements when invoke generate_exams_list"
    end
    
    def test_generate_exams_list_contains_exams
        @@exams.each do |exam|
            assert_instance_of Exam, exam, "should return array of Exam objects when invoke generate_exams_list"
        end
    end
    
    def test_generate_exams_list_returns_no_sections
        @@exams.each do |exam|
            assert_equal 0, exam.sections.length, "should not return any sections on any of the exams listed"
        end
    end
    
    def test_generate_exams_list_contains_administrator
        exists = @@exams.any? { |exam| exam.title == "Administrator - Spring 2022" }
        
        assert_equal true, exists, "should return array containing Administrator title when invoke generate_exams_list"
    end
    
    def test_generate_exams_list_contains_multiple_marketings
        marketings = 0

        @@exams.each do |exam| 
            if exam.title.include? "Marketing"
                marketings += 1
            end
        end
        
        assert_operator marketings, :>, 1, "should return array containing multiple objects with titles including Marketing when invoke generate_exams_list"
    end

    def test_extract_initial_exam_data_returns_exam
        assert_instance_of Exam, @@exam, "should return Exam object when invoke extract_initial_exam_data"
    end

    def test_extract_initial_exam_data_returns_sections
        assert_operator @@exam.sections.length, :>, 0, "should return Exam object with sections when invoke extract_initial_exam_data"
    end
end