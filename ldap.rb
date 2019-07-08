require 'rubygems'
require 'net/ldap'

ldap = Net::LDAP.new :host => 'localhost',
     :port => 389,
     :auth => {
           :method => :simple,
           :username => "cn=manager,dc=example,dc=com",
           :password => "opensesame"
     }

filter = Net::LDAP::Filter.eq( "cn", "George*" )
treebase = "dc=example,dc=com"

ldap.search( :base => treebase, :filter => filter ) do |entry|
  puts "DN: #{entry.dn}"
  entry.each do |attribute, values|
    puts "   #{attribute}:"
    values.each do |value|
      puts "      --->#{value}"
    end
  end
end

p ldap.get_operation_result
