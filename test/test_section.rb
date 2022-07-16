require "minitest/autorun"
require "salesforce_certification_calculator"

class SectionTest < Minitest::Test
    Section = SalesforceCertificationCalculator::Section
    @@name = "Section 1"
    @@weight = 40
    @@score = 80
    @@section = Section.new(@@name, @@weight, @@score)
    @@methods = @@section.methods
    
    def test_initialize_name_exists
        assert_includes @@methods, :name, "should create an object with a name attribute"
    end
    
    def test_initialize_name_setter
        assert_includes @@methods, :name=, "should create an object with a method for setting the name attribute"
    end
    
    def test_initialize_name_string
        assert_instance_of String, @@section.name, "should create an object with a name attribute of type string"
    end
    
    def test_initialize_name_matches_parameter
        assert_equal @@name, @@section.name, "should create an object with a name attribute matching the first argument to its new call"
    end
    
    def test_initialize_weight_exists
        assert_includes @@methods, :weight, "should create an object with a weight attribute"
    end
    
    def test_initialize_weight_setter
        assert_includes @@methods, :weight=, "should create an object with a method for setting the weight attribute"
    end
    
    def test_initialize_weight_integer
        assert_instance_of Integer, @@section.weight, "should create an object with a weight attribute of type integer"
    end
    
    def test_initialize_weight_matches_parameter
        assert_equal @@weight, @@section.weight, "should create an object with a weight attribute matching the second argument to its new call"
    end

    def test_initialize_score_exists
        assert_includes @@methods, :score, "should create an object with a score attribute"
    end
    
    def test_initialize_score_setter
        assert_includes @@methods, :score=, "should create an object with a method for setting the score attribute"
    end
    
    def test_initialize_score_integer
        assert_instance_of Integer, @@section.score, "should create an object with a score attribute of type integer"
    end

    def test_initialize_score_matches_parameter
        assert_equal @@score, @@section.score, "should create an object with a score attribute matching the last argument to its new call"
    end
end