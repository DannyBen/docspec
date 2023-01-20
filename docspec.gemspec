lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'docspec/version'

Gem::Specification.new do |s|
  s.name        = 'docspec'
  s.version     = Docspec::VERSION
  s.summary     = 'Embedded tests in Markdown documents'
  s.description = 'Make your READMEs testable'
  s.authors     = ['Danny Ben Shitrit']
  s.email       = 'db@dannyben.com'
  s.files       = Dir['README.md', 'lib/**/*.*']
  s.executables = ['docspec']
  s.homepage    = 'https://github.com/dannyben/docspec'
  s.license     = 'MIT'

  s.required_ruby_version = '>= 2.7'

  s.add_runtime_dependency 'colsole', '~> 0.8', '>= 0.8.1'
  s.add_runtime_dependency 'diffy', '~> 3.3'
  s.metadata['rubygems_mfa_required'] = 'true'
end
