require 'colsole'

module Docspec
  module Testable
    include Colsole

    def success?
      failed_examples.count.zero?
    end

    def failed_examples
      @failed_examples ||= examples.select(&:consider_failed?)
    end

    def test
      examples.each do |example|
        if example.empty?
          say "m`void :` #{example.label}"
        elsif example.success?
          say "g`pass :` #{example.label}"
        else
          say "r`FAIL : #{example.label}`"
          say '---'
          puts example.diff
          say '---'
        end
      end
    end
  end
end
