# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mazes/version'

Gem::Specification.new do |spec|
  spec.name          = "mazes"
  spec.version       = Mazes::VERSION
  spec.authors       = ["myrrlyn"]
  spec.email         = ["myrrlyn@outlook.com"]

  spec.summary       = <<-EOS
Exercises from the book "Mazes for Programmers"
  EOS
  spec.description   = <<-EOS
This is my implementation of the exercises and algorithms described in the book.
  EOS
  spec.homepage      = "https://myrrlyn.net/mazes"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_dependency "chunky_png", "~> 1.3"
end
