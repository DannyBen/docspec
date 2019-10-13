require 'colsole'

module Docspec
  class Tester
    include Colsole
    attr_reader :document, :errors, :total

    def initialize(document)
      document = Document.new document unless document.is_a? Document
      @document = document
    end

    def before_codes
      @before_codes ||= []
    end

    def success?
      errors == 0
    end

    def each_example
      reset_counters

      document.examples.each do |example|
        if example.empty?
          before_codes << example.code
          next
        end

        @total += 1
        example.prepend before_codes
        @errors += 1 unless example.success? or example.ignore_failure?
        
        yield example
      end
    end

    def execute
      each_example do |example|
        if example.success?
          say "!txtgrn!PASS: #{example.label}"
        else
          say "!txtred!FAIL: #{example.label}"
          say "---"
          puts example.diff
          say "---"
        end
      end
    end

  protected

    def reset_counters
      @before_codes = nil
      @errors = 0
      @total = 0
    end

  end
end

