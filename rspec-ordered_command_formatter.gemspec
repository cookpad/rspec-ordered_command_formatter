lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rspec/ordered_command_formatter/version"

Gem::Specification.new do |spec|
  spec.name          = "rspec-ordered_command_formatter"
  spec.version       = Rspec::OrderedCommandFormatter::VERSION
  spec.authors       = ["David Stosik"]
  spec.email         = ["david.stosik+git-noreply@gmail.com"]

  spec.summary       = %q{Output the RSpec command to reproduce a test run}
  spec.description   = %q{This RSpec formatter facilitates reproducing a test run (same examples, same seed).}
  spec.homepage      = "https://github.com/cookpad/rspec-ordered_command_formatter"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency "minitest", "~> 5.0"
end
