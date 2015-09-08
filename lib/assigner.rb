require 'active_support'
require 'active_record'

class CopDetectiveAssigner

  @@keychain = []
  @@params = Hash.new(nil)
  
  def build_params(params)
    params.each do |k, v|
      if v.is_a?(Hash)
        build_params(v)
      end
      @@params[k] = v if @@keychain.include?(k) 
    end
    p "Params built: " 
    p @@params
    translate_keys
  end

  def set_keychain
    @@keys.each do |k, v|
    @@keychain << v
    end
  end

  def translate_keys
    @@internal_keys = @@keys
    @@internal_keys.each do |k, v|
      @@internal_keys[k] = @@params[v]
    end
    configure
  end

  def configure
    @@old_password = @@internal_keys[:old_password]
    @@password = @@internal_keys[:password] || nil
    @@confirmation = @@internal_keys[:confirmation]
  end

end