class SalesforceCertificationCalculator::Exam
    def initialize(title)
        @title = title
        @sections = []
    end

    def get_title
        return @title
    end

    def get_sections
        return @sections
    end

    def add_section(name, weight)
        new_section = SalesforceCertificationCalculator::Section.new(name, weight)
        @sections.push(new_section)
    end
end

require "salesforce_certification_calculator/section"