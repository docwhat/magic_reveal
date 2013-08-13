require 'sys/admin'

module MagicReveal
  class Identifier
    attr_accessor :sys_admin

    def initialize sys_admin=nil
      @sys_admin = sys_admin || Sys::Admin
    end

    # Alias to make life easier.
    def self.name
      new.name
    end

    def name
      login = sys_admin.get_login
      user = sys_admin.get_user login

      return user.full_name if user.respond_to? :full_name
      gecos = user.gecos
      name = gecos.split(/\s*,\s*/).first
      if name.nil? || name.empty?
        return login
      else
        return name
      end
    end
  end
end
