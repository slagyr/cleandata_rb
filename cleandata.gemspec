# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

Gem::Specification.new do |s|
  s.name        = "cleandata"
  s.version     = "1.0.0"
  s.platform    = Gem::Platform::JRUBY
  s.authors     = ["Micah Martin"]
  s.email       = ["micahmartin@gmail.com"]
  s.homepage    = "http://github.com/slagyr/cleandata_rb"
  s.summary     = "Client library for cleancoders.com data"
  s.description = "Client library for cleancoders.com data"

  s.required_rubygems_version = ">= 1.3.6"

  s.add_development_dependency "rspec"

  s.files        = Dir.glob("lib/**/*") + %w(README.md)
  s.executables  = []
  s.require_path = 'lib'
end