module Docspec
  class Document
    attr_reader :filename

    def initialize(filename)
      @filename = filename
    end

    def markdown
      @markdown ||= File.read filename
    end

    def blocks
      @blocks ||= blocks!
    end

    def examples
      @examples ||= examples!
    end

  protected

    def blocks!
       markdown.scan(/```ruby(.*?)```/m).map { |match| match.first.strip }
    end

    def examples!
      blocks.map { |code| Example.new code }
    end

  end
end
