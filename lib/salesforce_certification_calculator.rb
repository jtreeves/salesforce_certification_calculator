class SalesforceCertificationCalculator
    def self.dot_product(vector1, vector2)
        calculator = Vectors.new(vector1, vector2)
        result = calculator.dot_product
        return result
    end
end

require "salesforce_certification_calculator/vectors"