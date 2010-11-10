require 'rubygems'
require 'test/unit'
require 'rack/test'
require 'json'
require 'net/http'
require 'net/https'
require 'uri'

$LOAD_PATH << './'
require 'main'

ENV['RACK_ENV'] = 'test'

class Test_Main < Test::Unit::TestCase
  include Rack::Test::Methods
  def app
    Sinatra::Application
  end

  def test_resolve_a_record_to_ip
    post '/resolve_a_record_to_ip', ['honey.com', 'emergeinteractive.com'].to_json
    result = JSON.parse last_response.body
    assert result.has_key?('honey.com') && result.has_key?('emergeinteractive.com')
  end
  
  def test_page_not_found_code_check
    post '/get_page_response_code', ['honey.com', 'emergeinteractive.com'].to_json
    result = JSON.parse last_response.body
    assert result.has_key?('honey.com') && result.has_key?('emergeinteractive.com') && result.has_key?('www.irispmt.com')
    assert  result['honey.com'] != '200' && result['emergeinteractive.com'] != '200' && result['www.irispmt.com'] != '200'
  end
end