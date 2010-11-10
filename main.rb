require 'sinatra'
require 'timeout'
require 'json'
require 'net/http'
require 'net/https'
require 'uri'
require 'lib/dns_resolve'


post '/resolve_a_record_to_ip' do
  dnsresolve = DNSResolve.new
  result = {}
  threads = []
  JSON.parse(request.body.read).each do |value|
    threads << Thread.new{
      ip = ""
      begin
        Timeout::timeout(2){ ip = dnsresolve.resolve_a_record_to_IP(value)}
      rescue Timeout::Error => e
        ip = ""
      end
      result.store(value, ip)
    }.join
  end
  
  content_type :json
  result.to_json
end

post '/get_page_response_code' do
  result = {}
  JSON.parse(request.body.read).each do |value|
    res = ""
    uri = URI.parse("http://www.#{value}")
    http_session = Net::HTTP.new(uri.host, uri.port)
    http_session.use_ssl = true if uri.port == 443
    http_session.start{|http|
      res = http.get('/?e=actionNotFoundBecauseItDontExist')
    }
    result[value] = res.code
  end
  content_type :json
  result.to_json
end