module Docspec
  class Document
    attr_reader :filename

    def initialize(filename)
      @filename = filename
    end

    def markdown
      @markdown ||= File.read filename
    end

    def examples
      @examples ||= examples!
    end

  protected

    def examples!
      result = []
      markdown.scan(/```(ruby|shell)\s*\n(.*?)```/m) do |type, code|
        result << Example.new(code, type)
      end
      result
    end

  end
end
