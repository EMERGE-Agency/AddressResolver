require 'sinatra'
require 'timeout'
require 'json'
require 'lib/dns_resolve'


post '/resolve_a_record_to_ip' do
  dnsresolve = DNSResolve.new
  result = {}
  threads = []
  JSON.parse(request.body.read).each_pair do |key, value|
    threads << Thread.new{
      puts "#{key}-#{value}";
      ip = ""
      begin
        Timeout::timeout(2){ ip = dnsresolve.resolve_a_record_to_IP(value)}        
      rescue Timeout::Error
        ip = ""
      end
      result.store(key, ip)
    }.join
  end
  
  content_type :json
  result.to_json
end
