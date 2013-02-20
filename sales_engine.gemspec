# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = "sales_engine"
  gem.version       = "0.0.1"
  gem.authors       = ["Elaine", "Laura"]
  gem.email         = ["lauramsteadman@gmail.com"]
  gem.description   = %q{Laura's and Elaine's awesome SalesEngine!}
  gem.summary       = %q{It's so awesome!!!!}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
