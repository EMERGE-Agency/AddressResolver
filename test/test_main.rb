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
    assert result.has_key?('honey.com') && result.has_key?('emergeinteractive.com')
    assert result['honey.com'] == '404' && result['emergeinteractive.com'] == '404'
  end
  
  def test_http_syntax
    input = ['honey.com', 'emergeinteractive.com'].to_json
    result = {}
    JSON.parse(input).each do |value|
      res = ""
      uri = URI.parse("http://www.#{value}")
      http_session = Net::HTTP.new(uri.host, uri.port)
      http_session.use_ssl = true if uri.port == 443
      http_session.start{|http|
        res = http.get('/?e=actionNotFoundBecauseItDontExist')
      }
      result[value] = res.code
    end
    assert result.has_key?('honey.com') && result.has_key?('emergeinteractive.com')
    assert result['honey.com'] === '404' && result['emergeinteractive.com'] === '404'
    
  end
end