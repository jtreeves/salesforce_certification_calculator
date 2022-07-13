class SalesforceCertificationCalculator::Exam
    SFC = SalesforceCertificationCalculator

    def initialize
        @title = ""
        @file = ""
        @sections = []
        @total = 0
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

    def get_total
        return @total
    end

    def set_title(title)
        @title = title
    end

    def set_file(file)
        @file = file
    end

    def add_section(name, weight, score = 0)
        section = SFC::Section.new(name, weight, score)
        @sections.push(section)
    end

    def calculate_total
        @sections.each do |section|
            @total += section.get_weight * section.get_score / 100
        end
    end
end

require "salesforce_certification_calculator/section"