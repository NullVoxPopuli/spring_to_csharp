# -*- encoding: utf-8 -*-

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "spring_to_csharp/version"

Gem::Specification.new do |s|
  s.name        = "spring_to_csharp"
  s.version     = SpringToCSharp::VERSION
  s.platform    = Gem::Platform::RUBY
  s.license     = "MIT"
  s.authors     = ["L. Preston Sego III"]
  s.email       = "LPSego3+dev@gmail.com"
  s.homepage    = "https://github.com/NullVoxPopuli/spring_to_csharp"
  s.summary     = "SpringToC#-#{SpringToCSharp::VERSION}"
  s.description = "Converts XML Config files for use by the SpringFramework.NET to C# files."


  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.required_ruby_version = '>= 2.0'

  s.add_runtime_dependency "activesupport"
  s.add_runtime_dependency "colorize"
  s.add_runtime_dependency "nokogiri"

  s.add_development_dependency "pry-byebuy"
  s.add_development_dependency "awesome_print"
  s.add_development_dependency "rspec"
  s.add_development_dependency "codeclimate-test-reporter"
end
