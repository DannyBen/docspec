require 'diffy'

module Docspec
  class Example
    include OutputCapturer
    attr_reader :code, :type, :full_code

    def initialize(code, type)
      @code, @type = code, type
      @full_code = @code
    end

    def actual
      @actual ||= actual!
    end

    def diff
      @diff ||= Diffy::Diff.new("#{expected}\n", "#{actual}\n", context: 2).to_s :color
    end

    def empty?
      actual.empty?
    end

    def expected
      @expected ||= code.scan(/#=>\s*(.*)/).map { |match| match.first.strip }.join "\n"
    end

    def first_line
      @first_line ||= code.split("\n").first
    end

    def flags
      @flags ||= first_line.scan(/\[:(.+?)\]/).map { |f| f.first.to_sym }
    end

    def ignore_failure?
      flags.include? :ignore_failure
    end

    def label
      @label ||= label!
    end

    def prepend(codes)
      codes = [codes] unless codes.is_a? Array
      codes = codes.join "\n\n"
      @full_code = "#{codes}\n#{@full_code}"
    end

    def success?
      actual == expected
    end

  protected

    def actual!
      capture_output do
        case type
        when 'ruby'
          eval full_code
        when 'shell'
          puts `#{full_code}`
        end
      end.strip
    end

    def label!
      first_line.gsub(/^#\s*/, '').strip
    end

  end
end
