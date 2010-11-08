require 'test/unit'
$LOAD_PATH << './lib'
require 'lib/dns_resolve'

class Test_DNS_Resolve < Test::Unit::TestCase
  def setup
    @dnsresolve = DNSResolve.new
  end
  
  def teardown
  end
  
  def test_resolve_a_record_to_IP
    result = @dnsresolve.resolve_a_record_to_IP("honey.com")
    assert_equal "209.240.81.150", result
  end
  
  def test_resolve_a_record_to_IP_bad_domain
    result = @dnsresolve.resolve_a_record_to_IP("www.hgjdkdldfaelkdfaer.com")
    assert_nil result
  end
end