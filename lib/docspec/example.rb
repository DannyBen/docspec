require 'diffy'

module Docspec
  class Example
    include OutputCapturer
    using StringRefinements

    attr_reader :code, :type, :before

    def initialize(type:, code:, before: nil)
      @code = code
      @type = type
      @before = before
    end

    def actual
      @actual ||= actual!
    end

    def consider_failed?
      failed? and !ignore_failure?
    end

    def diff
      @diff ||= Diffy::Diff.new("#{expected}\n", "#{actual}\n", context: 2).to_s :color
    end

    def empty?
      expected.empty?
    end

    def expected
      @expected ||= code.scan(/#=> *(.*)/).map { |match| match.first.strip }.join "\n"
    end

    def failed?
      !success? && !empty?
    end

    def first_line
      @first_line ||= code.split("\n").first
    end

    def flags
      @flags ||= first_line.scan(/\[:(.+?)\]/).map { |f| f.first.to_sym }
    end

    def full_code
      @full_code ||= full_code!
    end

    def ignore_failure?
      flags.include? :ignore_failure
    end

    def label
      @label ||= label!
    end

    def skip?
      flags.include? :skip
    end

    def success?
      if expected.include? '...'
        expected.ellipses_match? actual
      else
        actual == expected
      end
    end

  protected

    def actual!
      capture_output do
        case type
        when 'ruby' then eval full_code
        when 'shell' then puts `#{full_code}`
        end
      end.strip
    end

    def full_code!
      return code unless before

      [before.join("\n\n"), code].join "\n"
    end

    def label!
      first_line.gsub(/^#\s*/, '').strip
    end
  end
end
