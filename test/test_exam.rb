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

        assert_equal updated_sections, initial_sections + 1
    end
    
    def test_add_section_name_weight_default_0_score
        @@exam.add_section('Database', 24)
        sections_length = @@exam.sections.length
        recent_section = @@exam.sections[sections_length - 1]

        assert_equal recent_section.score, 0
    end
    
    def test_add_section_name_weight_score_increments
        initial_sections = @@exam.sections.length
        @@exam.add_section('Database', 24, 80)
        updated_sections = @@exam.sections.length

        assert_equal updated_sections, initial_sections + 1
    end

    def test_add_section_name_weight_score_new_value
        score_value = 80
        @@exam.add_section('Database', 24, score_value)
        sections_length = @@exam.sections.length
        recent_section = @@exam.sections[sections_length - 1]

        assert_equal recent_section.score, score_value
    end

    def test_calculate_total_2_sections
        exam = Exam.new
        exam.add_section('Database', 40, 65)
        exam.add_section('Application', 60, 85)
        exam.calculate_total

        assert_equal exam.total, 77
    end

    def test_calculate_total_3_sections
        exam = Exam.new
        exam.add_section('Database', 25, 62)
        exam.add_section('Application', 35, 83)
        exam.add_section('Program', 40, 54)
        exam.calculate_total

        assert_equal exam.total, 66.15
    end
end