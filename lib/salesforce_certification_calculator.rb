class SalesforceCertificationCalculator
    def self.percentage(vector1, vector2)
        vector1 = Vector.new(vector1)
        vector2 = Vector.new(vector2)
        result = vector1.dot_product(vector2) * 100
        
        return result
    end
end

require "salesforce_certification_calculator/vector"