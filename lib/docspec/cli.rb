require 'colsole'
include Colsole

module Docspec
  class CLI
    attr_reader :target, :exit_code, :total_examples, :failed_examples

    def initialize(target)
      @target = target || 'README.md'
    end

    def mode
      File.directory?(target) ? :dir : :file
    end

    def run
      abort "Target not found: #{target}" unless File.exist? target

      @exit_code = 0
      @total_examples = 0
      @failed_examples = 0

      if mode == :dir
        run_dir
      else
        run_file target
      end

      show_footer
    end

  private

    def run_dir
      all_success = true
      Dir["#{target}/**/*.md"].each do |file|
        say ''
        say "!txtcyn!file : #{file}"
        success = run_file file
        all_success = false unless success
      end
      all_success
    end

    def run_file(file)
      document = Docspec::Document.from_file file
      document.test
      
      @failed_examples += document.failed_examples.count
      @total_examples += document.examples.count
      
      document.success?
    end

    def show_footer
      say ''

      if failed_examples == 0
        say "!txtgrn!#{total_examples} tests, #{failed_examples} failed\n"
        true
      else
        say "!txtred!#{total_examples} tests, #{failed_examples} failed\n"
        false
      end
    end

  end
end



