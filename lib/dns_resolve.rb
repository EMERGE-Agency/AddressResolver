require 'resolv'

class DNSResolve
  def resolve_a_record_to_IP(name)
    dns = Resolv::DNS.new
    result = ""
    begin
      result = dns.getaddress(name).to_s      
    rescue DNSResolve::ResolvError => e
    end
    result
  end
end