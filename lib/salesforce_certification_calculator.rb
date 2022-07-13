class SalesforceCertificationCalculator
    def initialize(sections, scores)
        @sections = Vector.new(sections)
        @scores = Vector.new(scores)
    end
end

require "nokogiri"
require "salesforce_certification_calculator/vector"
require "salesforce_certification_calculator/exam"
require "salesforce_certification_calculator/u_i"
require "salesforce_certification_calculator/accessor"