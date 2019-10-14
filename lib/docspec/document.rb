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

    def before
      @before ||= {}
    end

  protected

    def examples!
      result = []
      markdown.scan(/```(ruby|shell)\s*\n(.*?)```/m) do |type, code|
        example = Example.new(type: type, code: code, before: before[type])
        
        next if example.skip?

        before[type] ||= []
        before[type] << example.code if example.empty?
        
        result << example
      end
      result
    end

  end
end
