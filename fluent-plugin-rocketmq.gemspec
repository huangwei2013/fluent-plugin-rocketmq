# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name          = "fluent-plugin-rocketmq"
  s.version       = "0.0.10"
  s.authors       = ["Chris Huang"]
  s.email         = ["kaka.forwen@gmail.com"]
  s.summary       = %q{fluentd input plugin for rocketmq server}
  s.description   = %q{fluentd input plugin for rocketmq server}
  s.homepage      = "https://github.com/huangwei2013/fluent-plugin-rocketmq"
  s.license       = "MIT"
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = []
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }  
  s.require_paths = ["lib"]

  s.add_runtime_dependency "rocketmq-client-ruby", '~> 0'
  s.add_runtime_dependency "fluentd", '~> 0'
  s.add_runtime_dependency "yajl-ruby", '~> 1.4.3'
end
