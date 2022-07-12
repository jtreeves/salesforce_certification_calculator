class SalesforceCertificationCalculator::Exam
    def initialize
        @title = ""
        @file = ""
        @sections = []
    end

    def get_title
        return @title
    end

    def get_file
        return @file
    end

    def get_sections
        return @sections
    end

    def set_title(title)
        @title = title
    end

    def set_file(file)
        @file = file
    end

    def add_section(name, weight)
        new_section = SalesforceCertificationCalculator::Section.new(name, weight)
        @sections.push(new_section)
    end
end

require "salesforce_certification_calculator/section"