require 'colsole'

module Docspec
  module Testable
    include Colsole

    def success?
      failed_examples.count == 0
    end

    def failed_examples
      @failed_examples ||= examples.select(&:consider_failed?)
    end

    def test
      examples.each do |example|
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

  end
end

