class SalesforceCertificationCalculator::Exam
    SFC = SalesforceCertificationCalculator

    attr_accessor :title, :file
    attr_reader :sections, :total

    def initialize
        @title = ""
        @file = ""
        @sections = []
        @total = 0
    end

    def add_section(name, weight, score = 0)
        section = SFC::Section.new(name, weight, score)
        @sections.push(section)
    end

    def calculate_total
        @sections.each do |section|
            @total += section.weight * section.score / 100
        end

        @total = @total.round(2)
    end
end

require "salesforce_certification_calculator/section"