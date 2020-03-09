
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'textkernel/version'

Gem::Specification.new do |spec|
  spec.name          = 'textkernel'
  spec.version       = Textkernel::VERSION
  spec.authors       = ['MindMatch GmbH', 'Hugo Duksis']
  spec.email         = ['admin@mindmatch.ai', 'duksis@gmail.com']

  spec.summary       = %q{textkernel's Extract! (CV/Resume parsing) API client library}
  spec.description   = %q{https://www.textkernel.com/hr-software/extract-cv-parsing/}
  spec.homepage      = 'https://github.com/mindmatch/textkernel'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  #spec.add_dependency 'savon', '~> 2.12'
  #spec.add_dependency 'activesupport', '> 4.0'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'vcr', '~> 4.0'
  spec.add_development_dependency 'webmock', '~> 3.4'
  spec.add_development_dependency 'pry', '~> 0.11'
end
