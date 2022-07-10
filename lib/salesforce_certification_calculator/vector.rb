class SalesforceCertificationCalculator::Vector
    # Creates Vector object from array
    # 
    # @example Create Vector Object
    #   >> Vector.new([2, 3])
    # 
    # @param vector [Array] initial array containing numbers
    def initialize(vector)
        @vector = vector
        @length = vector.length
    end

    # Gets vector attribute of a Vector object
    # 
    # @example Return Vector Array
    #   >> test_vector = Vector.new([2, 3])
    #   >> test_vector.get_vector
    #   => [2, 3]
    # 
    # @return [Array] initial array used to create the Vector object
    def get_vector
        return @vector
    end

    # Multiplies each element in a vector by a number
    # 
    # @example Multiply by Scalar
    #   >> test_vector = Vector.new([2, 3])
    #   >> test_vector.scalar_multiplication(5)
    #   => [10, 15]
    # 
    # @param scalar [Number] factor by which each element in vector will be multiplied
    # 
    # @return [Array] list of original numbers after being multiplied by scalar factor
    def scalar_multiplication(scalar)
        product = []

        (0..@length-1).each do |i|
            initial_product = @vector[i] * scalar
            rounded_product = initial_product.round(8)
            product[i] = rounded_product
        end

        return product
    end

    # Multiplies two vectors to return a scalar value
    # 
    # @example Multiply Two Vectors
    #   >> vector1 = Vector.new([2, 3])
    #   >> vector2 = Vector.new([4, 5])
    #   >> vector1.dot_product(vector2)
    #   => 23
    # 
    # @param other_vector [Vector] second vector by which base vector will be multiplied
    # 
    # @return [Number] scalar product of two vectors
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