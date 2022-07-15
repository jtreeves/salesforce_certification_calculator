class SalesforceCertificationCalculator::Section
    attr_accessor :name, :weight, :score

    def initialize(name, weight, score)
        @name = name
        @weight = weight
        @score = score
    end
end