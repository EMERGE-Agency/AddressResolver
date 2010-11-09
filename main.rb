require 'sinatra'
require 'json'
require 'lib/dns_resolve'


post '/resolve_a_record_to_ip' do
  dnsresolve = DNSResolve.new
  result = {}
  JSON.parse(request.body.read).each_pair do |key, host_name|
    puts "#{key}-#{host_name}"
    result.store(key, dnsresolve.resolve_a_record_to_IP(host_name))
  end
  content_type :json
  result.to_json
end
