lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "laposta/version"

Gem::Specification.new do |s|
  s.name        = 'laposta'
  s.version     = Laposta::VERSION
  s.date        = '2022-05-05'
  s.summary     = "Ruby client for Laposta API"
  s.description = "Ruby client for Laposta API"
  s.authors     = ["Niels van der Zanden"]
  s.email       = 'niels@phusion.nl'
  s.files       = ["lib/laposta.rb", "lib/laposta/client.rb", "lib/laposta/error.rb", "lib/laposta/version.rb"]
  s.files       += Dir.glob("lib/laposta/client/*.rb")
  s.files       += Dir.glob("lib/laposta/utils/*.rb")
  s.homepage    = 'https://github.com/phusion/laposta'
  s.license     = 'MIT'
  s.add_dependency 'http', '>= 2.2.1'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'webmock'
  s.add_development_dependency 'rake', '~> 12.0'
end
