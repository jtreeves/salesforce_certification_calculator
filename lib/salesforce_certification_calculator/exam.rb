class SalesforceCertificationCalculator::Exam
    SFC = SalesforceCertificationCalculator

    # @!attribute title
    #   @return [String] name of the exam
    # 
    # @!attribute file
    #   @return [String] path to file containing exam data
    # 
    # @!attribute [r] sections
    #   @return [Array] collection of Section objects for all sections of the exam
    # 
    # @!attribute [r] total
    #   @return [Number] cumulative score for the entire exam; if sections' weights do not sum to 100, it will return an error message as a string
    attr_accessor :title, :file
    attr_reader :sections, :total

    # Creates Exam object
    # 
    # @example Create Exam Object
    #   >> my_exam = Exam.new
    def initialize
        @title = ""
        @file = ""
        @sections = []
        @total = 0
    end

    # Adds a new Section object to the exam's array of sections
    # 
    # @example Add New Section
    #   >> my_exam = Exam.new
    #   >> my_exam.add_section('Database', 24)
    # 
    # @param name [String] title of the section
    # @param weight [Number] percentage weight of the section, expressed as an integer
    # @param score [Number] individual's percentage score on that section of the exam, expressed as an integer; uses 0 as default value
    def add_section(name, weight, score = 0)
        section = SFC::Section.new(name, weight, score)
        @sections.push(section)
    end

    # Determines cumulative score for the exam based on its sections' weights and scores
    # 
    # @example Calculate Total
    #   >> my_exam = Exam.new
    #   >> my_exam.calculate_total
    def calculate_total
        summed_weights = 0

        @sections.each do |section|
            summed_weights += section.weight
            @total += section.weight * section.score / 100.0
        end

        # Sets total to error message when sum of sections' weights is not 100
        if summed_weights != 100
            @total = "CANNOT CALCULATE"
        end
    end
end

require "salesforce_certification_calculator/section"