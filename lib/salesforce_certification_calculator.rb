class SalesforceCertificationCalculator
    def self.vector_multiplication(vector1, vector2)
        calculator = Math.new(vector1, vector2)
        result = calculator.vector_multiplication
        return result
    end
end

require "salesforce_certification_calculator/math"