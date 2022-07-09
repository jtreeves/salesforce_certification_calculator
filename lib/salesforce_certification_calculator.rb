class SalesforceCertificationCalculator
    def initialize(sections, scores)
        @sections = Vector.new(sections)
        @scores = Vector.new(scores)
    end

    def cumulative_score
        sections_percent = @sections.scalar_multiplication(0.01)
        scores_percent = @scores.scalar_multiplication(0.01)
        sections_percent_vector = Vector.new(sections_percent)
        scores_percent_vector = Vector.new(scores_percent)
        product = sections_percent_vector.dot_product(scores_percent_vector)
        total_score = product * 100
        
        return total_score
    end
end

require "salesforce_certification_calculator/vector"