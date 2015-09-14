require 'active_support'
require 'active_record'
require_relative 'cop_detective'
class CopDetectiveAssigner

  def initialize
    @params = Hash.new(nil)
    @keys = nil
    @keychain = []
    @internal_keys = nil
  end

  def build_params(params)
    params.each do |k, v|
      if v.is_a?(Hash)
        build_params(v)
      end
      @params[k] = v if @keychain.include?(k) 
    end
    @params
  end

  def assign(params, keys)
    set_keychain(keys)
    build_params(params)
    translate_keys
    configure
  end

  def set_keychain(keys)
    @keys = keys
    keys.each do |k, v|
      @keychain << v
    end
    @keychain
  end

  def translate_keys
    @internal_keys = @keys
    @internal_keys.each do |k, v|
      @internal_keys[k] = @params[v]
    end
    @internal_keys
  end

  def configure
    old_password = @internal_keys[:old_password] || nil
    password = @internal_keys[:password]
    confirmation = @internal_keys[:confirmation]
    CopDetective.configure({old_password: old_password, 
                            password: password, 
                            confirmation: confirmation})
  end
end