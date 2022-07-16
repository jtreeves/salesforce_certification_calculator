class SalesforceCertificationCalculator::Section
    # @!attribute name
    #   @return [String] name of the section
    # 
    # @!attribute weight
    #   @return [Number] percentage indicating how much the section is worth to the total score, represented as an integer
    # 
    # @!attribute score
    #   @return [Number] individual's score on the specific section, represented as an integer
    attr_accessor :name, :weight, :score

    # Creates Section object
    # 
    # @example Create Section Object
    #   >> my_section = Section.new('Database', 24, 85)
    # 
    # @param name [String] name of the section
    # @param weight [Number] percentage indicating how much the section is worth to the total score, represented as an integer
    # @param score [Number] individual's score on the specific section, represented as an integer
    def initialize(name, weight, score)
        @name = name
        @weight = weight
        @score = score
    end
end