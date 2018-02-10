require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'vcr_cassettes'
  c.hook_into :webmock
  c.default_cassette_options = { :record => :once }
  c.ignore_localhost = true
end