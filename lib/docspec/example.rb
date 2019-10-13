require 'diffy'

module Docspec
  class Example
    include OutputCapturer

    attr_reader :code

    def initialize(code)
      @code = code
    end

    def label
      @label ||= label!
    end

    def expected
      @expected ||= code.scan(/#=>\s*(.*)/).map { |match| match.first.strip }.join "\n"
    end

    def actual
      @actual ||= capture_output { instance_eval(code) }.strip
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

  end
end
