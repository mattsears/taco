
# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "taco/version"

Gem::Specification.new do |s|
  s.name        = "taco"
  s.version     = Taco::VERSION
  s.authors     = ["Matt Sears"]
  s.email       = ["matt@mattsears.com"]
  s.homepage    = "http://mattsears.com"
  s.summary     = %q{Hold your stuff in a shell}
  s.description = %q{Manage todo items from the command line}
  s.rubyforge_project = "taco"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
