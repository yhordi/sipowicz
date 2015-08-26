class Sipowicz
  @@options_error = 'Options invalid. You must pass non empty strings for password and password confirmation'
  
  def self.configure(options)
    if options_valid?(options)
      @@password = options[:password]
      @@confirmation = options[:confirmation]
    end
  end

  def self.options_valid?(options)
    raise @@options_error if options[:password] == nil || options[:confirmation] == nil
    raise @@options_error if options[:password] == '' || options[:confirmation] == ''
    true
  end

  def self.valid_credentials?(user)
    user.authenticate(@@password) == user
  end

  def self.new_passwords_match?
    params[:user][:password] == params[:password_confirmation]
  end

  def self.validate_user(user)
    if valid_credentials?(user)
      validate_new_passwords(user)
    else
      flash[:error] = unsaved_password(invalid_password)
      false
    end
  end

  def self.fields_empty?
    params["user"]["password"].blank? && params["password"].blank? && params["password_confirmation"].blank?
  end

  def self.validation_redirect(user)
    if validate_user(user)
      redirect_to user_path(user.id)
    else
      redirect_to edit_user_path(user.id)
    end
  end

  def self.validate_new_passwords(user)
    if new_passwords_match?
      user.password = params[:user][:password]
      user.update_attributes(user_params)
      flash[:notice] = "Password updated"
      true
    else
      flash[:error] = unsaved_password(non_matching)
      false
    end
  end
end