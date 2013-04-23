Gem::Specification.new do |s|
  s.name        = 'campaign_master'
  s.version     = '1.0.0'
  s.date        = '2012-04-23'
  s.summary     = "Interface to interact with the Campaign Master API"
  s.description = "Provides the ability to send subscribers to a Campaign Master email list"
  s.authors     = ["Chris Blackburn"]
  s.email       = 'chris@madebymade.co.uk'
  s.files       = ["lib/campaign_master.rb"]
  s.homepage    = 'https://github.com/madebymade/campaignmasterrb'

  s.require_path = "lib"

  s.add_development_dependency 'rspec',       '2.13.0'
  s.add_development_dependency 'rspec-mocks', '2.13.1'
  s.add_development_dependency 'webmock',     '2.9.0'
  s.add_development_dependency 'vcr',         '2.4.0'

  ignores  = File.readlines(".gitignore").grep(/\S+/).map(&:chomp)
  dotfiles = %w[.gitignore .travis.yml]
end
