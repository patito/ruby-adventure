require 'net/ldap'


class UserLdapAuth

    def initialize(config)
        @ldap_conf = config
        @ldap_conn = Net::LDAP.new(config)
    end


    def bind
        puts @ldap_conn.bind
    end

    def change_password(new_password)
        ops = [
            [:replace, :password, new_password]
        ]

        @ldap_conn.modify :dn => @ldap_conf[:auth][:username], :operations => ops
    end
end




config = {
    :host => "127.0.0.1",
    :port => "389",
    :auth => {
        :method => :simple,
        :username => "base_dn",
        :password => "cadibaitola"
    }
}

user = UserLdapAuth.new(config)
user.bind
user.change_password("cadibibinha")
