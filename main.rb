require 'sinatra'
require 'timeout'
require 'json'
require 'lib/dns_resolve'


post '/resolve_a_record_to_ip' do
  dnsresolve = DNSResolve.new
  result = {}
  threads = []
  JSON.parse(request.body.read).each do |value|
    puts "Start #{value}";
    threads << Thread.new{
      puts "#{value}";
      ip = ""
      begin
        Timeout::timeout(2){ ip = dnsresolve.resolve_a_record_to_IP(value)}        
        puts "#{value}-#{ip}";  
      rescue Timeout::Error => e
        ip = ""
        puts "#{value}-error";  
      end
      result.store(value, ip)
    }.join
    puts "End #{value}";
  end
  
  content_type :json
  result.to_json
end
