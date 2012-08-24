# -*- encoding: utf-8 -*-
require File.expand_path('../lib/benchtool/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Brad Landers"]
  gem.email         = ["brad@bradlanders.com"]
  gem.description   = %q{A set of tools for benchmarking websites/services.}
  gem.summary       = %q{A set of tools for benchmarking websites/services.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "benchtool"
  gem.require_paths = ["lib"]
  gem.version       = BenchTool::VERSION

  gem.add_dependency "thor"
  gem.add_dependency "highline"
  gem.add_dependency "open4"

  gem.add_development_dependency "awesome_print"
end
