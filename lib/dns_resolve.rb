require 'resolv'

class DNSResolve
  def resolve_a_record_to_IP(name)
    dns = Resolv::DNS.new
    dns.getaddress(name).to_s
  end
end