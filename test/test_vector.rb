require "minitest/autorun"
require "salesforce_certification_calculator/vector"

class VectorTest < Minitest::Test
    def test_get_vector
        initial = [2, 3]
        vector = SalesforceCertificationCalculator::Vector.new(initial)
        extracted = vector.get_vector

        assert_equal extracted, initial
    end

    def test_dot_product_integers
        vector1 = SalesforceCertificationCalculator::Vector.new([2, 3])
        vector2 = SalesforceCertificationCalculator::Vector.new([4, 5])
        product = vector1.dot_product(vector2)
        
        assert_equal product, 23
    end
    
    def test_dot_product_decimals
        vector1 = SalesforceCertificationCalculator::Vector.new([0.4, 0.6])
        vector2 = SalesforceCertificationCalculator::Vector.new([0.8, 0.5])
        product = vector1.dot_product(vector2)

        assert_equal product, 0.62
    end
end