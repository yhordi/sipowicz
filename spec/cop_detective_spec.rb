describe CopDetective do
  let(:user) { User.create(name: 'Topher', password: 'supermanz') }
  let(:new_user) { User.new(name: 'Derek', password: 'Noodle') }
  let(:params) { {user: {password: 'Canadian Travis'}, confirmation: 'Canadian Travis', old_password: 'supermanz'} }
  let(:new_user_params) { {password: 'Noodle', confirmation: 'Noodle'} }

  describe '#set_keys' do
    it 'throws an error when passed something other than a hash' do
      expect{CopDetective.set_keys(1)}.to raise_error(RuntimeError, 'You must pass a hash to the set_keys method')
    end
    it "throws an error when the hash's keys are set incorrectly" do
      expect{CopDetective.set_keys({dingus: :yes, asdf: :no, asdf: :maybe})}.to raise_error(RuntimeError)
    end
    it "throws an error when the values of the hash are not symbols" do
      expect{CopDetective.set_keys({password: :password, confirmation: 'confirmation', old_password: 'old password'})}.to raise_error(RuntimeError, "Option passed to confirmation must be a symbol.")
    end
  end

  describe '#investigate' do
    before(:each) do
      CopDetective.set_keys({password: :password, confirmation: :confirmation, old_password: :old_password})
    end
    it 'creates a user in the database when passed the appropriate params' do
      CopDetective.investigate(new_user, new_user_params)
      expect(User.last).to eq(new_user)
    end
    it "updates a user's password when passed the appropriate params" do
      expect(CopDetective.investigate(user, params)).to eq('Password updated')
    end
  end
end