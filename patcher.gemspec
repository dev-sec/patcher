# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'version'

Gem::Specification.new do |spec|
  spec.name          = 'patcher'
  spec.version       = Patcher::VERSION
  spec.authors       = ['Christoph Hartmann']
  spec.email         = ['chris@lollyrock.com']
  spec.summary       = 'DevOps Patch workflow'
  spec.description   = 'This tool reads an inspec patch report and extracts the patches'
  spec.homepage      = 'http://lollyrock.com/'
  spec.license       = 'Apache-2.0'

  spec.files = %w{
    README.md Rakefile MAINTAINERS.toml MAINTAINERS.md LICENSE patcher.gemspec
    Gemfile CHANGELOG.md .rubocop.yml
  } + Dir.glob(
    '{bin,docs,examples,lib}/**/*', File::FNM_DOTMATCH
  ).reject { |f| File.directory?(f) }

  spec.executables   = %w{ patcher }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.1'

  spec.add_dependency 'thor', '~> 0.19'
  spec.add_dependency 'json', '>= 1.8', '< 3.0'
  spec.add_dependency 'terminal-table'
end
