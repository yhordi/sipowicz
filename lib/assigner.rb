require 'active_support'
require 'active_record'
require_relative 'cop_detective'
class CopDetectiveAssigner

  @@keychain = []
  @@params = Hash.new(nil)

  class << self

    def build_params(params)
      @@keychain
      params.each do |k, v|
        if v.is_a?(Hash)
          build_params(v)
        end
        @@params[k] = v if @@keychain.include?(k) 
      end
      @@params
    end

    def assign(params)
      build_params(params)
      translate_keys
      configure
    end

    def set_keychain(keys)
      @@keys = keys
      keys.each do |k, v|
        @@keychain << v
      end
      @@keychain
    end

    def translate_keys
      @@internal_keys = @@keys
      @@internal_keys.each do |k, v|
        @@internal_keys[k] = @@params[v]
      end
      @@internal_keys
    end

    def configure
      old_password = @@internal_keys[:old_password]
      password = @@internal_keys[:password] || nil
      confirmation = @@internal_keys[:confirmation]
      CopDetective.configure({old_password: old_password, 
                              password: password, 
                              confirmation: confirmation})
    end
  end
end