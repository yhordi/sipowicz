describe CopDetective do
  let(:user) { User.create(name: 'Topher', password: 'supermanz') }
  let(:new_user) { User.new(name: 'Derek', password: 'Noodle') }
  let(:params) { {user: {password: 'Canadian Travis'}, confirmation: 'Canadian Travis', old_password: 'supermanz'} }
  
  let(:bad_params) { {user: {password: 'Canadian Travis'}, confirmation: 'Canadian Travis', old_password: 'sprmnz'} }
  let(:new_user_params) { {password: 'Noodle', confirmation: 'Noodle'} }

  let(:bad_new_user_params) { {password: 'Noodle', confirmation: 'Nodle'} }
  let!(:old_salt) { user.password_digest }

  describe '#set_keys' do
    context 'with bad params' do
      it 'throws an error when passed something other than a hash' do
        expect{CopDetective.set_keys(1)}.to raise_error(RuntimeError, 'You must pass a hash to the set_keys method')
      end
      it "throws an error when the hash's keys are set incorrectly" do
        expect{CopDetective.set_keys({dingus: :yes, asdf: :no, asdf: :maybe})}.to raise_error(RuntimeError)
      end
      it "throws an error when the values of the hash are not symbols or strings" do
        expect{CopDetective.set_keys({password: true, confirmation: 3, old_password: []})}.to raise_error(RuntimeError)
      end
    end
    context 'with good params' do
      it 'responds with the keys hash' do
        expect(CopDetective.set_keys({password: :password, confirmation: "confirmation", old_password: :old_password})).to eq({password: :password, confirmation: "confirmation", old_password: :old_password})
      end
    end
  end

  describe '#investigate' do
    before(:each) do
      CopDetective.set_keys({password: :password, confirmation: :confirmation, old_password: :old_password})
    end
    after(:each) do
      user.errors.delete(:password)
      new_user.errors.delete(:password)
    end
    context 'with good params' do
      it 'creates a user in the database when passed the appropriate params' do
        CopDetective.investigate(new_user, new_user_params)
        expect(User.last).to eq(new_user)
      end
      it "responds with a success message when updating a password" do
        expect(CopDetective.investigate(user, params)).to eq('Password updated')
      end
      it 'updates a the password of a user in the databse' do
        new_user.errors.delete(:password)
        CopDetective.investigate(user, params)
        expect(old_salt).to_not eq(user.password_digest)
      end
    end
    context 'with bad params' do
      it 'responds with an error message when attempting to update a user' do
        CopDetective.investigate(user, bad_params)
        expect(user.errors.get(:password)).to include("Your new password was not saved. You entered your original password incorrectly.")
      end
      it 'responds with an error message when attempting to create a user' do
        CopDetective.investigate(new_user, bad_new_user_params)
        expect(new_user.errors.get(:password)).to include("Passwords don't match or other params are not valid.")
      end
    end
  end
end