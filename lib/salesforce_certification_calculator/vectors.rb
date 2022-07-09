class SalesforceCertificationCalculator::Vectors
    def initialize(vector1, vector2)
        @vector1 = vector1
        @vector2 = vector2
        @sections = vector1.length()
    end

    def dot_product
        sum = 0
        (0..@sections-1).each do |i|
            sum += @vector1[i] * @vector2[i]
        end
        return sum
    end
end