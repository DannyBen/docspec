require 'colsole'

module Docspec
  module Testable
    include Colsole
    attr_reader :failed_examples, :total_examples

    def before_codes
      @before_codes ||= []
    end

    def success?
      failed_examples == 0
    end

    def each_example
      reset_counters

      examples.each do |example|
        if example.empty?
          before_codes << example.code
        else
          @total_examples += 1
          example.prepend before_codes
          @failed_examples += 1 unless example.success? or example.ignore_failure?
        end
        
        yield example
      end
    end

    def test
      each_example do |example|
        if example.empty?
          say "!txtpur!void :!txtrst! #{example.label}"          
        elsif example.success?
          say "!txtgrn!pass :!txtrst! #{example.label}"
        else
          say "!txtred!FAIL : #{example.label}"
          say "---"
          puts example.diff
          say "---"
        end
      end
    end

  protected

    def reset_counters
      @before_codes = nil
      @failed_examples = 0
      @total_examples = 0
    end

  end
end
