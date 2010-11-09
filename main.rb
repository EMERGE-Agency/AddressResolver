require 'sinatra'
require 'json'
require 'lib/dns_resolve'


post '/resolve_a_record_to_ip' do
  dnsresolve = DNSResolve.new
  result = {}
  JSON.parse(request.body.read).each do |record|
    puts "#{record.key}-#{record.value}"
    result.store(record.key, dnsresolve.resolve_a_record_to_IP(host_name))
  end
  content_type :json
  result.to_json
end
