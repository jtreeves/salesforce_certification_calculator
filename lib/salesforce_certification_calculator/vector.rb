class SalesforceCertificationCalculator::Vector
    def initialize(vector)
        @vector = vector
        @length = vector.length()
    end

    def get_vector
        return @vector
    end

    def scalar_multiplication(scalar)
        product = []

        (0..@length-1).each do |i|
            initial_product = @vector[i] * scalar
            rounded_product = initial_product.round(8)
            product[i] = rounded_product
        end

        return product
    end

    def dot_product(other_vector)
        sum = 0
        extracted_other_vector = other_vector.get_vector
        
        (0..@length-1).each do |i|
            sum += @vector[i] * extracted_other_vector[i]
        end

        rounded_sum = sum.round(4)

        return rounded_sum
    end
end