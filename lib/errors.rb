module Errors
  def self.unsaved_password(reason)
    "Your new password was not saved. #{reason}"
  end

  def self.invalid_password
    "You entered your original password incorrectly."
  end

  def self.non_matching
    "Your new passwords don't match."
  end

  def self.show_errors(model)
    flash[:error] = model.errors.full_messages
  end
end