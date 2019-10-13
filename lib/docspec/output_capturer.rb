module Docspec
  module OutputCapturer
    def capture_output
      original_stdout = $stdout
      $stdout = StringIO.new
      begin
        yield
        $stdout.string
      rescue => e
        "#{$stdout.string}#{e.inspect}"
      ensure
        $stdout = original_stdout
      end
    end
  end
end
