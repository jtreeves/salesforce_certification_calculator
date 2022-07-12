class SalesforceCertificationCalculator::Section
    def initialize
        @name = ""
        @weight = 0
        @score = 0
    end

    def get_name
        return @name
    end

    def get_weight
        return @weight
    end

    def get_score
        return @score
    end

    def set_name(name)
        @name = name
    end

    def set_weight(weight)
        @weight = weight
    end

    def set_score(score)
        @score = score
    end
end