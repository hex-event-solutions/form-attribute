# frozen_string_literal: true

require_relative 'lib/form_attribute/version'

Gem::Specification.new do |spec|
  spec.name          = 'form_attribute'
  spec.version       = FormAttribute::VERSION
  spec.authors       = ['Ollie Nye']
  spec.email         = ['ollie@nyemail.co.uk']

  spec.summary       = 'A lightweight gem for adding typed attributes to plain objects.'
  spec.description   = 'A lightweight gem for adding typed attributes to plain objects.'
  spec.homepage      = 'https://github.com/hex-event-solutions/form-attribute'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.6.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/hex-event-solutions/form-attribute'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'reek', '~> 6'
  spec.add_development_dependency 'rspec', '~> 3.10'
  spec.add_development_dependency 'rubocop', '~> 1.8'
  spec.add_development_dependency 'rubocop-rake', '~> 0.5'
  spec.add_development_dependency 'rubocop-rspec', '~> 2.1'
  spec.add_development_dependency 'simplecov', '~> 0.21'
end
