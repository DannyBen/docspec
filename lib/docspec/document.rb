module Docspec
  class Document
    include Testable
    attr_reader :filename, :markdown

    def self.from_file(filename)
      new File.read(filename)
    end

    def initialize(markdown)
      @markdown = markdown
    end

    def examples
      @examples ||= examples!
    end

  protected

    def examples!
      result = []
      markdown.scan(/```(ruby|shell)\s*\n(.*?)```/m) do |type, code|
        example = Example.new(code, type)
        result << example unless example.skip?
      end
      result
    end

  end
end
