# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = "hipsterhash"
  gem.version       = "0.0.2"
  gem.authors       = ["Bryan JJ Buckley"]
  gem.email         = ["jjbuckley@gmail.com"]
  gem.description   = %q{A hash which is all, like, whatever.}
  gem.summary       = %q{A HipsterHash is just like a regular ruby Hash, except that it doesn't distinguish between symbols or strings, and the keys are case insensitive.}
  gem.homepage      = "http://jjbuckley.github.com/hipsterhash"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "activesupport"
end
