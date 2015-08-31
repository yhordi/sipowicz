describe Sipowicz do
  let(:new_user) {User.create(name: 'Topher', password: 'supermanz')}
  let(:params) { {user: {password: 'Canadian Travis'}, confirmation: 'Canadian Travis', old_password: 'supermanz'} }
  let(:good_config) {
    Sipowicz.configure(
      {password: params[:user][:password], 
        confirmation: params[:confirmation],
        old_password: params[:old_password]
      })
  }

  describe '#configure' do
    context 'on good params' do
      it 'assigns sipowicz class variables' do
        expect(good_config).to eq('Canadian Travis')
      end
    end
    context 'on bad params' do
      it 'raises an error with nil params' do
        expect{Sipowicz.configure({password: nil, confirmation: nil})}.to raise_error(RuntimeError)
      end
      it 'raises an error when an empty string is passed' do
        expect{Sipowicz.configure({password: '', confirmation: ''})}.to raise_error(RuntimeError)
      end
    end
  end
  describe '#options_error' do
    it 'raises a nil option error with nil params' do
      expect{Sipowicz.configure({password: nil})}.to raise_error(RuntimeError, 'Option passed to password is nil.')
    end
    it 'raises an empty string error when an empty string is passed' do
      expect{Sipowicz.configure({password: 'hello', confirmation: 'alskdfj', old_password: ''})}.to raise_error(RuntimeError, 'Option passed to old_password is an empty string.')
    end
  end
  # describe '#valid_credentials?' do
  #   before(:each) do
  #     good_config
  #   end
  #   it 'returns true when passed an authentic user' do
  #     expect(Sipowicz.valid_credentials?(new_user)).to eq(true)
  #   end
  # end
  # describe '#new_passwords_match?' do
  #   it 'returns true if the user typed their password and confirmation correctly' do
  #     good_config
  #     expect(Sipowicz.new_passwords_match?).to eq(true)
  #   end
  #   it 'returns false if the user types their password or confirmation incorrectly' do
  #     Sipowicz.configure({password: params[:user][:password], confirmation: 'blargh'})
  #     expect(Sipowicz.new_passwords_match?).to eq(false)
  #   end
  # end
  describe '#validate_new_passwords' do
    describe 'with valid params' do
      before(:each) do
        good_config
      end
      it "responds with a success message" do
        Sipowicz.validate_new_passwords(new_user)
        p Sipowicz.messages
        expect(Sipowicz.messages[:notice]).to eq("Password updated")
      end
      it "updates a user's password" do
        Sipowicz.validate_new_passwords(new_user)
        expect(new_user.password).to eq('Canadian Travis')
      end
    end
    describe 'with invalid params' do
      it "responds with an error" do
        Sipowicz.configure({password: params[:user][:password], confirmation: 'blargh'})
        expect(Sipowicz.validate_new_passwords(new_user)).to eq("Your new password was not saved. Your new passwords don't match.")
      end
    end
  end
  describe '#update_user' do
    describe 'with valid params' do
      before(:each) do
        good_config
      end
      it 'calls #validate_new_passwords' do
        expect(Sipowicz.update_user(new_user)).to eq('Password updated')
      end
    end
    describe 'with invalid params' do
      before(:each) do
        Sipowicz.configure({password: params[:user][:password], confirmation: params[:confirmation], old_password: 'wrongo'})
      end
      it 'responds with an error message' do
        expect(Sipowicz.update_user(new_user)).to eq("Your new password was not saved. You entered your original password incorrectly.")
      end
    end
  end
end