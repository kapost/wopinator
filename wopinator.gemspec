$:.unshift File.expand_path('../lib', __FILE__)
require 'wopinator/version'

Gem::Specification.new do |s|
  s.name          = 'wopinator'
  s.version       = Wopinator::VERSION
  s.summary       = 'A collection of helpers for interacting with WOPI.'
  s.description   = 'A collection of helpers for interacting with WOPI.'
  s.authors       = ['Mihail Szabolcs']
  s.email         = 'szaby@kapost.com'
  s.files         = Dir.glob('lib/**/*.rb')
  s.licenses      = 'MIT'
  s.homepage      = 'https://github.com/kapost/wopinator'
  s.require_paths = ['lib']

  s.required_ruby_version = '>= 2.1'
 
  s.add_dependency 'nori', '>= 1.1.5'
  s.add_dependency 'nokogiri', '>= 1.6.7'
  s.add_dependency 'httparty'
  s.add_dependency 'json'
  s.add_dependency 'rake', '>= 10.0'

  s.add_development_dependency 'bundler', '~> 1.11'
  s.add_development_dependency 'rspec', '~> 3.4'
  s.add_development_dependency 'rspec-its'
  s.add_development_dependency 'rubygems-tasks'
  s.add_development_dependency 'timecop'
end
