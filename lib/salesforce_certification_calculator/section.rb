class SalesforceCertificationCalculator::Section
    def initialize(name, weight)
        @name = name
        @weight = weight
    end

    def get_name
        return @name
    end

    def get_weight
        return @weight
    end
end