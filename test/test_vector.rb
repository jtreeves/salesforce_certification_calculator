require "minitest/autorun"
require "salesforce_certification_calculator/vector"

class VectorTest < Minitest::Test
    Vector = SalesforceCertificationCalculator::Vector

    def test_get_vector
        initial_vector = [2, 3]
        packaged_vector = Vector.new(initial_vector)
        extracted_vector = packaged_vector.get_vector

        assert_equal extracted_vector, initial_vector
    end
    
    def test_get_vector_long
        initial_vector = [2, 3, 4]
        packaged_vector = Vector.new(initial_vector)
        extracted_vector = packaged_vector.get_vector

        assert_equal extracted_vector, initial_vector
    end
    
    def test_scalar_multiplication_integers
        vector = Vector.new([2, 3])
        product = vector.scalar_multiplication(5)

        assert_equal product, [10, 15]
    end
    
    def test_scalar_multiplication_decimals
        vector = Vector.new([2, 3])
        product = vector.scalar_multiplication(0.1)

        assert_equal product, [0.2, 0.3]
    end

    def test_dot_product_integers
        vector1 = Vector.new([2, 3])
        vector2 = Vector.new([4, 5])
        product = vector1.dot_product(vector2)
        
        assert_equal product, 23
    end
    
    def test_dot_product_decimals
        vector1 = Vector.new([0.4, 0.6])
        vector2 = Vector.new([0.8, 0.5])
        product = vector1.dot_product(vector2)

        assert_equal product, 0.62
    end
end