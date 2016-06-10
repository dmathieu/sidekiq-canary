lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sidekiq/canary/version'

Gem::Specification.new do |gem|
  gem.name          = 'sidekiq-canary'
  gem.version       = Sidekiq::Canary::VERSION
  gem.authors       = ['Damien Mathieu']
  gem.email         = ['42@dmathieu.com']
  gem.description   = %q{Sidekiq canary deployments}
  gem.summary       = %q{Sidekiq Canary allows you to do canary deployments with your sidekiq workers}
  gem.homepage      = 'https://github.com/dmathieu/sidekiq-canary'
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency 'sidekiq'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
end
