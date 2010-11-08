require 'sinatra'
require 'json'
require 'lib/dns_resolve'


post '/resolve_a_record_to_ip' do
  dnsresolve = DNSResolve.new
  result = dnsresolve.resolve_a_record_to_IP(params[:host_name])
  content_type :json
  {:ip_address => result}.to_json
end
