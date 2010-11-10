require 'sinatra'
require 'timeout'
require 'json'
require 'lib/dns_resolve'


post '/resolve_a_record_to_ip' do
  dnsresolve = DNSResolve.new
  result = {}
  threads = []
  JSON.parse(request.body.read).each do |value|
    threads << Thread.new{
      puts "#{value}";
      ip = ""
      begin
        Timeout::timeout(2){ ip = dnsresolve.resolve_a_record_to_IP(value)}        
      rescue Timeout::Error => e
        ip = ""
        puts e
      end
      result.store(value, ip)
    }.join
  end
  
  content_type :json
  result.to_json
end
