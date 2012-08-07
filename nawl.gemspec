# -*- encoding: utf-8 -*-
require File.expand_path('../lib/nawl/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Arjan van der Gaag']
  gem.email         = ['arjan@arjanvandergaag.nl']
  gem.description   = %q{Nawl: null objects for Rails models}
  gem.summary       = %q{Nawl provides a simple mechanism for generating Null objects as stand-ins for your Rails models. Null objects respond to any message with nil, unless you specify otherwise. Null objects are a great way to encapsulate the logic of the "nothing" case -- like a non-existant article author.}
  gem.homepage      = "https://github.com/avdgaag/nawl"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "nawl"
  gem.require_paths = ["lib"]
  gem.version       = Nawl::VERSION

  gem.add_development_dependency 'rspec', '~> 2.11'
  gem.add_development_dependency 'yard',  '~> 0.8'
  gem.add_development_dependency 'rake',  '~> 0.9'
end
