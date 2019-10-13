require 'diffy'

module Docspec
  class Example
    include OutputCapturer

    attr_reader :code, :type

    def initialize(code, type)
      @code, @type = code, type
    end

    def label
      @label ||= label!
    end

    def expected
      @expected ||= code.scan(/#=>\s*(.*)/).map { |match| match.first.strip }.join "\n"
    end

    def actual
      @actual ||= actual!
    end

    def passing?
      actual == expected
    end

    def diff
      Diffy::Diff.new(expected, actual, context: 2).to_s :color
    end

  protected

    def label!
      first_line = code.split("\n").first
      first_line.gsub(/^#\s*/, '').strip
    end

    def actual!
      capture_output do
        case type
        when 'ruby'
          instance_eval(code)
        when 'shell'
          puts `#{code}`
        end
      end.strip
    end

  end
end
