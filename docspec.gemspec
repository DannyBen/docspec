lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'date'
require 'docspec/version'

Gem::Specification.new do |s|
  s.name        = 'docspec'
  s.version     = Docspec::VERSION
  s.date        = Date.today.to_s
  s.summary     = "Embedded tests in Markdown"
  s.description = "Make your READMEs testable"
  s.authors     = ["Danny Ben Shitrit"]
  s.email       = 'db@dannyben.com'
  s.files       = Dir['README.md', 'lib/**/*.*']
  s.executables = ['docspec']
  s.homepage    = 'https://github.com/dannyben/docspec'
  s.license     = 'MIT'
  s.required_ruby_version = ">= 2.5.0"

  s.add_runtime_dependency 'mister_bin', '~> 0.6'
  s.add_runtime_dependency 'colsole', '~> 0.5'
  s.add_runtime_dependency 'diffy', '~> 3.3'
end
