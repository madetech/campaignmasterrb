require "bundler"
Bundler.setup(:default, :test)

require "campaign_master"
require "webmock/rspec"
require "vcr"
require "rspec"

support_files = File.expand_path("spec/support/**/*.rb")
Dir[support_files].each { |file| require file }

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
end

RSpec.configure do |config|
  config.order = "random"
end
