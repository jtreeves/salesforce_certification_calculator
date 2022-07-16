class SalesforceCertificationCalculator::Exam
    SFC = SalesforceCertificationCalculator

    # @!attribute title
    #   @return [String] name of the exam
    # @!attribute file
    #   @return [String] path to file containing exam data
    # @!attribute [r] sections
    #   @return [Array] collection of Section objects for all sections of the exam
    # @!attribute [r] total
    #   @return [Number] cumulative score for the entire exam
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
    # @param score [Number] individual's percentage score on that section of the exam, expressed as an integer
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
        @sections.each do |section|
            @total += section.weight * section.score / 100
        end

        # Round answer to 2 decimal places after initial calculation
        @total = @total.round(2)
    end
end

require "salesforce_certification_calculator/section"