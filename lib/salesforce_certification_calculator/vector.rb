class SalesforceCertificationCalculator::Vector
    def initialize(vector)
        @vector = vector
        @length = vector.length()
    end

    def dot_product(other_vector)
        sum = 0
        
        (0..@sections-1).each do |i|
            sum += @vector[i] * other_vector[i]
        end

        return sum
    end
    
    def scalar_multiplication(scalar)
        product = @vector.map { |n| n * scalar }

        return product
    end
end