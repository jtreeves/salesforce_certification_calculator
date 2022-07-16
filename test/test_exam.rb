require "minitest/autorun"
require "salesforce_certification_calculator"

class ExamTest < Minitest::Test
    Exam = SalesforceCertificationCalculator::Exam
    @@exam = Exam.new
    @@methods = @@exam.methods
    
    def test_initialize_title_exists
        assert_includes @@methods, :title
    end
    
    def test_initialize_title_setter
        assert_includes @@methods, :title=
    end
    
    def test_initialize_title_string
        assert_instance_of String, @@exam.title
    end
    
    def test_initialize_file_exists
        assert_includes @@methods, :file
    end
    
    def test_initialize_file_setter
        assert_includes @@methods, :file=
    end
    
    def test_initialize_file_string
        assert_instance_of String, @@exam.file
    end
    
    def test_initialize_sections_exists
        assert_includes @@methods, :sections
    end
    
    def test_initialize_sections_array
        assert_instance_of Array, @@exam.sections
    end
    
    def test_initialize_total_exists
        assert_includes @@methods, :total
    end
    
    def test_initialize_total_integer
        assert_instance_of Integer, @@exam.total
    end
    
    def test_add_section_exists
        assert_includes @@methods, :add_section
    end
    
    def test_calculate_total_exists
        assert_includes @@methods, :calculate_total
    end
    
    def test_add_section_name_weight_increments
        initial_sections = @@exam.sections.length
        @@exam.add_section('Database', 24)
        updated_sections = @@exam.sections.length

        assert_equal initial_sections + 1, updated_sections
    end
    
    def test_add_section_name_weight_default_0_score
        @@exam.add_section('Database', 24)
        sections_length = @@exam.sections.length
        recent_section = @@exam.sections[sections_length - 1]

        assert_equal 0, recent_section.score
    end
    
    def test_add_section_name_weight_score_increments
        initial_sections = @@exam.sections.length
        @@exam.add_section('Database', 24, 80)
        updated_sections = @@exam.sections.length

        assert_equal initial_sections + 1, updated_sections
    end

    def test_add_section_name_weight_score_new_value
        score_value = 80
        @@exam.add_section('Database', 24, score_value)
        sections_length = @@exam.sections.length
        recent_section = @@exam.sections[sections_length - 1]

        assert_equal score_value, recent_section.score
    end

    def test_calculate_total_1_section
        exam = Exam.new
        exam.add_section('Database', 100, 65)
        exam.calculate_total

        assert_equal 65, exam.total
    end

    def test_calculate_total_2_sections
        exam = Exam.new
        exam.add_section('Database', 40, 65)
        exam.add_section('Application', 60, 85)
        exam.calculate_total

        assert_equal 77, exam.total
    end

    def test_calculate_total_3_sections
        exam = Exam.new
        exam.add_section('Database', 25, 62)
        exam.add_section('Application', 35, 83)
        exam.add_section('Program', 40, 54)
        exam.calculate_total

        assert_equal 66.15, exam.total
    end

    def test_calculate_total_many_sections
        exam = Exam.new
        exam.add_section('Section 1', 5, 82)
        exam.add_section('Section 2', 6, 93)
        exam.add_section('Section 3', 7, 54)
        exam.add_section('Section 4', 8, 62)
        exam.add_section('Section 5', 9, 80)
        exam.add_section('Section 6', 10, 40)
        exam.add_section('Section 7', 12, 50)
        exam.add_section('Section 8', 13, 60)
        exam.add_section('Section 9', 14, 70)
        exam.add_section('Section 10', 16, 65)
        exam.calculate_total

        assert_equal 63.62, exam.total
    end
end