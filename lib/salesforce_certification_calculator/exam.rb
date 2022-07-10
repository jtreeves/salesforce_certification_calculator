class SalesforceCertificationCalculator::Exam
    def initialize(title)
        @title = title
        @sections = []
    end

    def add_section(name, weight)
        new_section = Section.new(name, weight)
        @sections.push(new_section)
    end
end

require "section"