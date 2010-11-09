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
    Sinatra::Application
  end

  def test_resolve_a_record_to_ip
    post '/resolve_a_record_to_ip', {:honey_com => 'honey.com', :emergeinteractive_com => 'emergeinteractive.com'}.to_json
    result = JSON.parse last_response.body
    assert result.has_key? 'honey_com' && result.has_key? 'emergeinteractive_com'
  end
end