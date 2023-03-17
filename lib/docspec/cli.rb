require 'colsole'
include Colsole

module Docspec
  class CLI
    attr_reader :targets, :exit_code, :total_examples, :failed_examples

    def initialize(*targets)
      targets = ['README.md'] if targets.empty?
      @targets = targets
    end

    def run
      @exit_code = 0
      @total_examples = 0
      @failed_examples = 0

      targets.each { |target| run_target target }

      show_footer
    end

  private

    def run_target(target)
      abort "Target not found: #{target}" unless File.exist? target

      if File.directory? target
        run_dir target
      else
        run_file target
      end
    end

    def run_dir(dir)
      Dir["#{dir}/**/*.md"].sort.each do |file|
        run_file file
      end
    end

    def run_file(file)
      say ''
      say "c`file : #{file}`"

      document = Docspec::Document.from_file file
      document.test

      @failed_examples += document.failed_examples.count
      @total_examples += document.examples.count

      document.success?
    end

    def show_footer
      say ''

      if failed_examples.zero?
        say "g`#{total_examples} tests, #{failed_examples} failed`\n"
        true
      else
        say "r`#{total_examples} tests, #{failed_examples} failed`\n"
        false
      end
    end
  end
end
