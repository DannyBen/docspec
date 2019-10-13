require 'colsole'

module Docspec
  class Tester
    include Colsole
    attr_reader :document, :errors

    def initialize(document)
      document = Document.new document unless document.is_a? Document
      @document = document
      @errors = 0
    end

    def total
      @total ||= document.examples.count
    end

    def execute
      document.examples.each do |example|
        if example.passing?
          say "!txtgrn!PASS: #{example.label}"
        else
          @errors += 1
          say "!txtred!FAIL: #{example.label}"
          say "---"
          puts example.diff
          say "---"
        end
      end

      errors == expected_failures
    end

    def expected_failures
      ENV['DOCSPEC_EXPECTED_FAILURES']&.to_i || 0
    end
  end
end

