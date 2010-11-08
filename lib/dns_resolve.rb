require 'resolv'

class DNSResolve
  def resolve_a_record_to_IP(name)
    dns = Resolv::DNS.new
    result = ""
    begin
      result = dns.getaddress(name).to_s      
    rescue Resolv::ResolvError
    end
    result
  end
end