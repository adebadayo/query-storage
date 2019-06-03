# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "query_storage/version"

Gem::Specification.new do |s|
  s.name        = "query_storage"
  s.version     = QueryStorage::VERSION
  s.authors     = ["Keisuke Nakama"]
  s.email       = [""]
  s.homepage    = "https://github.com/adebadayo/query-storage"
  s.summary     = %q{}
  s.description = %q{I will write this section when I finish creating this gem}

  s.rubyforge_project = "query_storage"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
