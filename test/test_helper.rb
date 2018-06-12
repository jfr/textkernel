$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'pry' unless ENV['CI']
require 'textkernel'

require 'minitest/autorun'

require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'test/vcr_cassettes'
  c.hook_into :webmock
  c.default_cassette_options = { :record => :once }
  c.filter_sensitive_data('<password>T0p53cret</password>') do
    "<password>#{ENV.fetch('TEXTKERNEL_KEY', 'secret')}</password>"
  end
end
