# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name        = 'generic-state-machine'
  s.version     = '0.1.0'
  s.licenses    = ['MIT']
  s.date        = '2020-10-31'
  s.summary     = 'Generic state machine'
  s.description = 'Provides the possibility to create simple state machines'
  s.authors     = ['Thomas Stätter']
  s.email       = 'thomas.staetter@gmail.com'
  s.files       = [Dir.glob('dsl/**/*.rb'), Dir.glob('state_machine/**/*.rb')].flatten
  s.test_files	= Dir.glob('spec/**/*.rb')
  s.homepage    = 'https://github.com/tstaetter/generic-state-machine'
  s.required_ruby_version = '>= 2.7.1'
end
