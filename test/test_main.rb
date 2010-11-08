require 'rubygems'
require 'test/unit'
require 'rack/test'
require 'json'

$LOAD_PATH << './'
require 'main'

ENV['RACK_ENV'] = 'test'

class Test_Main < Test::Unit::TestCase
  include Rack::Test::Methods
  def app
     Main
  end

  def test_resolve_a_record_to_ip
    post '/resolve_a_record_to_ip', {:host_name => 'honey.com'}.to_json
    result = JSON.parse last_response.body
    assert result['ip_address']
  end
end