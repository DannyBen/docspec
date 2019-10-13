require 'colsole'

module Docspec
  class Tester
    include Colsole
    attr_reader :document, :errors, :total

    def initialize(document)
      document = Document.new document unless document.is_a? Document
      @document = document
      @errors = 0
      @total = 0
    end

    def before_codes
      @before_codes ||= []
    end

    def execute
      document.examples.each do |example|
        if example.empty?
          before_codes << example.code
          next
        end

        @total += 1

        example.prepend before_codes

        if example.success?
          say "!txtgrn!PASS: #{example.label}"
        else
          @errors += 1 unless example.ignore_failure?
          say "!txtred!FAIL: #{example.label}"
          say "---"
          puts example.diff
          say "---"
        end
      end

      errors == 0
    end
  end
end

